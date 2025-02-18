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
  # Check if msigdbdf is available and try to install otherwise
  msigdbr_check_data()

  # Get the full table of gene sets and their member genes
  mc <- msigdbdf::msigdbdf(target_species = db_species)

  # Keep only gene set information (ignors genes)
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
