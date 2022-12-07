#' List the collections available in the msigdbr package
#'
#' @return A data frame of the available collections.
#'
#' @importFrom dplyr arrange count distinct
#' @export
#'
#' @examples
#' msigdbr_collections()
msigdbr_collections <- function() {
  msigdbr_geneset_desc <- c("POSITIONAL GENE SETS",
                          "CHEMICAL AND GENETIC PERTURBATIONS",
                          "CANONICAL PATHWAYS",
                          "CANONICAL PATHWAYS - BIOCARTA",
                          "CANONICAL PATHWAYS - KEGG",
                          "CANONICAL PATHWAYS - PID",
                          "CANONICAL PATHWAYS - REACTOME",
                          "CANONICAL PATHWAYS - WIKIPATHWAYS",
                          "CURATED GENES SETS",
                          "MICRORNA TARGETS - LEGACY",
                          "MICRORNA TARGETS - MIR",
                          "TRANSCRIPTION FACTOR TARGETS - GTRD",
                          "TRANSCRIPTION FACTOR TARGETS - LEGACY",
                          "REGULATORY TARGET GENES",
                          "CANCER GENE NEIGHBOURHOODS",
                          "CANCER MODULES",
                          "COMPUTATIONAL GENE SETS",
                          "GENE ONTOLOGY - BIOLOGICAL PROCESS",
                          "GENE ONTOLOGY - CELLULAR COMPONENT",
                          "GENE ONTOLOGY - MOLECULAR FUNCTION",
                          "HUMAN PHENOTYPE ONTOLOGY",
                          "ONTOLOGY GENE SETS",
                          "ONCOGENIC SIGNATURE GENE SETS",
                          "IMMUNESIGDB",
                          "VACCINE RESPONSE GENE SETS",
                          "IMMUNOLOGIC SIGNATURE GENE SETS",
                          "CELL TYPE SIGNATURE GENE SETS",
                          "HALLMARK GENE SETS")
  msigdbr_genesets %>%
  distinct(.data$gs_cat, .data$gs_subcat, .data$gs_id) %>%
  count(.data$gs_cat, .data$gs_subcat, name = "num_genesets") %>%
  arrange(.data$gs_cat, .data$gs_subcat) %>% 
  group_by(gs_cat) %>%
  bind_rows(summarise_all(., ~if(is.numeric(.)) sum(.) else "")) %>% 
  unique() %>% arrange(gs_cat, desc=T) %>% cbind(msigdbr_geneset_desc)
}
