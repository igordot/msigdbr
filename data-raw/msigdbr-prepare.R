
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

# Define MSigDB download variables
mdb_version0 <- "2023.1"
species_df<- data.frame('species_vereison' = c('Hs','Mm'),
                        'species_annotation' = c('Human','Mouse'))
for (i in 1:nrow(species_df)){
  mdb_version <- paste0(mdb_version0,'.',
                        species_df[i,'species_vereison'])
mdb_xml <- glue("msigdb_v{mdb_version}.xml")
mdb_url_base <- "https://data.broadinstitute.org/gsea-msigdb/msigdb"
mdb_xml_url <- glue("{mdb_url_base}/release/{mdb_version}/{mdb_xml}")

# Download the MSigDB XML file
options(timeout = 150)
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
msigdb_category_genesets <- mdb_tbl %>%
  distinct(gs_cat, gs_subcat, gs_id) %>%
  count(gs_cat, gs_subcat, name = "n_genesets")
msigdb_category_genesets

# Import MSigDB Ensembl mappings -----

# Download the MSigDB Ensembl mappings
ensembl_url <- glue("{mdb_url_base}/annotations/{tolower(chr)}/{chr}_Ensembl_Gene_ID_MSigDB.v{mdb_version}.chip",
                    chr = species_df[i,'species_annotation'])
ensembl_tbl <- read_tsv(ensembl_url, progress = FALSE, show_col_types = FALSE)
ensembl_tbl <- ensembl_tbl %>% select(human_ensembl_gene = `Probe Set ID`, human_gene_symbol = `Gene Symbol`)

# Generate a gene sets table -----

# Create a table for gene sets
msigdbr_genesets <- mdb_tbl %>%
  select(!gs_members) %>%
  distinct() %>%
  arrange(gs_name, gs_id)

if (nrow(msigdbr_genesets) != sum(msigdb_category_genesets$n_genesets)) stop()

# Extract gene set members -----

# Create a table for genes in a tidy/long format (one gene per row)
geneset_genes <- select(mdb_tbl, gs_id, gs_members)
geneset_genes <- mutate(geneset_genes, gs_members_split = strsplit(gs_members, "|", fixed = TRUE))
geneset_genes <- unnest(geneset_genes, cols = gs_members_split, names_repair = "minimal")
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Remove genes that do not have comma-separated parts (not a proper source gene)
geneset_genes <- filter(geneset_genes, str_detect(gs_members_split, fixed(",")))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Split gene details into columns
geneset_genes <- geneset_genes %>%
  separate(
    col = gs_members_split,
    into = c("source_gene", "human_gene_symbol", "human_entrez_gene"),
    sep = ","
  ) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Check for any strange patterns
geneset_genes %>%
  count(source_gene, sort = TRUE) %>%
  head(10)
geneset_genes %>%
  count(human_gene_symbol, human_entrez_gene, sort = TRUE) %>%
  head(10)

# Get the number of members per gene set (for testing)
# Not all members map to unique genes
msigdb_geneset_members <- geneset_genes %>% count(gs_id, name = "n_members")
msigdb_geneset_members

# Confirm that gene set sizes are reasonable
if (min(msigdb_geneset_members$n_members) < 5) stop()
if (max(msigdb_geneset_members$n_members) > 3000) stop()
if (min(geneset_genes$human_entrez_gene, na.rm = TRUE) < 1) stop()

# Skip genes without an Entrez or Ensembl ID
geneset_genes <- geneset_genes %>%
  filter(human_entrez_gene > 0 | str_detect(source_gene, "^ENSG000"))
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Keep only the relevant fields
geneset_genes <- geneset_genes %>%
  distinct(gs_id, source_gene, human_entrez_gene, human_gene_symbol)
nrow(geneset_genes) %>% prettyNum(big.mark = ",")

# Generate gene IDs -----

# Split genes based on if they include Ensembl IDs
# Starting with MSigDB 7.0, Ensembl is the platform annotation authority
# Add internal gene ID to track both Entrez and Ensembl genes
# Using Ensembl IDs as IDs for all genes resulted in a larger data file
geneset_genes_entrez <- geneset_genes %>%
  filter(str_detect(source_gene, "^ENSG000", negate = TRUE)) %>%
  distinct(gs_id, human_entrez_gene, human_gene_symbol) %>%
  mutate(gene_id = human_entrez_gene) %>%
  arrange(gs_id, gene_id)
geneset_genes_ensembl <- geneset_genes %>%
  filter(str_detect(source_gene, "^ENSG000")) %>%
  select(gs_id, human_entrez_gene, human_ensembl_gene = source_gene, human_gene_symbol) %>%
  mutate(human_gene_symbol = if_else(human_gene_symbol == "", human_ensembl_gene, human_gene_symbol)) %>%
  mutate(gene_id = str_replace(human_ensembl_gene, "ENSG000", "9")) %>%
  mutate(gene_id = as.integer(gene_id)) %>%
  arrange(gs_id, gene_id)

# Check that the gene IDs are distinct for Entrez and Ensembl tables
intersect(geneset_genes_entrez$gene_id, geneset_genes_ensembl$gene_id)

# Most gene sets should not have only some source genes as Ensembl IDs
intersect(geneset_genes_entrez$gs_id, geneset_genes_ensembl$gs_id)

# Determine unambiguous genes with only one Entrez and Ensembl ID
clean_entrez_genes <- geneset_genes_ensembl %>%
  distinct(human_entrez_gene, human_gene_symbol, human_ensembl_gene) %>%
  count(human_entrez_gene) %>%
  filter(n == 1) %>%
  pull(human_entrez_gene)
length(clean_entrez_genes)

# Use the Entrez ID for unambiguous genes
geneset_genes_ensembl <- geneset_genes_ensembl %>%
  mutate(gene_id = if_else(human_entrez_gene %in% clean_entrez_genes, human_entrez_gene, gene_id)) %>%
  arrange(gs_id, gene_id)

# Check the number of genes
nrow(geneset_genes_entrez)
n_distinct(geneset_genes_entrez$gene_id)
n_distinct(geneset_genes_entrez$human_gene_symbol)
n_distinct(geneset_genes_entrez$human_entrez_gene)
nrow(geneset_genes_ensembl)
n_distinct(geneset_genes_ensembl$gene_id)
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

# Generate a gene set members table -----

# Combine Entrez and Ensembl genes into a single table
msigdbr_geneset_genes <-
  bind_rows(geneset_genes_entrez, geneset_genes_ensembl) %>%
  distinct(gs_id, gene_id) %>%
  arrange(gs_id, gene_id)

# Check the total number of gene set members
nrow(msigdbr_geneset_genes) %>% prettyNum(big.mark = ",")

# Check that all the original gene sets are present
if (length(setdiff(msigdb_geneset_members$gs_id, msigdbr_geneset_genes$gs_id)) > 0) stop()

# Check that most of the original gene set members converted to genes
if (nrow(msigdbr_geneset_genes) < (sum(msigdb_geneset_members$n_members) * 0.85)) stop()
genes_members_ratio = full_join(msigdb_geneset_members, count(msigdbr_geneset_genes, gs_id, name = "n_genes"), by = "gs_id")
genes_members_ratio$ratio = genes_members_ratio$n_genes / genes_members_ratio$n_members
if (min(genes_members_ratio$n_genes) < 5) stop()
if (max(genes_members_ratio$n_genes) > 2300) stop()
if (max(genes_members_ratio$ratio) > 1) stop()
if (quantile(genes_members_ratio$ratio, 0.001) < 0.3) stop()
if (quantile(genes_members_ratio$ratio, 0.1) < 0.7) stop()
if (quantile(genes_members_ratio$ratio, 0.2) < 0.9) stop()
if (quantile(genes_members_ratio$ratio, 0.3) < 0.99) stop()

# Generate a genes table -----

# Extract the unique genes
msigdbr_genes <-
  bind_rows(geneset_genes_entrez, geneset_genes_ensembl) %>%
  select(gene_id, human_gene_symbol, human_entrez_gene, human_ensembl_gene) %>%
  distinct() %>%
  arrange(human_gene_symbol, gene_id)

# Check the total number of genes
nrow(msigdbr_genes)

# Prepare package -----

# Check the size of final tables
format(object.size(msigdbr_genesets), units = "Mb")
format(object.size(msigdbr_geneset_genes), units = "Mb")
format(object.size(msigdbr_genes), units = "Mb")

# Create package data
for (j in c('msigdbr_genesets',
            'msigdbr_geneset_genes',
            'msigdbr_genes')){
  assign(x = paste0(j,
                    species_df[i,'species_vereison']),
         value = eval(parse(text=j)))
  do.call("use_data",
          list(as.name(
            paste0(j,
                   species_df[i,'species_vereison'])),
            internal = F,
            overwrite = TRUE,
            compress = "xz"))
}
}
