
#' List the species available in msigdbr.
#'
#' @return a vector of possible species
#' @importFrom magrittr %>%
#' @import dplyr
#' @export
msigdbr_show_species <- function() {

  msigdbr_orthologs %>% pull(species_name) %>% unique() %>% sort()

}

#' Retrieve msigdbr data frame.
#'
#' @param species species name, such as Homo sapiens, Mus musculus, etc.
#' @param category collection, such as H, C1, C2, C3, C4, C5, C6, C7.
#' @param subcategory sub-collection, such as CGP, MIR, BP, etc.
#'
#' @return a data frame of gene sets with one gene per row
#' @importFrom magrittr %>%
#' @import dplyr
#' @export
#'
#' @examples
#' # all human gene sets
#' m = msigdbr(species = "Homo sapiens")
#'
#' # mouse C2 (curated) CGP (chemical and genetic perturbations) gene sets
#' m = msigdbr(species = "Mus musculus", category = "C2", subcategory = "CGP")
msigdbr <- function(species = "Homo sapiens", category = NULL, subcategory = NULL) {

  # filter by species
  msigdbr_orthologs_subset = msigdbr_orthologs %>% filter(species_name == species)

  # confirm that the species exists in the database
  if (nrow(msigdbr_orthologs_subset) == 0) {
    stop("species does not exist in the database: ", species)
  }

  # filter by category
  if (is.null(category)) {
    msigdbr_genesets_subset = msigdbr_genesets
  } else {
    msigdbr_genesets_subset = msigdbr_genesets %>% filter(gs_cat == category)
  }

  # filter by sub-category
  if (is.null(subcategory)) {
    msigdbr_genesets_subset = msigdbr_genesets_subset
  } else {
    msigdbr_genesets_subset = msigdbr_genesets_subset %>% filter(gs_subcat == subcategory)
  }

  # combine gene sets and orthologs
  msigdbr_genesets_subset %>%
    inner_join(msigdbr_orthologs_subset, by = "human_entrez_gene") %>%
    arrange(gs_name, human_gene_symbol) %>%
    select(-human_entrez_gene, -num_sources)

}


