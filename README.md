# msigdbr: MSigDB Gene Sets for Multiple Organisms in a Tidy Data Format

[![CRAN](https://www.r-pkg.org/badges/version/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![CRAN downloads](https://cranlogs.r-pkg.org/badges/last-month/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![R-CMD-check](https://github.com/igordot/msigdbr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/igordot/msigdbr/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/igordot/msigdbr/graph/badge.svg)](https://app.codecov.io/gh/igordot/msigdbr)

## Overview

The msigdbr R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software:

* in an R-friendly "[tidy](https://r4ds.had.co.nz/tidy-data.html)" format with one gene pair per row
* for multiple frequently studied model organisms, such as mouse, rat, pig, zebrafish, fly, and yeast, in addition to the original human genes
* as gene symbols as well as NCBI Entrez and Ensembl IDs
* without accessing external resources requiring an active internet connection

## Installation

The package can be installed from [CRAN](https://cran.r-project.org/package=msigdbr).

```r
install.packages("msigdbr")
```

Recent [releases](https://github.com/igordot/msigdbr/releases) are not available on CRAN and can be installed from GitHub (specific version can be specified):

```r
remotes::install_github("igordot/msigdbr", ref = "v2022.1.1")
```

## Usage

The package data can be accessed using the `msigdbr()` function, which returns a data frame of gene sets and their member genes.
For example, you can retrieve mouse genes from the C2 (curated) CGP (chemical and genetic perturbations) gene sets.

```r
library(msigdbr)
genesets <- msigdbr(species = "mouse", category = "C2", subcategory = "CGP")
```

Check the [documentation website](https://igordot.github.io/msigdbr/articles/msigdbr-intro.html) for more information.
