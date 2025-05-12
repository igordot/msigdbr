# Create a package-level environment for caching
pkg_env <- new.env(parent = emptyenv())

#' Download, cache, and load the gene sets database
#'
#' @param target_species Species abbreviation for human or mouse databases (`"HS"` or `"MM"`).
#' @param overwrite A logical indicating whether existing cached file should be overwritten.
#' @param verbose A logical indicating whether to print progress information.
#'
#' @return A data frame of gene sets and their member genes.
#'
#' @importFrom curl curl_download new_handle
#' @importFrom tools md5sum R_user_dir
#'
#' @noRd
load_msigdb_df <- function(target_species = c("HS", "MM"), overwrite = FALSE, verbose = FALSE) {
  target_species <- toupper(target_species)
  target_species <- match.arg(target_species)

  # Define source URL based on target species
  if (target_species == "HS") {
    file_url <- "https://zenodo.org/records/15377497/files/msigdb.2024.1.Hs.rds?download=1"
    file_md5 <- "ff43b9132477cbdff7243cbf3574b816"
  }
  if (target_species == "MM") {
    file_url <- "https://zenodo.org/records/15377497/files/msigdb.2024.1.Mm.rds?download=1"
    file_md5 <- "dc60894e71d8e14e5bd0022834cca77f"
  }

  # Create a directory to hold the data
  cache_dir <- tools::R_user_dir(package = "msigdbr", which = "cache")
  if (!dir.exists(cache_dir)) {
    if (verbose) {
      message("Creating directory to hold data at: ", cache_dir)
    }
    dir.create(cache_dir, showWarnings = FALSE, recursive = TRUE)
  }

  # Download the file if it is not already cached
  file_name <- basename(file_url)
  file_name <- sub("\\?.*$", "", file_name)
  file_path <- file.path(cache_dir, file_name)
  if (!file.exists(file_path) || overwrite) {
    if (verbose) {
      message("Downloading data to: ", file_path)
    }
    curl::curl_download(
      url = file_url,
      destfile = file_path,
      quiet = verbose,
      handle = curl::new_handle(timeout = 300)
    )

    # Verify download
    if (tools::md5sum(file_path) != file_md5) {
      file.remove(file_path)
      stop("Downloaded file does not match the expected checksum.")
    }
  }

  if (!file.exists(file_path)) {
    stop("Data file not found: ", file_path)
  }

  # Load data if already in memory cache
  if (exists(file_name, envir = pkg_env, inherits = FALSE)) {
    if (verbose) {
      message("Loading data from cache.")
    }
    return(pkg_env[[file_name]])
  }

  # Read RDS file and cache the data frame
  if (verbose) {
    message("Loading data from: ", file_path)
  }
  mdb <- readRDS(file_path)
  pkg_env[[file_name]] <- mdb
  return(mdb)
}
