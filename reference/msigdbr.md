# Retrieve the gene sets data frame

Retrieve a data frame of gene sets and their member genes. The original
human genes can be converted into their corresponding counterparts in
various model organisms, including mouse, rat, pig, zebrafish, fly, and
yeast. The output includes gene symbols along with NCBI and Ensembl IDs.

## Usage

``` r
msigdbr(
  db_species = "HS",
  species = "human",
  collection = NULL,
  subcollection = NULL,
  category = deprecated(),
  subcategory = deprecated()
)
```

## Arguments

- db_species:

  Species abbreviation for the human or mouse databases (`"HS"` or
  `"MM"`).

- species:

  Species name for output genes, such as `"Homo sapiens"` or
  `"Mus musculus"`. Both scientific and common names are acceptable. Use
  [`msigdbr_species()`](https://igordot.github.io/msigdbr/reference/msigdbr_species.md)
  to see the available options.

- collection:

  Collection abbreviation, such as `"H"` or `"C1"`. Use
  [`msigdbr_collections()`](https://igordot.github.io/msigdbr/reference/msigdbr_collections.md)
  to see the available options.

- subcollection:

  Sub-collection abbreviation, such as `"CGP"` or `"BP"`. Use
  [`msigdbr_collections()`](https://igordot.github.io/msigdbr/reference/msigdbr_collections.md)
  for the available options.

- category:

  **\[deprecated\]** use the `collection` argument

- subcategory:

  **\[deprecated\]** use the `subcollection` argument

## Value

A tibble (a data frame with class
[`tibble::tbl_df`](https://tibble.tidyverse.org/reference/tbl_df-class.html))
of gene sets with one gene per row.

## Details

Historically, the MSigDB resource has been tailored to the analysis of
human-specific datasets, with gene sets exclusively aligned to the human
genome. Starting with release 2022.1, MSigDB incorporated a database of
mouse-native gene sets and was split into human and mouse divisions
("Hs" and "Mm"). Each one is provided in the approved gene symbols of
its respective species.

Mouse MSigDB includes gene sets curated from mouse-centric datasets and
specified in native mouse gene identifiers, eliminating the need for
ortholog mapping.

## References

<https://www.gsea-msigdb.org/gsea/msigdb/index.jsp>

## Examples

``` r
# Get all human gene sets
gs <- msigdbr()
#> Downloading gene sets (first use only, may take a few minutes)...
head(gs)
#> # A tibble: 6 × 20
#>   gene_symbol ncbi_gene ensembl_gene db_gene_symbol db_ncbi_gene db_ensembl_gene
#>   <chr>       <chr>     <chr>        <chr>          <chr>        <chr>          
#> 1 ABCC4       10257     ENSG0000012… ABCC4          10257        ENSG00000125257
#> 2 ABRAXAS2    23172     ENSG0000016… ABRAXAS2       23172        ENSG00000165660
#> 3 ACTN4       81        ENSG0000013… ACTN4          81           ENSG00000130402
#> 4 ACVR1       90        ENSG0000011… ACVR1          90           ENSG00000115170
#> 5 ADAM9       8754      ENSG0000016… ADAM9          8754         ENSG00000168615
#> 6 ADAMTS5     11096     ENSG0000015… ADAMTS5        11096        ENSG00000154736
#> # ℹ 14 more variables: source_gene <chr>, gs_id <chr>, gs_name <chr>,
#> #   gs_collection <chr>, gs_subcollection <chr>, gs_collection_name <chr>,
#> #   gs_description <chr>, gs_source_species <chr>, gs_pmid <chr>,
#> #   gs_geoid <chr>, gs_exact_source <chr>, gs_url <chr>, db_version <chr>,
#> #   db_target_species <chr>

# Get all mouse gene sets
gs <- msigdbr(db_species = "MM", species = "Mus musculus")
head(gs)
#> # A tibble: 6 × 20
#>   gene_symbol ncbi_gene ensembl_gene db_gene_symbol db_ncbi_gene db_ensembl_gene
#>   <chr>       <chr>     <chr>        <chr>          <chr>        <chr>          
#> 1 AU021092    239691    ENSMUSG0000… AU021092       239691       ENSMUSG0000005…
#> 2 Ahnak       66395     ENSMUSG0000… Ahnak          66395        ENSMUSG0000006…
#> 3 Alcam       11658     ENSMUSG0000… Alcam          11658        ENSMUSG0000002…
#> 4 Ankrd40     71452     ENSMUSG0000… Ankrd40        71452        ENSMUSG0000002…
#> 5 Arid1a      93760     ENSMUSG0000… Arid1a         93760        ENSMUSG0000000…
#> 6 Bckdhb      12040     ENSMUSG0000… Bckdhb         12040        ENSMUSG0000003…
#> # ℹ 14 more variables: source_gene <chr>, gs_id <chr>, gs_name <chr>,
#> #   gs_collection <chr>, gs_subcollection <chr>, gs_collection_name <chr>,
#> #   gs_description <chr>, gs_source_species <chr>, gs_pmid <chr>,
#> #   gs_geoid <chr>, gs_exact_source <chr>, gs_url <chr>, db_version <chr>,
#> #   db_target_species <chr>

# Get CGP (chemical and genetic perturbations) gene sets with genes mapped to rat orthologs
gs <- msigdbr(species = "Rattus norvegicus", collection = "C2", subcollection = "CGP")
head(gs)
#> # A tibble: 6 × 23
#>   gene_symbol ncbi_gene ensembl_gene db_gene_symbol db_ncbi_gene db_ensembl_gene
#>   <chr>       <chr>     <chr>        <chr>          <chr>        <chr>          
#> 1 Ahnak       191572    ENSRNOG0000… AHNAK          79026        ENSG00000124942
#> 2 Alcam       79559     ENSRNOG0000… ALCAM          214          ENSG00000170017
#> 3 Ankrd40     690586    ENSRNOG0000… ANKRD40        91369        ENSG00000154945
#> 4 Arid1a      297867    ENSRNOG0000… ARID1A         8289         ENSG00000117713
#> 5 Bckdhb      29711     ENSRNOG0000… BCKDHB         594          ENSG00000083123
#> 6 RGD1565166  287059    ENSRNOG0000… C16orf89       146556       ENSG00000153446
#> # ℹ 17 more variables: source_gene <chr>, gs_id <chr>, gs_name <chr>,
#> #   gs_collection <chr>, gs_subcollection <chr>, gs_collection_name <chr>,
#> #   gs_description <chr>, gs_source_species <chr>, gs_pmid <chr>,
#> #   gs_geoid <chr>, gs_exact_source <chr>, gs_url <chr>, db_version <chr>,
#> #   db_target_species <chr>, ortholog_taxon_id <int>, ortholog_sources <chr>,
#> #   num_ortholog_sources <dbl>
```
