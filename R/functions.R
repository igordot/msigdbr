
#' List the species available in the msigdbr package
#'
#' @return a vector of possible species
#' @import dplyr
#' @export
msigdbr_show_species <- function() {

  msigdbr_orthologs %>% pull(.data$species_name) %>% unique() %>% sort()

}

#' Retrieve the msigdbr data frame
#'
#' @param species species name, such as Homo sapiens, Mus musculus, etc.
#' @param category collection, such as H, C1, C2, C3, C4, C5, C6, C7.
#' @param subcategory sub-collection, such as CGP, MIR, BP, etc.
#'
#' @return a data frame of gene sets with one gene per row
#' @import tibble
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
  orthologs_subset = filter(msigdbr_orthologs, .data$species_name == species)

  # confirm that the species exists in the database
  if (nrow(orthologs_subset) == 0) {
    stop("species does not exist in the database: ", species)
  }

  genesets_subset = msigdbr_genesets

  # filter by category
  if (is.character(category)) {
    genesets_subset = filter(genesets_subset, .data$gs_cat == category)
  }

  # filter by sub-category
  if (is.character(subcategory)) {
    genesets_subset = filter(genesets_subset, .data$gs_subcat == subcategory)
  }

  # combine gene sets and orthologs
  genesets_subset %>%
    inner_join(orthologs_subset, by = "human_entrez_gene") %>%
    arrange(.data$gs_name, .data$human_gene_symbol) %>%
    select(-.data$human_entrez_gene, -.data$num_sources)

}


