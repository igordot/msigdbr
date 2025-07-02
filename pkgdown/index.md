## Overview

The msigdbr R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software.

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

Check the [full overview](articles/msigdbr-intro.html) for more information about the package.
