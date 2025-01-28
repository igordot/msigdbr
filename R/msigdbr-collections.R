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
  arrange(.data$gs_cat, .data$gs_subcat) %>%
  group_by(gs_cat) %>%
  bind_rows(summarise_all(., ~if(is.numeric(.)) sum(.) else "")) %>% 
  unique() %>% arrange(gs_cat, gs_subcat, desc=T) %>% 
  bind_cols(desc)
}
