# msigdbr: MSigDB for Multiple Organisms in a Tidy Data Format

[![CRAN](http://www.r-pkg.org/badges/version/msigdbr)](https://cran.r-project.org/package=msigdbr)
[![Travis Build Status](https://travis-ci.org/igordot/msigdbr.svg?branch=master)](https://travis-ci.org/igordot/msigdbr)
[![codecov](https://codecov.io/gh/igordot/msigdbr/branch/master/graph/badge.svg)](https://codecov.io/gh/igordot/msigdbr)

## Overview

Most people who work with genomic data are eventually tasked with performing pathway analysis.
The majority of pathways analysis software tools are R-based.
Depending on the tool, it may be necessary to import the pathways into R, translate genes to the appropriate species, convert between symbols and IDs, and format the object in the required way.

The goal of `msigdbr` is to provide MSigDB gene sets:

* for various frequently studied model organisms
* in an R-friendly format (a data frame in a "long" format with one gene per row)
* as both gene symbols and Entrez Gene IDs
* that can be used and shared in a script without requiring additional files

## Installation

```r
install.packages("msigdbr")
```

## Usage

Load package.

```r
library(msigdbr)
```

Check the species available in the database.

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

The gene sets data frame can also be manipulated manually.

```r
m_df = msigdbr(species = "Mus musculus") %>% dplyr::filter(gs_cat == "H")
```

## Integrating with Pathway Analysis Packages

Use the gene sets data frame for `clusterProfiler` (for genes as Entrez Gene IDs).

```r
m_t2g = m_df %>% dplyr::select(gs_name, entrez_gene) %>% as.data.frame()
enricher(gene = genes_entrez, TERM2GENE = m_t2g, ...)
```

Use the gene sets data frame for `clusterProfiler` (for genes as gene symbols).

```r
m_t2g = m_df %>% dplyr::select(gs_name, gene_symbol) %>% as.data.frame()
enricher(gene = genes_symbols, TERM2GENE = m_t2g, ...)
```

Use the gene sets data frame for `fgsea`.

```r
m_list = m_df %>% split(x = .$gene_symbol, f = .$gs_name)
fgsea(pathways = m_list, ...)
```

## Questions and Concerns

Which version of MSigDB was used?

> This package was generated with MSigDB v6.1 (released October 2017).
> The MSigDB version is used as the base of the package version. You can check with `packageVersion("msigdbr")`.

Can't I just download the gene sets from MSigDB?

> Yes.
> You can then import the GMTs with something like `getGmt()` from the `GSEABase` package.
> Only human genes are available, even for gene sets generated with mouse data.
> If you are not working with human data, you then have to convert the MSigDB genes to your organism or your genes to human.

Can't I just convert between human and mouse genes by adjusting gene capitalization?

> That will work for most genes, but not all.

Can't I just convert human genes to any organism myself?

> Yes.
> A popular method is using the `biomaRt` package.
> You may still end up with dozens of homologs for some genes, so additional cleanup may be helpful.

Aren't there already other similar tools?

> There are a few other resources that and provide some of the functionality and served as an inspiration for this package.
> [Ge Lab Gene Set Files](http://ge-lab.org/#/data) has GMT files for many species.
> According the log, it was last updated in 2013 (as of April 2018) so the gene sets may be outdated.
> [WEHI](http://bioinf.wehi.edu.au/software/MSigDB/) provides MSigDB gene sets in R format for human and mouse, but the genes are provided only as Entrez IDs, each collection is a separate file, and the database is not actively maintained (last updated in October 2016 as of April 2018).
> [MSigDF](https://github.com/stephenturner/msigdf) is based on the WEHI resource, so it provides the same data, but it is converted to a more tidyverse-friendly data frame.

## Details

The Molecular Signatures Database (MSigDB) is a collection of gene sets originally created for use with the Gene Set Enrichment Analysis (GSEA) software.

Gene homologs are provided by HUGO Gene Nomenclature Committee at the European Bioinformatics Institute which integrates the orthology assertions predicted for human genes by eggNOG, Ensembl Compara, HGNC, HomoloGene, Inparanoid, NCBI Gene Orthology, OMA, OrthoDB, OrthoMCL, Panther, PhylomeDB, TreeFam and ZFIN.
For each human equivalent within each species, only the ortholog supported by the largest number of databases is used.


