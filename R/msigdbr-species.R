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
      species_name = "scientific_name",
      species_common_name = "common_name"
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
