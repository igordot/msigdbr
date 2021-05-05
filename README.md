# msigdbr: MSigDB Gene Sets for Multiple Organisms in a Tidy Data Format

[![CRAN](http://www.r-pkg.org/badges/version/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![R build status](https://github.com/igordot/msigdbr/workflows/R-CMD-check/badge.svg)](https://github.com/igordot/msigdbr/actions)
[![codecov](https://codecov.io/gh/igordot/msigdbr/branch/master/graph/badge.svg)](https://codecov.io/gh/igordot/msigdbr)

## Overview

The `msigdbr` R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software:

* in an R-friendly tidy/long format with one gene per row
* for multiple frequently studied model organisms, such as mouse, rat, pig, zebrafish, fly, and yeast, in addition to the original human genes
* as gene symbols as well as NCBI Entrez and Ensembl IDs
* that can be installed and loaded as a package without requiring additional external files

## Installation

The package can be installed from [CRAN](https://cran.r-project.org/package=msigdbr).

```{r}
install.packages("msigdbr")
```

## Usage

The package data can be accessed using the `msigdbr()` function, which returns a data frame of gene sets and their member genes. For example, you can retrieve mouse genes from the C2 (curated) CGP (chemical and genetic perturbations) gene sets.

```{r}
genesets = msigdbr(species = "Mus musculus", category = "C2", subcategory = "CGP")
```

Check the [documentation website](https://igordot.github.io/msigdbr/) for more information.
