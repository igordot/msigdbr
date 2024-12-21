
library(dplyr)
library(tidyr)
library(purrr)
library(readr)
library(stringr)
library(glue)
library(xml2)
library(usethis)
options(pillar.print_max = 100)

# Import MSigDB gene sets -----

# Set MSigDB version
mdb_version <- "2022.1.Hs"

# Set HGNC version (last quarterly release before MSigDB release)
hgnc_version <- "2022-07-01"

# Set MSigDB file paths
mdb_xml <- glue("msigdb_v{mdb_version}.xml")
mdb_url_base <- "https://data.broadinstitute.org/gsea-msigdb/msigdb"
mdb_xml_url <- glue("{mdb_url_base}/release/{mdb_version}/{mdb_xml}")

# Download the MSigDB XML file
options(timeout = 300)
download.file(url = mdb_xml_url, destfile = mdb_xml)

# Check MSigDB XML file size in bytes
utils:::format.object_size(file.size(mdb_xml), units = "auto")

# Import the MSigDB XML file (fails if loaded directly from URL)
mdb_doc <- read_xml(mdb_xml)

# Delete the MSigDB XML file and its contents since they are no longer needed
file.remove(mdb_xml)

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

# Get the number of gene sets per collection (for testing)
mdb_category_genesets <- mdb_tbl %>%
  distinct(gs_cat, gs_subcat, gs_id) %>%
  count(gs_cat, gs_subcat, name = "n_genesets")
mdb_category_genesets

# Import MSigDB Ensembl mappings -----

# Download MSigDB Ensembl mappings
# Should include all MSigDB genes
ensembl_url <- glue("{mdb_url_base}/annotations/human/Human_Ensembl_Gene_ID_MSigDB.v{mdb_version}.chip")
ensembl_tbl <- read_tsv(ensembl_url, progress = FALSE, show_col_types = FALSE)
ensembl_tbl <- distinct(ensembl_tbl, human_ensembl_gene = `Probe Set ID`, human_gene_symbol = `Gene Symbol`)
ensembl_tbl <- arrange(ensembl_tbl, human_ensembl_gene)

# Check for multi-mappers (should be many)
count(ensembl_tbl, human_ensembl_gene, sort = TRUE)
count(ensembl_tbl, human_gene_symbol, sort = TRUE)

# Import HGNC mappings -----

# Download HGNC mappings
# May not include all MSigDB genes, but there is usually one Ensembl ID per gene
hgnc_url <- glue("https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/archive/quarterly/tsv/hgnc_complete_set_{hgnc_version}.txt")
hgnc_tbl <- read_tsv(hgnc_url, progress = FALSE, show_col_types = FALSE, guess_max = 10000)
hgnc_tbl <- distinct(hgnc_tbl, human_ensembl_gene = ensembl_gene_id, human_entrez_gene = entrez_id)
hgnc_tbl <- mutate(hgnc_tbl, human_entrez_gene = as.integer(human_entrez_gene))

# Keep only MSigDB Ensembl IDs
setdiff(hgnc_tbl$human_ensembl_gene, ensembl_tbl$human_ensembl_gene) %>% length()
hgnc_tbl <- filter(hgnc_tbl, human_ensembl_gene %in% ensembl_tbl$human_ensembl_gene)
hgnc_tbl <- arrange(hgnc_tbl, human_ensembl_gene)

# Check for multi-mappers (should be few)
count(hgnc_tbl, human_ensembl_gene, sort = TRUE)
count(hgnc_tbl, human_entrez_gene, sort = TRUE)

# Generate a gene sets table -----

# Create a table for gene sets
msigdbr_genesets <- mdb_tbl %>%
  select(!gs_members) %>%
  distinct() %>%
  arrange(gs_name, gs_id)

if (nrow(msigdbr_genesets) != sum(mdb_category_genesets$n_genesets)) stop()

# Extract gene set members -----

# Create a table for genes in a tidy/long format (one gene per row)
geneset_genes <- select(mdb_tbl, gs_id, gs_members)
geneset_genes <- mutate(geneset_genes, gs_members_split = strsplit(gs_members, "|", fixed = TRUE))
geneset_genes <- unnest(geneset_genes, cols = gs_members_split, names_repair = "minimal")
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Remove genes that do not have comma-separated parts (not a proper source gene)
geneset_genes <- filter(geneset_genes, str_detect(gs_members_split, fixed(",")))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Split member details into separate columns
geneset_genes <- geneset_genes %>%
  separate(
    col = gs_members_split,
    into = c("source_gene", "human_gene_symbol", "human_entrez_gene"),
    sep = ","
  ) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Check for any strange patterns
count(geneset_genes, source_gene, sort = TRUE)
count(geneset_genes, human_gene_symbol, human_entrez_gene, sort = TRUE)

# Get the number of members per gene set (for testing)
# Not all members map to unique genes
mdb_geneset_members <- geneset_genes %>% count(gs_id, name = "n_members")
mdb_geneset_members

# Confirm that gene set sizes are reasonable
if (min(mdb_geneset_members$n_members) < 5) stop()
if (max(mdb_geneset_members$n_members) > 3000) stop()
if (min(geneset_genes$human_entrez_gene, na.rm = TRUE) < 1) stop()

# Skip genes without an Entrez or Ensembl ID
geneset_genes <- geneset_genes %>%
  filter(human_entrez_gene > 0 | str_detect(source_gene, "^ENSG000"))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Keep only the relevant fields
geneset_genes <- geneset_genes %>%
  distinct(gs_id, source_gene, human_entrez_gene, human_gene_symbol)
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Add Ensembl IDs to genes without them -----

# Split genes based on if they include Ensembl IDs
# Starting with MSigDB 7.0, Ensembl is the platform annotation authority
# Add internal gene ID to track both Entrez and Ensembl genes
# Using Ensembl IDs as IDs for all genes resulted in a larger data file
geneset_genes_entrez <- geneset_genes %>%
  filter(str_detect(source_gene, "^ENSG000", negate = TRUE)) %>%
  distinct(gs_id, human_entrez_gene, human_gene_symbol)
geneset_genes_ensembl <- geneset_genes %>%
  filter(str_detect(source_gene, "^ENSG000")) %>%
  select(gs_id, human_entrez_gene, human_ensembl_gene = source_gene, human_gene_symbol) %>%
  mutate(human_gene_symbol = if_else(human_gene_symbol == "", human_ensembl_gene, human_gene_symbol))

# Very few gene sets should have only some source genes as Ensembl IDs
intersect(geneset_genes_entrez$gs_id, geneset_genes_ensembl$gs_id)

# Check the number of genes
nrow(geneset_genes_entrez) %>% prettyNum(big.mark = ",")
n_distinct(geneset_genes_entrez$human_gene_symbol)
n_distinct(geneset_genes_entrez$human_entrez_gene)
nrow(geneset_genes_ensembl) %>% prettyNum(big.mark = ",")
n_distinct(geneset_genes_ensembl$human_gene_symbol)
n_distinct(geneset_genes_ensembl$human_ensembl_gene)

if (length(setdiff(geneset_genes_entrez$human_gene_symbol, ensembl_tbl$human_gene_symbol))) stop()

# Further split genes without Ensembl IDs based on HGNC Ensembl IDs
geneset_genes_entrez_hgnc <- geneset_genes_entrez %>%
  filter(human_entrez_gene %in% hgnc_tbl$human_entrez_gene)
geneset_genes_entrez_ensembl <- geneset_genes_entrez %>%
  filter(!human_entrez_gene %in% hgnc_tbl$human_entrez_gene)

# Add Ensembl IDs to genes without them
geneset_genes_entrez_hgnc <- left_join(geneset_genes_entrez_hgnc, hgnc_tbl, by = "human_entrez_gene")
geneset_genes_entrez_ensembl <- left_join(geneset_genes_entrez_ensembl, ensembl_tbl, by = "human_gene_symbol")

# Check the number of genes
nrow(geneset_genes_entrez_hgnc) %>% prettyNum(big.mark = ",")
n_distinct(geneset_genes_entrez_hgnc$human_entrez_gene)
n_distinct(geneset_genes_entrez_hgnc$human_ensembl_gene)
nrow(geneset_genes_entrez_ensembl) %>% prettyNum(big.mark = ",")
n_distinct(geneset_genes_entrez_ensembl$human_entrez_gene)
n_distinct(geneset_genes_entrez_ensembl$human_ensembl_gene)

# Combine different types of genes into a single table
geneset_genes_clean <-
  bind_rows(geneset_genes_entrez_hgnc, geneset_genes_entrez_ensembl, geneset_genes_ensembl) %>%
  mutate(gene_id = str_remove(human_ensembl_gene, "ENSG000")) %>%
  mutate(gene_id = as.integer(gene_id)) %>%
  distinct() %>%
  arrange(gs_id, gene_id)
nrow(geneset_genes_clean) %>% prettyNum(big.mark = ",")

# Make internal IDs consecutive
geneset_genes_clean$gene_id <- dense_rank(geneset_genes_clean$gene_id)
geneset_genes_clean %>%
  count(human_gene_symbol, gene_id) %>%
  arrange(human_gene_symbol)
geneset_genes_clean %>%
  count(human_ensembl_gene, gene_id) %>%
  arrange(human_ensembl_gene)

# Generate a gene set members table -----

# Combine Entrez and Ensembl genes into a single table
msigdbr_geneset_genes <- geneset_genes_clean %>%
  distinct(gs_id, gene_id) %>%
  arrange(gs_id, gene_id)

# Check gene numbers
nrow(geneset_genes) %>% prettyNum(big.mark = ",")
nrow(msigdbr_geneset_genes) %>% prettyNum(big.mark = ",")

# Check that all the original gene sets are present
if (length(setdiff(mdb_geneset_members$gs_id, msigdbr_geneset_genes$gs_id)) > 0) stop()

# Check that most of the original gene set members converted to genes
if (nrow(msigdbr_geneset_genes) < (sum(mdb_geneset_members$n_members) * 0.85)) stop()
genes_members_ratio <- full_join(mdb_geneset_members, count(msigdbr_geneset_genes, gs_id, name = "n_genes"), by = "gs_id")
genes_members_ratio$ratio <- genes_members_ratio$n_genes / genes_members_ratio$n_members
if (min(genes_members_ratio$n_genes) < 5) stop()
if (max(genes_members_ratio$n_genes) > 2300) stop()
if (max(genes_members_ratio$ratio) > 2) stop()
if (quantile(genes_members_ratio$ratio, 0.99) > 1) stop()
if (quantile(genes_members_ratio$ratio, 0.001) < 0.3) stop()
if (quantile(genes_members_ratio$ratio, 0.1) < 0.7) stop()
if (quantile(genes_members_ratio$ratio, 0.2) < 0.9) stop()
if (quantile(genes_members_ratio$ratio, 0.3) < 0.99) stop()

# Generate a genes table -----

# Extract the unique genes
msigdbr_genes <- geneset_genes_clean %>%
  distinct(gene_id, human_gene_symbol, human_entrez_gene, human_ensembl_gene) %>%
  arrange(human_gene_symbol, gene_id)

# Check the total number of genes
nrow(msigdbr_genes) %>% prettyNum(big.mark = ",")

# Prepare package -----

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
