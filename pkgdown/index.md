## Overview

The msigdbr R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software.

The data can be accessed using the `msigdbr()` function, which returns a data frame of gene sets and their member genes.

```r
genesets <- msigdbr()
```

You can convert the original human genes to their orthologs in various model organisms, such as mouse.

```r
mm_genesets <- msigdbr(species = "mouse")
```

You can retrieve data just for a specific collection, such as the Hallmark gene sets.

```r
h_genesets <- msigdbr(species = "mouse", collection = "H")
```

Check the [full overview](articles/msigdbr-intro.html) for more information.
