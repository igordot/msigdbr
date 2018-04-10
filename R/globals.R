# fix R CMD Check notes (for CRAN compatibility)
# https://stackoverflow.com/q/9439256/265614
# https://github.com/r-lib/devtools/issues/1714
# https://community.rstudio.com/t/tidyeval-equivalent-of-mutate/1295
utils::globalVariables(c(".", ".data"))
