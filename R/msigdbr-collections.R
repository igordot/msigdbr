#' List the collections available in the msigdbr package
#'
#' @return A data frame of the available collections.
#'
#' @importFrom dplyr arrange count distinct
#' @export
#'
#' @examples
#' msigdbr_collections()
#' @param species Species name, such as Homo sapiens or Mus musculus.
msigdbr_collections <- function(species='human') {
  if (species %in% c('mouse','Mus musculus')){
    msigdbr_genesets <- msigdbr_genesetsMm
  } else {
    msigdbr_genesets <- msigdbr_genesetsHs
  }
  msigdbr_genesets %>%
    distinct(.data$gs_cat, .data$gs_subcat, .data$gs_id) %>%
    count(.data$gs_cat, .data$gs_subcat, name = "num_genesets") %>%
    arrange(.data$gs_cat, .data$gs_subcat)
}
