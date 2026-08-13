# Create a package-level environment for caching
# To check environment contents: ls(msigdbr:::pkg_env)
pkg_env <- new.env(parent = emptyenv())

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

  data_info <- check_cache(overwrite = overwrite, verbose = verbose)

  # Read the data summary table
  summary <- read_cached_rds(data_info$summary_rds, verbose = verbose)

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

#' Ensure the gene sets data frames are available in the local cache directory
#'
#' @param overwrite A logical indicating whether existing cached files should be overwritten.
#' @param verbose A logical indicating whether to print progress information.
#' @param timeout Maximum time in seconds for the download to complete.
#'
#' @return A list of information about the data release.
#'
#' @noRd
check_cache <- function(overwrite = FALSE, verbose = FALSE, timeout = 600) {
  # Define information for the current version of the data
  release <- list(
    zip_url = "https://zenodo.org/records/18968178/files/msigdb.2026.1.zip?download=1",
    zip_md5 = "512ba99c6827141a9d471972b812d4ac"
  )

  # Create a directory to hold the data
  release$cache_dir <- tools::R_user_dir(package = "msigdbr", which = "cache")
  if (!dir.exists(release$cache_dir)) {
    if (verbose) {
      message("Creating data cache directory at: ", release$cache_dir)
    }
    dir.create(release$cache_dir, showWarnings = FALSE, recursive = TRUE)
  }

  # Download and extract the zip if the manifest is not already cached
  zip_name <- sub("\\?.*$", "", basename(release$zip_url))
  zip_path <- file.path(release$cache_dir, zip_name)
  if (!file.exists(zip_path) || overwrite) {
    if (verbose) {
      message("Downloading zip archive to: ", zip_path)
    }
    # Download to a temp file to prevent partial downloads from being cached
    tmp_path <- tempfile(fileext = ".zip")
    on.exit(unlink(tmp_path), add = TRUE)
    curl::curl_download(
      url = release$zip_url,
      destfile = tmp_path,
      quiet = !verbose,
      handle = curl::new_handle(timeout = timeout)
    )

    # Move zip file to the final location if the checksum matches
    if (tools::md5sum(tmp_path) != release$zip_md5) {
      stop("Downloaded zip file does not match the expected checksum.")
    }

    # Skip if another process already finished populating the cache
    if (!file.exists(zip_path) || overwrite) {
      if (verbose) {
        message("Moving zip archive to: ", zip_path)
      }
      # file.rename() fails silently across filesystems
      if (!file.rename(tmp_path, zip_path)) {
        if (verbose) {
          message("Rename failed, falling back to file copy.")
        }
        file.copy(tmp_path, zip_path, overwrite = TRUE)
      }

      # Extract files from the zip archive
      if (verbose) {
        message("Extracting zip archive to: ", release$cache_dir)
      }
      utils::unzip(zip_path, exdir = release$cache_dir)
    }
  }

  # Check that the expected summary file exists
  release$summary_rds <- sub(".zip$", ".summary.rds", zip_name)
  summary_path <- file.path(release$cache_dir, release$summary_rds)
  if (!file.exists(summary_path)) {
    stop("Expected summary file not found after extraction: ", summary_path)
  }

  return(release)
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
    pkg_env[[x]] <- readRDS(rds_path)
  }
  pkg_env[[x]]
}
