## msigdbr: MSigDB data frame

The msigdbr package provides Molecular Signatures Database (MSigDB) gene sets in a tidy R data frame.

The data can be accessed using the `msigdbr()` function, which returns a data frame of gene sets and their member genes.

```r
genesets <- msigdbr()
```

You can convert the original human genes to their orthologs in other organisms, such as mouse.

```r
genesets <- msigdbr(species = "mouse")
```

You can retrieve gene sets from a specific collection, such as the Hallmark gene sets.

```r
genesets <- msigdbr(species = "mouse", collection = "H")
```

Check the [full overview](articles/msigdbr-intro.html) for more information.
