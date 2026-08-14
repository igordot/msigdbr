# Introduction to msigdbr

## About

Pathway analysis is a common task in genomics research and there are
many available R-based software tools. Depending on the tool, it may be
necessary to import the pathways, translate genes to the appropriate
species, convert between symbols and IDs, and format the resulting
object.

The msigdbr R package provides Molecular Signatures Database (MSigDB)
gene sets typically used with the Gene Set Enrichment Analysis (GSEA)
software:

- in an R-friendly “[tidy](https://r4ds.hadley.nz/data-tidy.html)”
  format with one gene-to-gene-set mapping per row
- for multiple frequently studied model organisms in addition to the
  original human genes
- as gene symbols as well as NCBI Entrez and Ensembl IDs
- without accessing external resources requiring an active internet
  connection

## Installation

The package can be installed from
[CRAN](https://cran.r-project.org/package=msigdbr).

``` r

install.packages("msigdbr")
```

## Usage

### Basic usage

Load package.

``` r

library(msigdbr)
```

The
[`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
function retrieves a data frame of gene set memberships, with one row
per gene per gene set.

``` r

all_gene_sets <- msigdbr()
head(all_gene_sets)
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
```

### Selecting collection

You can retrieve data for a specific collection, such as the Hallmark
gene sets.

``` r

h_gene_sets <- msigdbr(collection = "H")
```

You can specify a sub-collection, such as C2 (curated) CGP (chemical and
genetic perturbations) gene sets.

``` r

cgp_gene_sets <- msigdbr(collection = "C2", subcollection = "CGP")
```

Use
[`msigdbr_collections()`](https://igordot.github.io/msigdbr/reference/msigdbr_collections.md)
to check the available collections.

If you require more precise filtering, the
[`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
output is a data frame that can be manipulated using generic methods
such as
[`dplyr::filter()`](https://dplyr.tidyverse.org/reference/filter.html).

### Converting genes to other species

The `species` parameter converts the human gene identifiers to orthologs
of various model organisms.

``` r

all_gene_sets <- msigdbr(species = "Mus musculus")
head(all_gene_sets)
#> # A tibble: 6 × 23
#>   gene_symbol ncbi_gene ensembl_gene db_gene_symbol db_ncbi_gene db_ensembl_gene
#>   <chr>       <chr>     <chr>        <chr>          <chr>        <chr>          
#> 1 Abcc4       239273    ENSMUSG0000… ABCC4          10257        ENSG00000125257
#> 2 Abraxas2    109359    ENSMUSG0000… ABRAXAS2       23172        ENSG00000165660
#> 3 Actn4       60595     ENSMUSG0000… ACTN4          81           ENSG00000130402
#> 4 Acvr1       11477     ENSMUSG0000… ACVR1          90           ENSG00000115170
#> 5 Adam9       11502     ENSMUSG0000… ADAM9          8754         ENSG00000168615
#> 6 Adamts5     23794     ENSMUSG0000… ADAMTS5        11096        ENSG00000154736
#> # ℹ 17 more variables: source_gene <chr>, gs_id <chr>, gs_name <chr>,
#> #   gs_collection <chr>, gs_subcollection <chr>, gs_collection_name <chr>,
#> #   gs_description <chr>, gs_source_species <chr>, gs_pmid <chr>,
#> #   gs_geoid <chr>, gs_exact_source <chr>, gs_url <chr>, db_version <chr>,
#> #   db_target_species <chr>, ortholog_taxon_id <int>, ortholog_sources <chr>,
#> #   num_ortholog_sources <dbl>
```

Use
[`msigdbr_species()`](https://igordot.github.io/msigdbr/reference/msigdbr_species.md)
to check the available organisms.

Please be aware that the orthologs are computationally predicted at the
gene level. The full pathways may not be well conserved across species.

### Using the native mouse database

Recent releases of MSigDB include both human and mouse versions. The
`db_species` parameter selects the underlying MSigDB database (human by
default).

``` r

all_mm_gene_sets <- msigdbr(db_species = "MM", species = "Mus musculus")
head(all_mm_gene_sets)
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
```

The genes within each gene set may originate from a species different
from the database target species, as indicated by the
`gs_source_species` and `db_target_species` fields.

### Understanding the output

The
[`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
function returns a data frame with one gene-to-gene-set mapping per row.
Generally, the `gene_symbol` (gene symbol) and `gs_name` (gene set name)
columns are the most relevant.

The data frame contains the following columns for gene-level info:

- `gene_symbol` Official gene symbol for the requested species.
- `ncbi_gene` NCBI (formerly Entrez) ID for the requested species.
- `ensembl_gene` Ensembl ID for the requested species.
- `db_gene_symbol` Official gene symbol in the MSigDB database.
- `db_ncbi_gene` NCBI ID in the MSigDB database.
- `db_ensembl_gene` Ensembl ID in the MSigDB database.
- `source_gene` Gene identifier in the original publication.
- `ortholog_taxon_id` The taxon ID of the species.
- `ortholog_sources` The databases that support the ortholog mapping.
- `num_ortholog_sources` The number of databases that support the
  ortholog mapping.

The `gs_*` columns provide details about the gene sets:

- `gs_id` Gene set systematic name.
- `gs_name` Gene set standard name.
- `gs_collection` The collection the gene set belongs to.
- `gs_subcollection` The sub-collection the gene set belongs to.
- `gs_collection_name` The name of the collection.
- `gs_description` A description of the gene set.
- `gs_source_species` The species from which the gene set originated
  from.
- `gs_pmid` PubMed ID.
- `gs_geoid` GEO ID.
- `gs_exact_source` The original source of the gene set, such as a
  resource identifier, a figure, or a supplementary document from a
  publication.
- `gs_url` A URL to the original source of the gene set.

The `db_*` columns provide details about the MSigDB database and should
be identical for the entire data frame:

- `db_version` The version of the MSigDB database.
- `db_target_species` The target species of the MSigDB database (HS or
  MM).

``` r

unique(all_gene_sets$db_version)
#> [1] "2026.1.Hs"
```

## Helper functions

There are helper functions to assist with setting the
[`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
parameters.

Use
[`msigdbr_species()`](https://igordot.github.io/msigdbr/reference/msigdbr_species.md)
to check the available species. Both scientific and common names are
acceptable for the
[`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
function.

``` r

msigdbr_species()
#> # A tibble: 20 × 2
#>    species_name                    species_common_name                          
#>    <chr>                           <chr>                                        
#>  1 Anolis carolinensis             Carolina anole, green anole                  
#>  2 Bos taurus                      bovine, cattle, cow, dairy cow, domestic cat…
#>  3 Caenorhabditis elegans          NA                                           
#>  4 Canis lupus familiaris          dog, dogs                                    
#>  5 Danio rerio                     leopard danio, zebra danio, zebra fish, zebr…
#>  6 Drosophila melanogaster         fruit fly                                    
#>  7 Equus caballus                  domestic horse, equine, horse                
#>  8 Felis catus                     cat, cats, domestic cat                      
#>  9 Gallus gallus                   bantam, chicken, chickens, Gallus domesticus 
#> 10 Homo sapiens                    human                                        
#> 11 Macaca mulatta                  rhesus macaque, rhesus macaques, Rhesus monk…
#> 12 Monodelphis domestica           gray short-tailed opossum                    
#> 13 Mus musculus                    house mouse, mouse                           
#> 14 Ornithorhynchus anatinus        duck-billed platypus, duckbill platypus, pla…
#> 15 Pan troglodytes                 chimpanzee                                   
#> 16 Rattus norvegicus               brown rat, Norway rat, rat, rats             
#> 17 Saccharomyces cerevisiae        baker's yeast, brewer's yeast, S. cerevisiae 
#> 18 Schizosaccharomyces pombe 972h- NA                                           
#> 19 Sus scrofa                      pig, pigs, swine, wild boar                  
#> 20 Xenopus tropicalis              tropical clawed frog, western clawed frog
```

Use
[`msigdbr_collections()`](https://igordot.github.io/msigdbr/reference/msigdbr_collections.md)
to check the available collections.

``` r

msigdbr_collections()
#>    db_version gs_collection gs_subcollection
#> 1   2026.1.Hs            C1                 
#> 2   2026.1.Hs            C2              CGP
#> 3   2026.1.Hs            C2               CP
#> 4   2026.1.Hs            C2      CP:BIOCARTA
#> 5   2026.1.Hs            C2   CP:KEGG_LEGACY
#> 6   2026.1.Hs            C2  CP:KEGG_MEDICUS
#> 7   2026.1.Hs            C2           CP:PID
#> 8   2026.1.Hs            C2      CP:REACTOME
#> 9   2026.1.Hs            C2  CP:WIKIPATHWAYS
#> 10  2026.1.Hs            C3        MIR:MIRDB
#> 11  2026.1.Hs            C3   MIR:MIR_LEGACY
#> 12  2026.1.Hs            C3         TFT:GTRD
#> 13  2026.1.Hs            C3   TFT:TFT_LEGACY
#> 14  2026.1.Hs            C4              3CA
#> 15  2026.1.Hs            C4              CGN
#> 16  2026.1.Hs            C4               CM
#> 17  2026.1.Hs            C5            GO:BP
#> 18  2026.1.Hs            C5            GO:CC
#> 19  2026.1.Hs            C5            GO:MF
#> 20  2026.1.Hs            C5              HPO
#> 21  2026.1.Hs            C6                 
#> 22  2026.1.Hs            C7      IMMUNESIGDB
#> 23  2026.1.Hs            C7              VAX
#> 24  2026.1.Hs            C8                 
#> 25  2026.1.Hs            C9                 
#> 26  2026.1.Hs             H                 
#>                      gs_collection_name num_genesets
#> 1                            Positional          302
#> 2    Chemical and Genetic Perturbations         3555
#> 3                    Canonical Pathways           19
#> 4                     BioCarta Pathways          292
#> 5                  KEGG Legacy Pathways          186
#> 6                 KEGG Medicus Pathways          658
#> 7                          PID Pathways          196
#> 8                     Reactome Pathways         1839
#> 9                          WikiPathways          925
#> 10                                miRDB         2377
#> 11                           MIR_Legacy          221
#> 12                                 GTRD          506
#> 13                           TFT_Legacy          610
#> 14 Curated Cancer Cell Atlas gene sets           148
#> 15            Cancer Gene Neighborhoods          427
#> 16                       Cancer Modules          431
#> 17                GO Biological Process         7538
#> 18                GO Cellular Component         1080
#> 19                GO Molecular Function         1872
#> 20             Human Phenotype Ontology         5793
#> 21                  Oncogenic Signature          189
#> 22                          ImmuneSigDB         4872
#> 23                HIPC Vaccine Response          347
#> 24                  Cell Type Signature          866
#> 25 Computational Perturbation Signature           62
#> 26                             Hallmark           50
```

## Pathway enrichment analysis

The msigdbr output can be used with various pathway analysis packages.
It just needs to be reshaped to the appropriate format.

Use the gene sets data frame for
[clusterProfiler](https://bioconductor.org/packages/clusterProfiler/)
with genes as NCBI/Entrez IDs.

``` r

msigdbr_t2g <- dplyr::distinct(msigdbr_df, gs_name, ncbi_gene)
enricher(gene = gene_ids_vector, TERM2GENE = msigdbr_t2g, ...)
```

Use the gene sets data frame for
[clusterProfiler](https://bioconductor.org/packages/clusterProfiler/)
with genes as gene symbols.

``` r

msigdbr_t2g <- dplyr::distinct(msigdbr_df, gs_name, gene_symbol)
enricher(gene = gene_symbols_vector, TERM2GENE = msigdbr_t2g, ...)
```

Use the gene sets data frame for
[fgsea](https://bioconductor.org/packages/fgsea/).

``` r

msigdbr_list <- split(x = msigdbr_df$gene_symbol, f = msigdbr_df$gs_name)
fgsea(pathways = msigdbr_list, ...)
```

Use the gene sets data frame for
[GSVA](https://bioconductor.org/packages/GSVA/).

``` r

msigdbr_list <- split(x = msigdbr_df$gene_symbol, f = msigdbr_df$gs_name)
gsvapar <- gsvaParam(geneSets = msigdbr_list, ...)
gsva(gsvapar)
```

Earlier versions of GSVA (\<1.50) only need the `gsva()` function.

``` r

msigdbr_list <- split(x = msigdbr_df$gene_symbol, f = msigdbr_df$gs_name)
gsva(gset.idx.list = msigdbr_list, ...)
```

## Potential questions and concerns

**Why use this package when I can download the gene sets directly from
MSigDB?**

This package makes it more convenient to work with the MSigDB gene sets
in R. You don’t need to import the GMT files and restructure the content
to make it compatible with downstream tools. It adds Ensembl gene IDs
and converts the gene symbols/IDs if you are working with non-human
data.

**Can I convert between human and mouse genes simply by adjusting gene
capitalization?**

That will work for most, but not all, genes. Since 2022, the GSEA/MSigDB
team provides [collections that are natively
mouse](https://www.gsea-msigdb.org/gsea/msigdb/mouse/collections.jsp)
and don’t require orthology conversion.

**Can I convert genes to any organism myself?**

One popular method is using the biomaRt package. You may still end up
with dozens of homologs for some genes, so additional cleanup may be
helpful. Because biomaRt relies on live BioMart services, it can be
disrupted by server outage or maintenance.

**How does msigdbr compare to similar tools?**

There are a few resources that provide some of the msigdbr functionality
and served as an inspiration for this package.
[EGSEAdata](https://doi.org/doi:10.18129/B9.bioc.EGSEAdata) Bioconductor
package provides data as a list. [WEHI
MSigDB](https://bioinf.wehi.edu.au/MSigDB/) provides data for human and
mouse as RDS files. [MSigDF](https://github.com/ToledoEM/msigdf)
provides data as an R data frame. These are updated at varying
frequencies and may not be based on the latest version of MSigDB.

**What if I have other questions?**

Please post questions or feedback on [GitHub
Discussions](https://github.com/igordot/msigdbr/discussions). Report
bugs on [GitHub Issues](https://github.com/igordot/msigdbr/issues).

## Details

The Molecular Signatures Database (MSigDB) is a collection of gene sets
originally created for use with the Gene Set Enrichment Analysis (GSEA)
software. To cite the use of the underlying MSigDB data, reference
Subramanian, Tamayo, et al. (2005, PNAS) and one or more of the
following as appropriate: Liberzon, et al. (2011, Bioinformatics),
Liberzon, et al. (2015, Cell Systems), Castanza, et al. (2023, Nature
Methods) and also the source for the gene set.

Gene homologs are mapped using the
[babelgene](https://cran.r-project.org/package=babelgene) package. The
information is sourced from the HUGO Gene Nomenclature Committee at the
European Bioinformatics Institute which integrates the orthology
assertions predicted by eggNOG, Ensembl Compara, HGNC, HomoloGene,
Inparanoid, NCBI Gene Orthology, OMA, OrthoDB, OrthoMCL, Panther,
PhylomeDB, TreeFam and ZFIN. For each human equivalent within each
species, only the ortholog supported by the largest number of databases
is used.

For information on how to cite the msigdbr R package, run
`citation("msigdbr")`.
