
library(dplyr)
library(tidyr)
library(readr)
library(stringr)
library(glue)
library(xml2)
library(usethis)

# Import MSigDB gene sets -------------------------------------------------

# Download the MSigDB XML file
msigdb_version = "6.2"
msigdb_xml = glue("msigdb_v{msigdb_version}.xml")
msigdb_url_base = "http://software.broadinstitute.org/gsea/msigdb/download_file.jsp?filePath=/resources/msigdb"
msigdb_xml_url = glue("{msigdb_url_base}/{msigdb_version}/msigdb_v{msigdb_version}.xml")
download.file(
  url = msigdb_xml_url, destfile = msigdb_xml, quiet = TRUE,
  method = "wget",
  extra = "-c --header='Cookie: JSESSIONID=DF8191E9C5083E0F32D4F826F46F4889'"
)

# Check MSigDB XML file size in bytes
utils:::format.object_size(file.size(msigdb_xml), units = "auto")

# Import the MSigDB XML file
msigdb_doc = read_xml(msigdb_xml)

# Delete the MSigDB XML file since it is no longer needed
file.remove(msigdb_xml)

# Extract the attributes and convert into a tibble
# GENESET record attributes:
# * STANDARD_NAME: gene set name
# * SYSTEMATIC_NAME: gene set name for internal indexing purposes
# * CATEGORY_CODE: gene set collection code, e.g., C2
# * SUB_CATEGORY_CODE: gene set subcategory code, e.g., CGP
# * MEMBERS: list of gene set members as they originally appeared in the source
# * MEMBERS_SYMBOLIZED: list of gene set members in the form of human gene symbols
# * MEMBERS_EZID: list of gene set members in the form of human Entrez Gene IDs
geneset_records = xml_find_all(msigdb_doc, xpath = ".//GENESET")
msigdbr_genesets =
  tibble(
    gs_name             = xml_attr(geneset_records, attr = "STANDARD_NAME"),
    gs_id               = xml_attr(geneset_records, attr = "SYSTEMATIC_NAME"),
    gs_cat              = xml_attr(geneset_records, attr = "CATEGORY_CODE"),
    gs_subcat           = xml_attr(geneset_records, attr = "SUB_CATEGORY_CODE"),
    gs_members_symbols  = xml_attr(geneset_records, attr = "MEMBERS_SYMBOLIZED"),
    gs_members_ezids    = xml_attr(geneset_records, attr = "MEMBERS_EZID")
  ) %>%
  filter(gs_cat != "ARCHIVED")

# Check the number of gene sets per category
msigdbr_genesets %>% count(gs_cat) %>% arrange(gs_cat)

# Create a table of human genes based on MSigDB gene mappings (for original human genesets)
human_tbl =
  msigdbr_genesets %>%
  mutate(
    species_id = 9606,
    species_name = "Homo sapiens",
    human_entrez_gene = strsplit(gs_members_ezids, ","),
    human_gene_symbol = strsplit(gs_members_symbols, ",")
  ) %>%
  unnest(human_entrez_gene, human_gene_symbol) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene)) %>%
  select(species_id, species_name, human_entrez_gene, human_gene_symbol) %>%
  distinct() %>%
  mutate(
    entrez_gene = human_entrez_gene,
    gene_symbol = human_gene_symbol
  )

# Get a list of all MSigDB genes (Entrez IDs)
msigdb_entrez_genes = human_tbl %>% pull(entrez_gene) %>% sort() %>% unique()

# Convert to "long" format (one gene per row)
msigdbr_genesets =
  msigdbr_genesets %>%
  mutate(human_entrez_gene = strsplit(gs_members_ezids, ",")) %>%
  unnest(human_entrez_gene) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene)) %>%
  select(-gs_members_symbols, -gs_members_ezids) %>%
  arrange(gs_name, human_entrez_gene)

# Import HCOP orthologs ---------------------------------------------------

# Import the human and ortholog data from all HCOP species
hcop_txt_url = "ftp://ftp.ebi.ac.uk/pub/databases/genenames/hcop/human_all_hcop_sixteen_column.txt.gz"
hcop = read_tsv(hcop_txt_url)

# Keep only the genes found in MSigDB and those in multiple ortholog/homolog databases
msigdbr_orthologs =
  hcop %>%
  select(
    human_entrez_gene,
    human_symbol,
    ortholog_species,
    ortholog_species_entrez_gene,
    ortholog_species_symbol,
    support
  ) %>%
  rename(
    human_gene_symbol = human_symbol,
    species_id = ortholog_species,
    entrez_gene = ortholog_species_entrez_gene,
    gene_symbol = ortholog_species_symbol,
    sources = support
  ) %>%
  filter(human_entrez_gene != "-") %>%
  filter(entrez_gene != "-") %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene)) %>%
  mutate(entrez_gene = as.integer(entrez_gene)) %>%
  filter(gene_symbol != "-") %>%
  filter(human_entrez_gene %in% msigdb_entrez_genes) %>%
  mutate(num_sources = str_count(sources, ",") + 1) %>%
  filter(num_sources > 1)

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
msigdbr_orthologs =
  inner_join(species_tbl, msigdbr_orthologs, by = "species_id") %>%
  select(starts_with("human"), everything())

# For each gene, only keep the best ortholog (one found in the most databases)
msigdbr_orthologs =
  msigdbr_orthologs %>%
  group_by(human_entrez_gene, species_name) %>%
  top_n(1, num_sources) %>%
  ungroup()

# Add human genes from the original genesets table to the orthologs table
msigdbr_orthologs =
  msigdbr_orthologs %>%
  bind_rows(human_tbl) %>%
  arrange(species_name, human_gene_symbol) %>%
  select(-species_id)

# Prepare package ---------------------------------------------------------

# Create package data
use_data(
  msigdbr_genesets,
  msigdbr_orthologs,
  internal = TRUE,
  overwrite = TRUE,
  compress = "xz"
)


