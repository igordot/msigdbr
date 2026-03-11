# List the collections available in the msigdbr package

List the collections available in the msigdbr package

## Usage

``` r
msigdbr_collections(db_species = "HS")
```

## Arguments

- db_species:

  Species abbreviation for the human or mouse databases (`"HS"` or
  `"MM"`).

## Value

A data frame of the available collections.

## Examples

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
