#' Check that the data package is installed
#'
#' Check that the 'msigdbdf' data package is installed.
#' If not, provide instructions for installation.
#' A dependency listed in DESCRIPTION Suggests is not guaranteed to be installed.
#'
#' @param require_data Stop execution if the data package is not installed.
#'
#' @importFrom utils install.packages menu
msigdbr_check_data <- function(require_data = TRUE) {
  # Manual installation instructions
  install_instructions <- paste0(
    "Please run the following command to install the 'msigdbdf' package:\n",
    "install.packages('msigdbdf', repos = 'https://igordot.r-universe.dev')"
  )

  # Error message if installation fails
  error_message <- function(e) {
    message(e)
    cat(paste0("\nInstallation failed.\n", install_instructions, "\n"))
  }

  # Check if installed
  if (!rlang::is_installed("msigdbdf")) {
    message("The 'msigdbdf' package must be installed to access the full dataset.")

    # Try to install automatically if it's an interactive R session
    if (interactive()) {
      if (utils::menu(c("Yes", "No"), title = "Would you like to install 'msigdbdf'?") == 1) {
        message("Installing the 'msigdbdf' package.")
        tryCatch(
          utils::install.packages(
            "msigdbdf",
            repos = c("https://igordot.r-universe.dev", getOption("repos"))
          )
        )
      }
    }
  }

  # Check if not installed after attempted interactive installation
  if (!rlang::is_installed("msigdbdf")) {
    # Show instructions if not installed
    if (require_data) {
      stop(install_instructions)
    } else {
      message(install_instructions)
    }
  }

  invisible()
}
