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
#' # get mouse M2 (curated) CGP (chemical and genetic perturbations) gene sets
#' \donttest{
#' msigdbr(species = "Mus musculus", category = "M2", subcategory = "CGP")
#' }
msigdbr <- function(species = "Homo sapiens", category = NULL, subcategory = NULL) {

  # confirm that only one species is specified
  if (length(species) > 1) {
    stop("please specify only one species at a time")
  }

  if (species %in% c('mouse','Mus musculus')){
    genesets_subset <- msigdbr_genesetsMm
    msigdbr_geneset_genes <- msigdbr_geneset_genesMm
    msigdbr_genes <- msigdbr_genesMm
  } else {
    genesets_subset <- msigdbr_genesetsHs
    msigdbr_geneset_genes <- msigdbr_geneset_genesHs
    msigdbr_genes <- msigdbr_genesHs
  }

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
  if (species %in% c("Homo sapiens","human",'mouse','Mus musculus')) {
    orthologs_subset <-
      genesets_subset %>%
      select(
        "human_ensembl_gene",
        gene_symbol = "human_gene_symbol",
        entrez_gene = "human_entrez_gene"
      ) %>%
      mutate(ensembl_gene = .data$human_ensembl_gene) %>%
      distinct()
  } else {
    orthologs_subset <-
      orthologs(genes = genesets_subset$human_ensembl_gene, species = species) %>%
      select(-any_of(c("human_symbol", "human_entrez"))) %>%
      rename(
        human_ensembl_gene = "human_ensembl",
        gene_symbol = "symbol",
        entrez_gene = "entrez",
        ensembl_gene = "ensembl",
        ortholog_sources = "support",
        num_ortholog_sources = "support_n"
      )
  }

  # combine gene sets and orthologs
  genesets_subset %>%
    inner_join(orthologs_subset, by = "human_ensembl_gene") %>%
    arrange(.data$gs_name, .data$human_gene_symbol, .data$gene_symbol) %>%
    select(
      "gs_cat",
      "gs_subcat",
      "gs_name",
      "gene_symbol",
      "entrez_gene",
      "ensembl_gene",
      "human_gene_symbol",
      "human_entrez_gene",
      "human_ensembl_gene",
      everything()
    )
}
