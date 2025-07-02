## Overview

The msigdbr R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software:

* in an R-friendly "[tidy](https://r4ds.had.co.nz/tidy-data.html)" format with one gene pair per row
* for multiple frequently studied model organisms, such as mouse, rat, pig, zebrafish, fly, and yeast, in addition to the original human genes
* as gene symbols as well as NCBI Entrez and Ensembl IDs
* without accessing external resources requiring an active internet connection

## Usage

The package can be installed from [CRAN](https://cran.r-project.org/package=msigdbr).

```r
install.packages("msigdbr")
```

The data can be accessed using the `msigdbr()` function, which returns a data frame of gene sets and their member genes.
For example, you can retrieve mouse genes from the C2 (curated) CGP (chemical and genetic perturbations) gene sets.

```r
library(msigdbr)
genesets <- msigdbr(species = "mouse", collection = "C2", subcollection = "CGP")
```
