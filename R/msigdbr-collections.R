#' List the collections available in the msigdbr package
#'
#' @return A data frame of the available collections.
#'
#' @param db_species Species abbreviation for the human or mouse databases (`"Hs"` or `"Mm"`).
#'
#' @importFrom dplyr arrange count distinct
#'
#' @export
msigdbr_collections <- function(db_species = "Hs") {
  # Get the full table of gene sets and their member genes
  mc <- load_msigdb_df(target_species = db_species)
  mc <- tibble::as_tibble(mc)

  # Keep only gene set information (ignore genes)
  mc <- dplyr::distinct(
    mc,
    .data$gs_collection,
    .data$gs_subcollection,
    .data$gs_collection_name,
    .data$gs_id
  )

  # Count the number of gene sets per collection
  mc <- dplyr::count(
    mc,
    .data$gs_collection,
    .data$gs_subcollection,
    .data$gs_collection_name,
    name = "num_genesets"
  )

  # Sort
  mc <- dplyr::arrange(mc, .data$gs_collection, .data$gs_subcollection)

  return(mc)
}
