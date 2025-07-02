#' Retrieve the gene sets data frame
#'
#' Retrieve a data frame of gene sets and their member genes.
#' The original human genes can be converted into their corresponding counterparts in various model organisms, including mouse, rat, pig, zebrafish, fly, and yeast.
#' The output includes gene symbols along with NCBI and Ensembl IDs.
#'
#' Historically, the MSigDB resource has been tailored to the analysis of human-specific datasets, with gene sets exclusively aligned to the human genome.
#' Starting with release 2022.1, MSigDB incorporated a database of mouse-native gene sets and was split into human and mouse divisions ("Hs" and "Mm").
#' Each one is provided in the approved gene symbols of its respective species.
#'
#' Mouse MSigDB includes gene sets curated from mouse-centric datasets and specified in native mouse gene identifiers, eliminating the need for ortholog mapping.
#'
#' @param db_species Species abbreviation for the human or mouse databases (`"HS"` or `"MM"`).
#' @param species Species name for output genes, such as `"Homo sapiens"` or `"Mus musculus"`. Both scientific and common names are acceptable. Use `msigdbr_species()` for the available options.
#' @param collection Collection abbreviation, such as `"H"` or `"C1"`. Use `msigdbr_collections()` for the available options.
#' @param subcollection Sub-collection abbreviation, such as `"CGP"` or `"BP"`. Use `msigdbr_collections()` for the available options.
#' @param category `r lifecycle::badge("deprecated")` use the `collection` argument
#' @param subcategory `r lifecycle::badge("deprecated")` use the `subcollection` argument
#'
#' @return A tibble (a data frame with class [`tibble::tbl_df`]) of gene sets with one gene per row.
#'
#' @references <https://www.gsea-msigdb.org/gsea/msigdb/index.jsp>
#'
#' @importFrom babelgene orthologs
#' @importFrom dplyr arrange distinct filter inner_join mutate rename select
#'
#' @export
msigdbr <- function(db_species = "HS", species = "human", collection = NULL, subcollection = NULL, category = deprecated(), subcategory = deprecated()) {
  # Check parameters
  assertthat::assert_that(
    is.character(db_species),
    length(db_species) == 1,
    nchar(db_species) == 2
  )
  db_species <- toupper(db_species)
  assertthat::assert_that(
    is.character(species),
    length(species) == 1,
    nchar(species) > 1
  )
  if (!is.null(collection)) {
    assertthat::assert_that(
      is.character(collection),
      length(collection) == 1,
      nchar(collection) > 0
    )
  }
  if (!is.null(subcollection)) {
    assertthat::assert_that(
      is.character(subcollection),
      length(subcollection) == 1,
      nchar(subcollection) > 0
    )
  }

  # Define name variants for species with caveats
  species_hs <- c("Homo sapiens", "human")
  species_mm <- c("Mus musculus", "mouse", "house mouse")

  # Use only mouse genes for mouse database
  if (db_species == "MM" && !(species %in% species_mm)) {
    stop("Use `species = \"mouse\"` when selecting the mouse database.")
  }

  # Display a message when selecting the human database and mouse genes
  if (db_species == "HS" && species %in% species_mm) {
    mm_msg <- "Using human MSigDB with ortholog mapping to mouse. Use `db_species = \"MM\"` for mouse-native gene sets."
    rlang::inform(message = mm_msg, .frequency = "once", .frequency_id = "msigdbr_species_mm")
  }

  # Check for deprecated category arguments
  if (lifecycle::is_present(category) && !is.null(category)) {
    lifecycle::deprecate_warn("10.0.0", "msigdbr(category)", "msigdbr(collection)")
    assertthat::assert_that(is.character(category), length(category) == 1, nchar(category) > 0)
    collection <- category
  }
  if (lifecycle::is_present(subcategory) && !is.null(subcategory)) {
    lifecycle::deprecate_warn("10.0.0", "msigdbr(subcategory)", "msigdbr(subcollection)")
    assertthat::assert_that(is.character(subcategory), length(subcategory) == 1, nchar(subcategory) > 0)
    subcollection <- subcategory
  }

  # Get the gene sets table
  mdb <- load_msigdb_df(target_species = db_species)
  mdb <- tibble::as_tibble(mdb)

  # Filter by collection
  if (is.character(collection)) {
    if (collection %in% mdb$gs_collection) {
      mdb <- dplyr::filter(mdb, .data$gs_collection == collection)
    } else {
      stop("Unknown collection. Use `msigdbr_collections()` to see the available collections.")
    }
  }

  # Filter by sub-collection
  if (is.character(subcollection)) {
    if (subcollection %in% mdb$gs_subcollection) {
      mdb <- dplyr::filter(mdb, .data$gs_subcollection == subcollection)
    } else if (subcollection %in% gsub(".*:", "", mdb$gs_subcollection)) {
      mdb <- dplyr::filter(mdb, gsub(".*:", "", .data$gs_subcollection) == subcollection)
    } else {
      stop("Unknown subcollection.")
    }
  }

  # Create a fake orthologs table for cases when orthologs are not needed
  species_genes <- dplyr::select(
    mdb,
    gene_symbol = "db_gene_symbol",
    ncbi_gene = "db_ncbi_gene",
    ensembl_gene = "db_ensembl_gene"
  )
  species_genes <- dplyr::mutate(
    species_genes,
    db_ensembl_gene = .data$ensembl_gene
  )

  # Retrieve orthologs for the non-human species for the human database
  if (db_species == "HS" && !(species %in% species_hs)) {
    species_genes <- babelgene::orthologs(
      genes = unique(mdb$db_ensembl_gene),
      species = species
    )
    species_genes <- dplyr::select(
      species_genes,
      db_ensembl_gene = "human_ensembl",
      gene_symbol = "symbol",
      ncbi_gene = "entrez",
      ensembl_gene = "ensembl",
      ortholog_taxon_id = "taxon_id",
      ortholog_sources = "support",
      num_ortholog_sources = "support_n",
      !tidyselect::any_of(c("human_symbol", "human_entrez"))
    )
    species_genes$ncbi_gene <- as.character(species_genes$ncbi_gene)
  }

  # Remove duplicate entries
  species_genes <- dplyr::distinct(species_genes)

  # Combine gene sets and orthologs
  mdb <- dplyr::inner_join(
    mdb,
    species_genes,
    by = "db_ensembl_gene",
    relationship = "many-to-many"
  )

  # Reorder columns for better readability
  mdb <- dplyr::select(
    mdb,
    "gene_symbol",
    "ncbi_gene",
    "ensembl_gene",
    "db_gene_symbol",
    "db_ncbi_gene",
    "db_ensembl_gene",
    "source_gene",
    "gs_id",
    "gs_name",
    "gs_collection",
    "gs_subcollection",
    everything()
  )
  mdb <- dplyr::arrange(mdb, .data$gs_name, .data$db_gene_symbol, .data$gene_symbol)

  # Add columns from the old msigdbr output if old arguments are present
  if (lifecycle::is_present(category) || lifecycle::is_present(subcategory)) {
    mdb <- dplyr::mutate(
      mdb,
      entrez_gene = .data$ncbi_gene,
      gs_cat = .data$gs_collection,
      gs_subcat = .data$gs_subcollection,
    )
  }

  return(mdb)
}
