# msigdbr: MSigDB Gene Sets for Multiple Organisms in a Tidy Data Format

[![CRAN](http://www.r-pkg.org/badges/version/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![Travis Build Status](https://travis-ci.org/igordot/msigdbr.svg?branch=master)](https://travis-ci.org/igordot/msigdbr)
[![codecov](https://codecov.io/gh/igordot/msigdbr/branch/master/graph/badge.svg)](https://codecov.io/gh/igordot/msigdbr)

## Overview

The `msigdbr` R package provides Molecular Signatures Database (MSigDB) gene sets typically used with the Gene Set Enrichment Analysis (GSEA) software:

* in an R-friendly format (a data frame in a "long" format with one gene per row)
* for multiple frequently studied model organisms (human, mouse, rat, pig, fly, yeast, etc.)
* as both gene symbols and Entrez Gene IDs (for better compatibility with pathway enrichment tools)
* that can be used in a script without requiring additional external files

Details and examples are described in the [vignette](https://CRAN.R-project.org/package=msigdbr/vignettes/msigdbr-intro.html).

## Installation

The package can be installed from CRAN.

```r
install.packages("msigdbr")
```

## Usage

Load package.

```r
library(msigdbr)
```

Check the available species.

```r
msigdbr_show_species()
#>  [1] "Bos taurus"               "Caenorhabditis elegans"   "Canis lupus familiaris"  
#>  [4] "Danio rerio"              "Drosophila melanogaster"  "Gallus gallus"           
#>  [7] "Homo sapiens"             "Mus musculus"             "Rattus norvegicus"       
#> [10] "Saccharomyces cerevisiae" "Sus scrofa"
```

Retrieve all human gene sets.

```r
m_df = msigdbr(species = "Homo sapiens")
head(m_df)
#> # A tibble: 6 x 9
#>   gs_name    gs_id gs_cat gs_subcat human_gene_symb… species_name entrez_gene gene_symbol
#>   <chr>      <chr> <chr>  <chr>     <chr>            <chr>              <int> <chr>      
#> 1 AAACCAC_M… M126… C3     MIR       ABCC4            Homo sapiens       10257 ABCC4      
#> 2 AAACCAC_M… M126… C3     MIR       ACTN4            Homo sapiens          81 ACTN4      
#> 3 AAACCAC_M… M126… C3     MIR       ACVR1            Homo sapiens          90 ACVR1      
#> 4 AAACCAC_M… M126… C3     MIR       ADAM9            Homo sapiens        8754 ADAM9      
#> 5 AAACCAC_M… M126… C3     MIR       ADAMTS5          Homo sapiens       11096 ADAMTS5    
#> 6 AAACCAC_M… M126… C3     MIR       AGER             Homo sapiens         177 AGER       
#> # ... with 1 more variable: sources <chr>
```

Retrieve mouse hallmark collection gene sets.

```r
m_df = msigdbr(species = "Mus musculus", category = "H")
head(m_df)
#> # A tibble: 6 x 9
#>   gs_name    gs_id gs_cat gs_subcat human_gene_symb… species_name entrez_gene gene_symbol
#>   <chr>      <chr> <chr>  <chr>     <chr>            <chr>              <int> <chr>      
#> 1 HALLMARK_… M5905 H      ""        ABCA1            Mus musculus       11303 Abca1      
#> 2 HALLMARK_… M5905 H      ""        ABCB8            Mus musculus       74610 Abcb8      
#> 3 HALLMARK_… M5905 H      ""        ACAA2            Mus musculus       52538 Acaa2      
#> 4 HALLMARK_… M5905 H      ""        ACADL            Mus musculus       11363 Acadl      
#> 5 HALLMARK_… M5905 H      ""        ACADM            Mus musculus       11364 Acadm      
#> 6 HALLMARK_… M5905 H      ""        ACADS            Mus musculus       11409 Acads      
#> # ... with 1 more variable: sources <chr>
```


