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
