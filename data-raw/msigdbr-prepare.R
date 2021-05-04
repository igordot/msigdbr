
library(dplyr)
library(tidyr)
library(purrr)
library(readr)
library(stringr)
library(glue)
library(xml2)
library(usethis)

# Import MSigDB gene sets -------------------------------------------------

# Define MSigDB download variables
mdb_version <- "7.4"
mdb_url_base <- "https://data.broadinstitute.org/gsea-msigdb/msigdb"
mdb_zip_url <- glue("{mdb_url_base}/release/{mdb_version}/msigdb_v{mdb_version}_files_to_download_locally.zip")
mdb_dir <- glue("msigdb_v{mdb_version}_files_to_download_locally")

# Download the MSigDB zip file
options(timeout = 100)
download.file(url = mdb_zip_url, destfile = glue("{mdb_dir}.zip"))

# Check MSigDB XML file size in bytes
utils:::format.object_size(file.size(glue("{mdb_dir}.zip")), units = "auto")

# Extract the MSigDB zip file
unzip(glue("{mdb_dir}.zip"))

# Import the MSigDB XML file
mdb_doc <- read_xml(glue("{mdb_dir}/msigdb_v{mdb_version}.xml"))

# Delete the MSigDB zip file and its contents since they are no longer needed
file.remove(glue("{mdb_dir}.zip"))
unlink(mdb_dir, recursive = TRUE)

# Extract the XML attributes and convert into a tibble
# https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/mdb_XML_description
# GENESET record attributes:
# * STANDARD_NAME: gene set name
# * SYSTEMATIC_NAME: gene set name for internal indexing purposes
# * CATEGORY_CODE: gene set collection code, e.g., C2
# * SUB_CATEGORY_CODE: gene set subcategory code, e.g., CGP
# * PMID: PubMed ID for the source publication
# * GEOID: GEO or ArrayExpress ID for the raw microarray data in GEO or ArrayExpress repository
# * EXACT_SOURCE: exact source of the set, usually a specific figure or table in the publication
# * GENESET_LISTING_URL: URL of the original source that listed the gene set members (all blank)
# * EXTERNAL_DETAILS_URL: URL of the original source page of the gene set
# * DESCRIPTION_BRIEF: brief description of the gene set
# * MEMBERS: list of gene set members as they originally appeared in the source
# * MEMBERS_SYMBOLIZED: list of gene set members in the form of human gene symbols
# * MEMBERS_EZID: list of gene set members in the form of human Entrez Gene IDs
# * MEMBERS_MAPPING: pipe-separated list of in the form of: MEMBERS, MEMBERS_SYMBOLIZED, MEMBERS_EZID
mdb_gs_ns <- xml_find_all(mdb_doc, xpath = ".//GENESET")
mdb_tbl <-
  tibble(
    gs_name = xml_attr(mdb_gs_ns, attr = "STANDARD_NAME"),
    gs_id = xml_attr(mdb_gs_ns, attr = "SYSTEMATIC_NAME"),
    gs_cat = xml_attr(mdb_gs_ns, attr = "CATEGORY_CODE"),
    gs_subcat = xml_attr(mdb_gs_ns, attr = "SUB_CATEGORY_CODE"),
    gs_pmid = xml_attr(mdb_gs_ns, attr = "PMID"),
    gs_geoid = xml_attr(mdb_gs_ns, attr = "GEOID"),
    gs_exact_source = xml_attr(mdb_gs_ns, attr = "EXACT_SOURCE"),
    gs_url = xml_attr(mdb_gs_ns, attr = "EXTERNAL_DETAILS_URL"),
    gs_description = xml_attr(mdb_gs_ns, attr = "DESCRIPTION_BRIEF"),
    gs_members = xml_attr(mdb_gs_ns, attr = "MEMBERS_MAPPING")
  ) %>%
  filter(gs_cat != "ARCHIVED")

# Check the number of gene sets
mdb_tbl %>% count(gs_cat, gs_subcat)

# Import MSigDB Ensembl mappings ------------------------------------------

# Download the MSigDB Ensembl mappings
ensembl_url <- glue("{mdb_url_base}/annotations_versioned/Human_ENSEMBL_Gene_ID_MSigDB.v{mdb_version}.chip")
ensembl_tbl <- read_tsv(ensembl_url, col_types = cols())
ensembl_tbl <- ensembl_tbl %>% select(human_ensembl_gene = `Probe Set ID`, human_gene_symbol = `Gene Symbol`)

# Generate a gene sets table ----------------------------------------------

# Create a table for gene sets
msigdbr_genesets <-
  mdb_tbl %>%
  select(!gs_members) %>%
  distinct() %>%
  arrange(gs_name, gs_id)

# Check the number of gene sets per category
msigdbr_genesets %>%
  count(gs_cat, gs_subcat) %>%
  arrange(gs_cat)

# Extract gene set members ------------------------------------------------

# Create a table for genes in a tidy/long format (one gene per row)
geneset_genes <- mdb_tbl %>% select(gs_id, gs_members)
geneset_genes <- mutate(geneset_genes, gs_members_split = strsplit(gs_members, "|", fixed = TRUE))
geneset_genes <- unnest(geneset_genes, cols = gs_members_split, names_repair = "minimal")
geneset_genes <-
  geneset_genes %>%
  separate(
    col = gs_members_split,
    into = c("source_gene", "human_gene_symbol", "human_entrez_gene"),
    sep = ","
  ) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene))

# Skip genes without an Entrez ID entry (some only have the source gene)
geneset_genes <- geneset_genes %>% filter(human_entrez_gene > 0)

# Keep only the relevant fields
geneset_genes <-
  geneset_genes %>%
  distinct(gs_id, source_gene, human_entrez_gene, human_gene_symbol)

# Generate a gene set members table ---------------------------------------

# Split genes based on if they include Ensembl IDs
# Add internal gene ID to track both Entrez and Ensembl genes
# Using Ensembl IDs as IDs for all genes resulted in a larger data file
geneset_genes_entrez <-
  geneset_genes %>%
  filter(str_detect(source_gene, "ENSG00", negate = TRUE)) %>%
  distinct(gs_id, human_entrez_gene, human_gene_symbol) %>%
  mutate(gene_id = human_entrez_gene) %>%
  arrange(gs_id, gene_id)
geneset_genes_ensembl <-
  geneset_genes %>%
  filter(str_detect(source_gene, "ENSG00")) %>%
  select(gs_id, human_entrez_gene, human_ensembl_gene = source_gene, human_gene_symbol) %>%
  mutate(gene_id = str_remove(human_ensembl_gene, "ENSG00")) %>%
  mutate(gene_id = as.integer(gene_id) + as.integer(10^9)) %>%
  arrange(gs_id, gene_id)

# Check the number of genes
intersect(geneset_genes_entrez$gene_id, geneset_genes_ensembl$gene_id)
nrow(geneset_genes_entrez)
n_distinct(geneset_genes_entrez$human_gene_symbol)
n_distinct(geneset_genes_entrez$human_entrez_gene)
nrow(geneset_genes_ensembl)
n_distinct(geneset_genes_ensembl$human_gene_symbol)
n_distinct(geneset_genes_ensembl$human_ensembl_gene)

if (length(setdiff(geneset_genes_entrez$human_gene_symbol, ensembl_tbl$human_gene_symbol))) stop()

# Add Ensembl IDs to genes without them
geneset_genes_entrez <- left_join(geneset_genes_entrez, ensembl_tbl, by = "human_gene_symbol")

# Check gene numbers
nrow(geneset_genes_entrez)
n_distinct(geneset_genes_entrez$human_entrez_gene)
n_distinct(geneset_genes_entrez$human_gene_symbol)
n_distinct(geneset_genes_entrez$human_ensembl_gene)

# Combine Entrez and Ensembl genes into a single table
msigdbr_geneset_genes <-
  bind_rows(geneset_genes_entrez, geneset_genes_ensembl) %>%
  distinct(gs_id, gene_id) %>%
  arrange(gs_id, gene_id)

# Most gene sets should not have only some genes as Ensembl IDs
intersect(geneset_genes_entrez$gs_id, geneset_genes_ensembl$gs_id)

# Generate a genes table --------------------------------------------------

# Extract the unique genes
msigdbr_genes <-
  bind_rows(geneset_genes_entrez, geneset_genes_ensembl) %>%
  select(gene_id, human_gene_symbol, human_entrez_gene, human_ensembl_gene) %>%
  distinct() %>%
  arrange(human_gene_symbol, gene_id)

# Check the total number of genes
nrow(msigdbr_genes)

# Prepare package ---------------------------------------------------------

# Check the size of final tables
format(object.size(msigdbr_genesets), units = "Mb")
format(object.size(msigdbr_geneset_genes), units = "Mb")
format(object.size(msigdbr_genes), units = "Mb")

# Create package data
use_data(
  msigdbr_genesets,
  msigdbr_geneset_genes,
  msigdbr_genes,
  internal = TRUE,
  overwrite = TRUE,
  compress = "xz"
)
