
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
      species_name = .data$scientific_name,
      species_common_name = .data$common_name
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
#' # get mouse C2 (curated) CGP (chemical and genetic perturbations) gene sets
#' \donttest{
#' msigdbr(species = "Mus musculus", category = "C2", subcategory = "CGP")
#' }
msigdbr <- function(species = "Homo sapiens", category = NULL, subcategory = NULL) {

  # confirm that only one species is specified
  if (length(species) > 1) {
    stop("please specify only one species at a time")
  }

  genesets_subset <- msigdbr_genesets

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
  if (species %in% c("Homo sapiens", "human")) {
    orthologs_subset <-
      genesets_subset %>%
      select(
        .data$human_ensembl_gene,
        gene_symbol = .data$human_gene_symbol,
        entrez_gene = .data$human_entrez_gene
      ) %>%
      mutate(ensembl_gene = .data$human_ensembl_gene) %>%
      distinct()
  } else {
    orthologs_subset <-
      orthologs(genes = genesets_subset$human_ensembl_gene, species = species) %>%
      select(-any_of(c("human_symbol", "human_entrez"))) %>%
      rename(
        human_ensembl_gene = .data$human_ensembl,
        gene_symbol = .data$symbol,
        entrez_gene = .data$entrez,
        ensembl_gene = .data$ensembl,
        ortholog_sources = .data$support,
        num_ortholog_sources = .data$support_n
      )
  }

  # combine gene sets and orthologs
  genesets_subset %>%
    inner_join(orthologs_subset, by = "human_ensembl_gene") %>%
    arrange(.data$gs_name, .data$human_gene_symbol, .data$gene_symbol) %>%
    select(
      .data$gs_cat,
      .data$gs_subcat,
      .data$gs_name,
      .data$gene_symbol,
      .data$entrez_gene,
      .data$ensembl_gene,
      .data$human_gene_symbol,
      .data$human_entrez_gene,
      .data$human_ensembl_gene,
      everything()
    )
}




#' @title Update Gene Ontology term descriptions
#'
#' @description Update entries in the \code{gs_description} column of
#'   \code{\link{msigdbr}} results to use terms from the
#'   \href{http://geneontology.org/}{Gene Ontology Consortium}.
#'
#' @param x `data.frame` produced by \code{\link{msigdbr}} containing columns
#'   `gs_description` and `gs_subcat`.
#' @param version Character string specifying the version of \code{msigdbr} to use. Defaults to the current version.
#'
#' @returns A \code{data.frame}. The same as \code{x}, but with updated descriptions.
#'
#' @details This function assumes that the phrase "GO-basic obo file released
#'   on" is present in the MSigDB release notes for that version and is followed
#'   by a date.
#'
#' @author Tyler Sagendorf
#'
#' @importFrom ontologyIndex get_OBO
#' @importFrom data.table setDT setkeyv `:=`
#' @importFrom utils packageVersion
#'
#' @export
#'
#' @seealso
#' \code{\link{cap_names}}, \href{https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Release_Notes}{MSigDB
#' Release Notes}, \href{http://release.geneontology.org/}{Gene Ontology Data
#' Archive}
#'
#' @references Ashburner, M., et al. (2000). Gene ontology: tool for the
#'   unification of biology. The Gene Ontology Consortium. *Nature genetics*,
#'   *25*(1), 25–29. \url{https://doi.org/10.1038/75556}
#'
#'   Gene Ontology Consortium (2021). The Gene Ontology resource: enriching a
#'   GOld mine. *Nucleic acids research*, *49*(D1), D325–D334.
#'   \url{https://doi.org/10.1093/nar/gkaa1113}
#'
#' @examples
#' \donttest{
#' x <- msigdbr(species = "Homo sapiens",
#'              category = "C5",
#'              subcategory = "GO:MF")
#' head(unique(x$gs_description)) # before
#'
#' x <- update_GO_names(x)
#' head(unique(x$gs_description)) # after
#' }

update_GO_names <- function(x,
                            version = packageVersion("msigdbr"))
{
  obsolete <- id <- name <- gs_description <- i.name <- NULL

  go_subcats <- c("GO:MF", "GO:CC", "GO:BP")

  setDT(x, key = "gs_exact_source")

  if (any(x[["gs_subcat"]] %in% go_subcats)) {
    file <- .obo_file(version = version)
    message(paste("Updating GO term descriptions.\nUsing", file))

    go_basic_list <- get_OBO(file = file,
                             propagate_relationships = "is_a",
                             extract_tags = "minimal")
    go.dt <- as.data.frame(go_basic_list)
    setDT(go.dt)
    go.dt <- go.dt[obsolete != TRUE & grepl("^GO", id), list(id, name)]
    setkeyv(go.dt, cols = "id")

    # Update gs_description column with names from OBO file
    x[go.dt, on = list(gs_exact_source = id), gs_description := i.name]

  } else {
    message("No GO terms.")
  }

  x <- as.data.frame(x)
  return(x)
}

## Not exported
# Get the path to the appropriate OBO file.
.obo_file <- function(version = packageVersion("msigdbr")) {
  # MSigDB release notes for appropriate version
  path <- sprintf(file.path("https://software.broadinstitute.org/cancer",
                            "software/gsea/wiki/index.php",
                            "MSigDB_v%s_Release_Notes"), version)
  x <- readLines(path)
  x <- paste(x, collapse = "")
  x <- gsub("\\\\n", "", x)

  phrase <- "GO-basic obo file released on"

  if (!grepl(phrase, x)) {
    stop(sprintf("Phrase '%s' not found in %s", phrase, path))
  }

  obo_date <- sub(sprintf(".*%s ([^ ]+).*", phrase), "\\1", x)
  obo_file <- sprintf("http://release.geneontology.org/%s/ontology/go-basic.obo",
                      obo_date)
  return(obo_file)
}


#' @title Capitalize set descriptions
#'
#' @description Capitalizes the first letter of a description, unless the first
#'   word was not entirely lowercase. For example, the first letter of
#'   "magnesium ion binding" is capitalized, but "tRNA binding" would remain
#'   unchanged. This should preserve special capitalization while slightly
#'   improving the appearance of descriptions in visualizations.
#'
#' @param x A character vector of term descriptions (i.e. the
#'   \code{gs_description} column of \code{\link{msigdbr}} results).
#'
#' @returns A character vector of conditionally-capitalized terms.
#'
#' @export
#'
#' @author Tyler Sagendorf
#'
#' @examples
#' \donttest{
#' x <- msigdbr(species = "Homo sapiens",
#'              category = "C5",
#'              subcategory = "GO:MF")
#' x <- update_GO_names(x)
#' head(unique(x$gs_description)) # before
#'
#'
#' x$gs_description <- cap_names(x$gs_description)
#' head(unique(x$gs_description)) # after
#' }

cap_names <- function(x) {
  first_word <- sub("[ |-].*", "", x)
  idx <- first_word == tolower(first_word)
  x[idx] <- sub("(.)", "\\U\\1", x[idx], perl = TRUE)
  return(x)
}



