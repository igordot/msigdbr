#' List the species available in the msigdbr package
#'
#' @return A data frame of the available species.
#'
#' @importFrom babelgene species
#' @importFrom dplyr arrange distinct select
#'
#' @export
msigdbr_species <- function() {
  babelgene::species() |>
    as_tibble() |>
    select(
      species_name = "scientific_name",
      species_common_name = "common_name"
    ) |>
    rbind(c("Homo sapiens", "human")) |>
    distinct() |>
    arrange(.data$species_name)
}
