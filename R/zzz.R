.onAttach <- function(libname, pkgname) {
  if (!requireNamespace("msigdbdf", quietly = TRUE)) {
    packageStartupMessage(
      "To access all the data, please install the 'msigdbdf' package with:\n",
      "install.packages('msigdbdf', repos = 'https://igordot.r-universe.dev')"
    )
  }
}
