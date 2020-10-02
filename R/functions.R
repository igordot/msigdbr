
#' List the species available in the msigdbr package
#'
#' @return A data frame of the available species.
#'
#' @importFrom dplyr arrange distinct select
#' @importFrom tidyselect starts_with
#' @export
#'
#' @examples
#' msigdbr_species()
msigdbr_species <- function() {
  msigdbr_orthologs %>%
    select(starts_with("species")) %>%
    distinct() %>%
    arrange(.data$species_name)
}

#' List the species available in the msigdbr package
#'
#' This function is being deprecated and replaced by `msigdbr_species()`.
#'
#' @return A vector of possible species.
#'
#' @export
msigdbr_show_species <- function() {
  .Deprecated("msigdbr_species")
  msigdbr_orthologs$species_name %>%
    unique() %>%
    sort()
}

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
  msigdbr_genesets %>%
    distinct(.data$gs_cat, .data$gs_subcat, .data$gs_id) %>%
    count(.data$gs_cat, .data$gs_subcat, name = "num_genesets") %>%
    arrange(.data$gs_cat, .data$gs_subcat)
}

#' Retrieve the gene sets data frame
#'
#' Retrieve a data frame of gene sets and their member genes.
#' The available species and collections can be checked with `msigdbr_species()` and `msigdbr_collections()`.
#'
#' @param species Species name, such as Homo sapiens or Mus musculus.
#' @param category MSigDB collection abbreviation, such as H or C1.
#' @param subcategory MSigDB sub-collection abbreviation, such as CGP or BP.
#'
#' @return A data frame of gene sets with one gene per row.
#'
#' @references \url{https://www.gsea-msigdb.org/gsea/msigdb/collections.jsp}
#'
#' @import tibble
#' @importFrom dplyr filter inner_join arrange select
#' @importFrom tidyselect everything
#' @export
#'
#' @examples
#' # get all human gene sets
#' \donttest{msigdbr(species = "Homo sapiens")}
#'
#' # get mouse C2 (curated) CGP (chemical and genetic perturbations) gene sets
#' \donttest{msigdbr(species = "Mus musculus", category = "C2", subcategory = "CGP")}
msigdbr <- function(species = "Homo sapiens", category = NULL, subcategory = NULL) {

  # confirm that only one species is specified
  if (length(species) > 1) {
    stop("please specify only one species at a time")
  }

  # filter orthologs by species
  orthologs_subset <- filter(msigdbr_orthologs, .data$species_name == species)

  # confirm that the species exists in the database
  if (nrow(orthologs_subset) == 0) {
    stop("species does not exist in the database: ", species)
  }

  genesets_subset <- msigdbr_genesets

  # filter by category
  if (is.character(category)) {
    if (length(category) > 1) {
      stop("please specify only one category at a time")
    }
    if (category %in% genesets_subset$gs_cat) {
      genesets_subset <- filter(genesets_subset, .data$gs_cat == category)
    } else {
      stop("unknown category")
    }
  }

  # filter by sub-category (with and without colon)
  if (is.character(subcategory)) {
    if (length(subcategory) > 1) {
      stop("please specify only one subcategory at a time")
    }
    if (subcategory %in% genesets_subset$gs_subcat) {
      genesets_subset <- filter(genesets_subset, .data$gs_subcat == subcategory)
    } else if (subcategory %in% gsub(".*:", "", genesets_subset$gs_subcat)){
      genesets_subset <- filter(genesets_subset, gsub(".*:", "", .data$gs_subcat) == subcategory)
    } else {
      stop("unknown subcategory")
    }
  }

  # combine gene sets and genes
  genesets_subset <- inner_join(genesets_subset, msigdbr_genes, by = "gs_id")

  # combine gene sets and orthologs
  genesets_subset %>%
    inner_join(orthologs_subset, by = "human_entrez_gene") %>%
    arrange(.data$gs_name, .data$human_gene_symbol, .data$gene_symbol) %>%
    select(
      .data$gs_cat,
      .data$gs_subcat,
      .data$gs_name,
      .data$entrez_gene,
      .data$gene_symbol,
      .data$human_entrez_gene,
      .data$human_gene_symbol,
      everything()
    )
}
