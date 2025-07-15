#' List the species available in the msigdbr package
#'
#' @return A data frame of the available species.
#'
#' @importFrom babelgene species
#' @importFrom dplyr arrange distinct select
#'
#' @export
#'
#' @examples
#' msigdbr_species()
msigdbr_species <- function() {
  babelgene::species() |>
    tibble::as_tibble() |>
    dplyr::select(
      species_name = "scientific_name",
      species_common_name = "common_name"
    ) |>
    rbind(c("Homo sapiens", "human")) |>
    dplyr::distinct() |>
    dplyr::arrange(.data$species_name)
}
