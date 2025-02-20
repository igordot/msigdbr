#' Check that the data package is installed
#'
#' Check that the 'msigdbdf' data package is installed.
#' If not, provide instructions for installation.
#' A dependency listed in DESCRIPTION Suggests is not guaranteed to be installed.
#'
#' @importFrom utils install.packages menu
msigdbr_check_data <- function() {
  if (!requireNamespace("msigdbdf", quietly = TRUE)) {
    message("The 'msigdbdf' package must be installed to access the full dataset.")

    install_instructions <- paste0(
      "Please run the following command to install the 'msigdbdf' package:\n",
      "install.packages('msigdbdf', repos = 'https://igordot.r-universe.dev')"
    )

    error_message <- function(e) {
      message(e)
      cat(paste0("\nFailed to install the 'msigdbdf' package.\n", install_instructions, "\n"))
    }

    if (interactive()) {
      # If running R interactively
      input <- utils::menu(c("Yes", "No"), title = "Would you like to install 'msigdbdf'?")
      if (input == 1) {
        # Answered "Yes"
        message("Installing the 'msigdbdf' package.")
        tryCatch(
          utils::install.packages("msigdbdf", repos = c("https://igordot.r-universe.dev", getOption("repos"))),
          error = error_message, warning = error_message
        )
      } else {
        # Answered "No"
        stop(install_instructions)
      }
    } else {
      # If not running R interactively
      stop(install_instructions)
    }
  }
}
