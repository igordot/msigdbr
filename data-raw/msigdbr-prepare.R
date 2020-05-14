
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
msigdb_version = "7.1"
msigdb_url_base = "https://data.broadinstitute.org/gsea-msigdb/msigdb/release"
msigdb_zip_url = glue("{msigdb_url_base}/{msigdb_version}/msigdb_v{msigdb_version}_files_to_download_locally.zip")
msigdb_dir = glue("msigdb_v{msigdb_version}_files_to_download_locally")

# Download the MSigDB zip file
download.file(url = msigdb_zip_url, destfile = glue("{msigdb_dir}.zip"))

# Check MSigDB XML file size in bytes
utils:::format.object_size(file.size(glue("{msigdb_dir}.zip")), units = "auto")

# Extract the MSigDB zip file
unzip(glue("{msigdb_dir}.zip"))

# Import the MSigDB XML file
msigdb_doc = read_xml(glue("{msigdb_dir}/msigdb_v{msigdb_version}.xml"))

# Delete the MSigDB zip file and its contents since they are no longer needed
file.remove(glue("{msigdb_dir}.zip"))
unlink(msigdb_dir, recursive = TRUE)

# Extract the attributes and convert into a tibble
# GENESET record attributes:
# * STANDARD_NAME: gene set name
# * SYSTEMATIC_NAME: gene set name for internal indexing purposes
# * CATEGORY_CODE: gene set collection code, e.g., C2
# * SUB_CATEGORY_CODE: gene set subcategory code, e.g., CGP
# * MEMBERS: list of gene set members as they originally appeared in the source
# * MEMBERS_SYMBOLIZED: list of gene set members in the form of human gene symbols
# * MEMBERS_EZID: list of gene set members in the form of human Entrez Gene IDs
# * MEMBERS_MAPPING: pipe-separated list of in the form of: MEMBERS, MEMBERS_SYMBOLIZED, MEMBERS_EZID
geneset_records = xml_find_all(msigdb_doc, xpath = ".//GENESET")
msigdbr_genesets =
  tibble(
    gs_name             = xml_attr(geneset_records, attr = "STANDARD_NAME"),
    gs_id               = xml_attr(geneset_records, attr = "SYSTEMATIC_NAME"),
    gs_cat              = xml_attr(geneset_records, attr = "CATEGORY_CODE"),
    gs_subcat           = xml_attr(geneset_records, attr = "SUB_CATEGORY_CODE"),
    gs_members          = xml_attr(geneset_records, attr = "MEMBERS_MAPPING")
  ) %>%
  filter(gs_cat != "ARCHIVED")

# Separate genes and gene sets
msigdbr_genes = msigdbr_genesets %>% select(gs_id, gs_members)
msigdbr_genesets = msigdbr_genesets %>% distinct(gs_id, gs_name, gs_cat, gs_subcat)
msigdbr_genesets = msigdbr_genesets %>% arrange(gs_name, gs_id)

# Check the number of gene sets per category
msigdbr_genesets %>% count(gs_cat, gs_subcat) %>% arrange(gs_cat)

# Convert to "long" format (one gene per row)
msigdbr_genes = mutate(msigdbr_genes, gs_members_split = strsplit(gs_members, "|", fixed = TRUE))
msigdbr_genes = unnest(msigdbr_genes, cols = gs_members_split, names_repair = "minimal")
msigdbr_genes =
  msigdbr_genes %>%
  separate(
    col = gs_members_split,
    into = c("source_gene", "human_gene_symbol", "human_entrez_gene"),
    sep = ","
  ) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene)) %>%
  filter(human_entrez_gene > 0)

# Create a table of human genes based on MSigDB gene mappings
human_tbl =
  msigdbr_genes %>%
  select(human_entrez_gene, human_gene_symbol) %>%
  distinct() %>%
  mutate(
    species_name = "Homo sapiens",
    entrez_gene = human_entrez_gene,
    gene_symbol = human_gene_symbol
  )

# Clean up
msigdbr_genes =
  msigdbr_genes %>%
  select(gs_id, human_entrez_gene) %>%
  arrange(gs_id, human_entrez_gene) %>%
  distinct()

# Get a list of all MSigDB genes (Entrez IDs)
msigdb_entrez_genes = msigdbr_genes %>% pull(human_entrez_gene) %>% sort() %>% unique()

# Import HCOP orthologs ---------------------------------------------------

# Import the human and ortholog data from all HCOP species
hcop_txt_url = "ftp://ftp.ebi.ac.uk/pub/databases/genenames/hcop/human_all_hcop_sixteen_column.txt.gz"
hcop = read_tsv(hcop_txt_url)

# Remove repeating databases (some are listed multiple times)
hcop = mutate(hcop, support = strsplit(support, ",", fixed = TRUE))
hcop = mutate(hcop, support = map(support, unique))
hcop = mutate(hcop, support = map_chr(support, paste, collapse = ","))

# Keep only the genes found in MSigDB and those in multiple ortholog/homolog databases
msigdbr_orthologs =
  hcop %>%
  select(
    human_entrez_gene,
    human_gene_symbol = human_symbol,
    species_id = ortholog_species,
    entrez_gene = ortholog_species_entrez_gene,
    gene_symbol = ortholog_species_symbol,
    sources = support
  ) %>%
  filter(
    human_entrez_gene != "-",
    entrez_gene != "-",
    gene_symbol != "-"
  ) %>%
  mutate(
    human_entrez_gene = as.integer(human_entrez_gene),
    entrez_gene = as.integer(entrez_gene),
    num_sources = str_count(sources, ",") + 1
  ) %>%
  filter(
    human_entrez_gene %in% msigdb_entrez_genes,
    num_sources > 2
  )

# List the number of supporting sources
table(msigdbr_orthologs$num_sources, useNA = "ifany")

# Names and IDs of common species
species_tbl =
  tibble(species_id = integer(), species_name = character()) %>%
  add_row(species_id = 4932, species_name = "Saccharomyces cerevisiae") %>%
  add_row(species_id = 6239, species_name = "Caenorhabditis elegans") %>%
  add_row(species_id = 7227, species_name = "Drosophila melanogaster") %>%
  add_row(species_id = 7955, species_name = "Danio rerio") %>%
  add_row(species_id = 9031, species_name = "Gallus gallus") %>%
  add_row(species_id = 9615, species_name = "Canis lupus familiaris") %>%
  add_row(species_id = 9823, species_name = "Sus scrofa") %>%
  add_row(species_id = 9913, species_name = "Bos taurus") %>%
  add_row(species_id = 10090, species_name = "Mus musculus") %>%
  add_row(species_id = 10116, species_name = "Rattus norvegicus")

# List available ortholog species
msigdbr_orthologs %>% pull(species_id) %>% unique() %>% sort()

# Add species names
msigdbr_orthologs = inner_join(species_tbl, msigdbr_orthologs, by = "species_id")

# For each human gene, only keep the best ortholog (found in the most databases)
msigdbr_orthologs =
  msigdbr_orthologs %>%
  select(-species_id) %>%
  group_by(human_entrez_gene, species_name) %>%
  top_n(1, num_sources) %>%
  ungroup()

# For each human gene, ignore ortholog pairs with many orthologs
msigdbr_orthologs =
  msigdbr_orthologs %>%
  add_count(human_entrez_gene, species_name) %>%
  filter(n <= 3) %>%
  select(-n)

# Add human genes from the original genesets table to the orthologs table
msigdbr_orthologs =
  msigdbr_orthologs %>%
  bind_rows(human_tbl) %>%
  select(
    human_entrez_gene, human_gene_symbol,
    species_name, entrez_gene, gene_symbol, sources, num_sources
  ) %>%
  arrange(human_gene_symbol, human_entrez_gene, species_name) %>%
  distinct()

# Show the orthologs summary stats
hcop %>%
  inner_join(species_tbl, by = c("ortholog_species" = "species_id")) %>%
  group_by(species_name) %>%
  summarize(n_distinct(ortholog_species_symbol))
msigdbr_orthologs %>%
  group_by(species_name) %>%
  summarize(n_distinct(human_gene_symbol), n_distinct(gene_symbol), max(num_sources))

# Prepare package ---------------------------------------------------------

# Check the size of final tables
format(object.size(msigdbr_genes), units = "Mb")
format(object.size(msigdbr_genesets), units = "Mb")
format(object.size(msigdbr_orthologs), units = "Mb")

# Create package data
use_data(
  msigdbr_genes,
  msigdbr_genesets,
  msigdbr_orthologs,
  internal = TRUE,
  overwrite = TRUE,
  compress = "xz"
)


