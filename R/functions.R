
#' List the species available in the msigdbr package
#'
#' @return A data frame of the available species.
#'
#' @importFrom babelgene species
#' @importFrom dplyr arrange distinct select
#' @importFrom tibble as_tibble
#' @export
#'
#' @examples
#' msigdbr_species()
msigdbr_species <- function() {
  species() %>%
    as_tibble() %>%
    select(
      species_name = .data$scientific_name,
      species_common_name = .data$common_name
    ) %>%
    rbind(c("Homo sapiens", "human")) %>%
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
  sort(msigdbr_species()[["species_name"]])
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
#' @importFrom babelgene orthologs
#' @importFrom dplyr arrange distinct filter inner_join mutate rename select
#' @importFrom tidyselect any_of everything
#' @export
#'
#' @examples
#' # get all human gene sets
#' \donttest{
#' msigdbr(species = "Homo sapiens")
#' }
#'
#' # get mouse C2 (curated) CGP (chemical and genetic perturbations) gene sets
#' \donttest{
#' msigdbr(species = "Mus musculus", category = "C2", subcategory = "CGP")
#' }
msigdbr <- function(species = "Homo sapiens", category = NULL, subcategory = NULL) {

  # confirm that only one species is specified
  if (length(species) > 1) {
    stop("please specify only one species at a time")
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

  if (is.character(subcategory)) {
    if (length(subcategory) > 1) {
      stop("please specify only one subcategory at a time")
    }
    if (subcategory %in% genesets_subset$gs_subcat) {
      genesets_subset <- filter(genesets_subset, .data$gs_subcat == subcategory)
    } else if (subcategory %in% gsub(".*:", "", genesets_subset$gs_subcat)) {
      genesets_subset <- filter(genesets_subset, gsub(".*:", "", .data$gs_subcat) == subcategory)
    } else {
      stop("unknown subcategory")
    }
  }

  # combine gene sets and genes
  genesets_subset <-
    genesets_subset %>%
    inner_join(msigdbr_geneset_genes, by = "gs_id") %>%
    inner_join(msigdbr_genes, by = "gene_id") %>%
    select(-any_of(c("gene_id")))

  # retrieve orthologs
  if (species %in% c("Homo sapiens", "human")) {
    orthologs_subset <-
      genesets_subset %>%
      select(
        .data$human_ensembl_gene,
        gene_symbol = .data$human_gene_symbol,
        entrez_gene = .data$human_entrez_gene
      ) %>%
      mutate(ensembl_gene = .data$human_ensembl_gene) %>%
      distinct()
  } else {
    orthologs_subset <-
      orthologs(genes = genesets_subset$human_ensembl_gene, species = species) %>%
      select(-any_of(c("human_symbol", "human_entrez"))) %>%
      rename(
        human_ensembl_gene = .data$human_ensembl,
        gene_symbol = .data$symbol,
        entrez_gene = .data$entrez,
        ensembl_gene = .data$ensembl,
        ortholog_sources = .data$support,
        num_ortholog_sources = .data$support_n
      )
  }

  # confirm that the species exists in the database
  if (nrow(orthologs_subset) == 0) {
    stop("species does not exist in the database: ", species)
  }

  # combine gene sets and orthologs
  genesets_subset %>%
    inner_join(orthologs_subset, by = "human_ensembl_gene") %>%
    arrange(.data$gs_name, .data$human_gene_symbol, .data$gene_symbol) %>%
    select(
      .data$gs_cat,
      .data$gs_subcat,
      .data$gs_name,
      .data$gene_symbol,
      .data$entrez_gene,
      .data$ensembl_gene,
      .data$human_gene_symbol,
      .data$human_entrez_gene,
      .data$human_ensembl_gene,
      everything()
    )
}
