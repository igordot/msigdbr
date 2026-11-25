# Create a package-level environment for caching
# To check environment contents: ls(msigdbr:::pkg_env)
pkg_env <- new.env(parent = emptyenv())

# download_zip() and resolve_cache() share the filename
release <- list(
  url = "https://zenodo.org/records/18968178/files/msigdb.2026.1.zip?download=1",
  zip_name = "msigdb.2026.1.zip",
  md5 = "512ba99c6827141a9d471972b812d4ac"
)

#' Load the gene sets database
#'
#' @param target_species Species abbreviation for human or mouse databases (`"HS"` or `"MM"`).
#' @param collection Collection abbreviation (e.g., `"C1"`, `"H"`). If `NULL`, all collections for the species are loaded.
#' @param overwrite A logical indicating whether existing cached files should be overwritten.
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return A data frame of gene sets and their member genes.
#'
#' @noRd
load_gene_sets <- function(
  target_species = c("HS", "MM"),
  collection = NULL,
  overwrite = FALSE,
  verbose = FALSE
) {
  target_species <- match.arg(toupper(target_species), choices = c("HS", "MM"))

  summary_rds <- resolve_cache(overwrite = overwrite, verbose = verbose)

  # Read the data summary table
  summary <- read_cached_rds(summary_rds, verbose = verbose)

  # Simplify summary table
  summary <- dplyr::distinct(
    summary,
    .data$db_target_species,
    .data$gs_collection,
    .data$df_rds
  )

  # Filter summary table by species
  summary <- summary[summary$db_target_species == target_species, ]

  # Filter summary table by collection
  if (!is.null(collection)) {
    summary <- summary[summary$gs_collection == collection, ]
    if (nrow(summary) == 0) {
      stop(
        "Unknown collection (use `msigdbr_collections()` to see the available options): ",
        collection
      )
    }
  }

  # Load each collection RDS (from memory cache or disk)
  dfs <- lapply(summary$df_rds, function(rds) {
    read_cached_rds(rds, verbose = verbose)
  })
  dplyr::bind_rows(dfs)
}

#' Ensure a verified copy of the release zip is in the destination directory
#'
#' @param dir Directory to download the zip archive to.
#' @param overwrite A logical indicating whether an existing zip should be overwritten.
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return The zip archive's path.
#'
#' @noRd
download_zip <- function(dir, overwrite = FALSE, verbose = FALSE) {
  zip_path <- file.path(dir, release$zip_name)

  # Replace corrupt ZIPs or force a fresh download when requested
  if (
    overwrite ||
      (file.exists(zip_path) &&
        !isTRUE(unname(tools::md5sum(zip_path)) == release$md5))
  ) {
    if (unlink(zip_path) != 0L) {
      stop("Could not remove cached zip file: ", zip_path)
    }
  }

  # Reuse the cached zip only if its checksum passed
  if (!file.exists(zip_path)) {
    message("Downloading gene sets (usually only on first use).")

    # Download to a temp file to prevent partial downloads from being cached
    tmp_path <- tempfile(fileext = ".zip")
    on.exit(unlink(tmp_path), add = TRUE)

    # Retry on transient failures
    for (attempt in 1:3) {
      dl_error <- tryCatch(
        {
          # Stop after 2 min below 1 KiB/s or 30 min total per attempt
          curl::curl_download(
            url = release$url,
            destfile = tmp_path,
            quiet = !verbose,
            handle = curl::new_handle(
              low_speed_limit = 1024,
              low_speed_time = 120,
              timeout = 1800
            )
          )
          NULL
        },
        error = function(e) e
      )
      if (is.null(dl_error)) {
        break
      }
      if (attempt == 3) {
        stop(
          "Could not download gene sets: ",
          conditionMessage(dl_error),
          call. = FALSE
        )
      }
      message(
        "Download attempt ",
        attempt,
        "/3 failed: ",
        conditionMessage(dl_error)
      )
      Sys.sleep(5)
    }

    # Check the checksum of the zip file (md5sum() returns NA if unreadable)
    if (!isTRUE(unname(tools::md5sum(tmp_path)) == release$md5)) {
      stop("Downloaded zip file failed checksum verification.")
    }

    # Skip the move if another process already populated the cache
    if (!file.exists(zip_path)) {
      if (verbose) {
        message("Moving zip archive to: ", zip_path)
      }
      # Copy into the destination dir then rename to avoid cross-device move fails
      if (!file.rename(tmp_path, zip_path)) {
        staging_path <- tempfile(tmpdir = dir, fileext = ".zip")
        on.exit(unlink(staging_path), add = TRUE)
        if (!file.copy(tmp_path, staging_path, overwrite = TRUE)) {
          stop(
            "Failed to copy the downloaded zip into the destination directory."
          )
        }
        if (!file.rename(staging_path, zip_path)) {
          stop("Failed to rename the zip.")
        }
      }
    }
  }

  zip_path
}

#' Resolve the local cache for the gene sets data, downloading if needed
#'
#' @param overwrite A logical indicating whether existing cached files should be overwritten.
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return The summary RDS filename.
#'
#' @noRd
resolve_cache <- function(overwrite = FALSE, verbose = FALSE) {
  # Create a directory to hold the data
  cache_dir <- tools::R_user_dir(package = "msigdbr", which = "cache")
  if (!dir.exists(cache_dir)) {
    if (verbose) {
      message("Creating data cache directory at: ", cache_dir)
    }
    dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
  }

  summary_rds <- sub("\\.zip$", ".summary.rds", release$zip_name)
  summary_path <- file.path(cache_dir, summary_rds)

  cache_complete <- function() {
    file.exists(summary_path) &&
      all(file.exists(file.path(
        cache_dir,
        read_release_rds(summary_path, verbose)$df_rds
      )))
  }

  # Remove the summary to force re-extraction when overwriting
  if (overwrite) {
    unlink(summary_path)
  }

  # Re-extract if any expected file is missing
  if (overwrite || !cache_complete()) {
    rm(list = ls(pkg_env, all.names = TRUE), envir = pkg_env)
    zip_path <- download_zip(
      cache_dir,
      overwrite = overwrite,
      verbose = verbose
    )

    if (verbose) {
      message("Extracting zip archive to: ", cache_dir)
    }
    utils::unzip(zip_path, exdir = cache_dir)
  }

  if (!cache_complete()) {
    stop("Cache directory is corrupt (delete it): ", cache_dir)
  }

  summary_rds
}

#' Read a cached release RDS file
#'
#' @param x Path to the cached RDS file.
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return The object stored in the RDS file.
#'
#' @noRd
read_release_rds <- function(x, verbose) {
  read <- function() {
    tryCatch(readRDS(x), warning = identity, error = identity)
  }
  result <- read()
  if (!inherits(result, "condition")) {
    return(result)
  }

  cache_dir <- dirname(x)
  archive <- download_zip(cache_dir, verbose = verbose)
  utils::unzip(archive, files = basename(x), exdir = cache_dir)
  result <- read()
  if (inherits(result, "condition")) {
    stop(
      "Could not read ",
      x,
      " after repair: ",
      conditionMessage(result),
      call. = FALSE
    )
  }
  result
}

#' Read an RDS file with in-memory caching
#'
#' @param x RDS filename (used as the cache key).
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return The object stored in the RDS file.
#'
#' @noRd
read_cached_rds <- function(x, verbose = FALSE) {
  if (!exists(x, envir = pkg_env, inherits = FALSE)) {
    rds_path <- file.path(tools::R_user_dir("msigdbr", "cache"), x)
    if (!file.exists(rds_path)) {
      stop("RDS not found: ", rds_path)
    }
    if (verbose) {
      message("Reading RDS: ", rds_path)
    }
    pkg_env[[x]] <- read_release_rds(rds_path, verbose)
  }
  pkg_env[[x]]
}
