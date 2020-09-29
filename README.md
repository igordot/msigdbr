# msigdbr: MSigDB Gene Sets for Multiple Organisms in a Tidy Data Format

[![CRAN](http://www.r-pkg.org/badges/version/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![R build status](https://github.com/igordot/msigdbr/workflows/R-CMD-check/badge.svg)](https://github.com/igordot/msigdbr/actions)
[![Travis Build Status](https://travis-ci.com/igordot/msigdbr.svg?branch=master)](https://travis-ci.com/igordot/msigdbr)
[![codecov](https://codecov.io/gh/igordot/msigdbr/branch/master/graph/badge.svg)](https://codecov.io/gh/igordot/msigdbr)

## Overview

The `msigdbr` R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software:

* in an R-friendly format (a data frame in a "long" format with one gene per row)
* for multiple frequently studied model organisms (human, mouse, rat, pig, fly, yeast, etc.)
* as both gene symbols and Entrez Gene IDs (for better compatibility with pathway enrichment tools)
* that can be used in a script without requiring additional external files

Details and examples are described in the [vignette](https://CRAN.R-project.org/package=msigdbr/vignettes/msigdbr-intro.html).


