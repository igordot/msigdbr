#' List the collections available in the msigdbr package
#'
#' @param db_species Species abbreviation for the human or mouse databases (`"HS"` or `"MM"`).
#'
#' @return A data frame of the available collections.
#'
#' @importFrom dplyr arrange count distinct
#'
#' @export
#'
#' @examplesIf (identical(Sys.getenv("NOT_CRAN"), "true") || identical(Sys.getenv("IN_PKGDOWN"), "true"))
#' msigdbr_collections()
msigdbr_collections <- function(db_species = "HS") {
  # Check parameters
  assertthat::assert_that(
    is.character(db_species),
    length(db_species) == 1,
    nchar(db_species) == 2
  )
  db_species <- toupper(db_species)

  # Get data summary (from memory cache or disk)
  cache_info <- check_cache()
  mc <- read_cached_rds(cache_info$summary_rds)

  # Filter summary table by species
  mc <- mc[mc$db_target_species == db_species, ]

  # Select relevant columns
  mc <- dplyr::select(
    mc,
    "db_version",
    "gs_collection",
    "gs_subcollection",
    "gs_collection_name",
    "num_genesets"
  )

  # Sort
  mc <- dplyr::arrange(mc, .data$gs_collection, .data$gs_subcollection)

  return(mc)
}
