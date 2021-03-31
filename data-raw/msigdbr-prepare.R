
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
msigdb_version <- "7.3"
msigdb_url_base <- "https://data.broadinstitute.org/gsea-msigdb/msigdb"
msigdb_zip_url <- glue("{msigdb_url_base}/release/{msigdb_version}/msigdb_v{msigdb_version}_files_to_download_locally.zip")
msigdb_dir <- glue("msigdb_v{msigdb_version}_files_to_download_locally")
msigdb_ensembl_url <- glue("{msigdb_url_base}/annotations_versioned/Human_ENSEMBL_Gene_ID_MSigDB.v{msigdb_version}.chip")

# Download the MSigDB zip file
download.file(url = msigdb_zip_url, destfile = glue("{msigdb_dir}.zip"))

# Check MSigDB XML file size in bytes
utils:::format.object_size(file.size(glue("{msigdb_dir}.zip")), units = "auto")

# Extract the MSigDB zip file
unzip(glue("{msigdb_dir}.zip"))

# Import the MSigDB XML file
msigdb_doc <- read_xml(glue("{msigdb_dir}/msigdb_v{msigdb_version}.xml"))

# Delete the MSigDB zip file and its contents since they are no longer needed
file.remove(glue("{msigdb_dir}.zip"))
unlink(msigdb_dir, recursive = TRUE)

# Extract the XML attributes and convert into a tibble
# https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/MSigDB_XML_description
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
geneset_records <- xml_find_all(msigdb_doc, xpath = ".//GENESET")
msigdbr_genesets <-
  tibble(
    gs_name = xml_attr(geneset_records, attr = "STANDARD_NAME"),
    gs_id = xml_attr(geneset_records, attr = "SYSTEMATIC_NAME"),
    gs_cat = xml_attr(geneset_records, attr = "CATEGORY_CODE"),
    gs_subcat = xml_attr(geneset_records, attr = "SUB_CATEGORY_CODE"),
    gs_pmid = xml_attr(geneset_records, attr = "PMID"),
    gs_geoid = xml_attr(geneset_records, attr = "GEOID"),
    gs_exact_source = xml_attr(geneset_records, attr = "EXACT_SOURCE"),
    gs_url = xml_attr(geneset_records, attr = "EXTERNAL_DETAILS_URL"),
    gs_description = xml_attr(geneset_records, attr = "DESCRIPTION_BRIEF"),
    gs_members = xml_attr(geneset_records, attr = "MEMBERS_MAPPING")
  ) %>%
  filter(gs_cat != "ARCHIVED")

# Separate genes and gene sets
msigdbr_genes <- msigdbr_genesets %>% select(gs_id, gs_members)
msigdbr_genesets <-
  msigdbr_genesets %>%
  select(!gs_members) %>%
  distinct() %>%
  arrange(gs_name, gs_id)

# Check the number of gene sets per category
msigdbr_genesets %>%
  count(gs_cat, gs_subcat) %>%
  arrange(gs_cat)

# Convert to "long" format (one gene per row)
msigdbr_genes <- mutate(msigdbr_genes, gs_members_split = strsplit(gs_members, "|", fixed = TRUE))
msigdbr_genes <- unnest(msigdbr_genes, cols = gs_members_split, names_repair = "minimal")
msigdbr_genes <-
  msigdbr_genes %>%
  separate(
    col = gs_members_split,
    into = c("source_gene", "human_gene_symbol", "human_entrez_gene"),
    sep = ","
  ) %>%
  mutate(human_entrez_gene = as.integer(human_entrez_gene))

# Skip genes without an Entrez ID entry (some only have the source gene)
msigdbr_genes <- msigdbr_genes %>% filter(human_entrez_gene > 0)

# Create a table of human genes based on the MSigDB gene mappings
human_genes <- msigdbr_genes %>% distinct(human_entrez_gene, human_gene_symbol)

# Clean up
msigdbr_genes <-
  msigdbr_genes %>%
  select(gs_id, human_entrez_gene) %>%
  arrange(gs_id, human_entrez_gene) %>%
  distinct()

# Get a list of all MSigDB genes (Entrez IDs)
msigdb_entrez_genes <- human_genes %>% pull(human_entrez_gene) %>% sort()
length(msigdb_entrez_genes)

# Download the MSigDB Ensembl mappings
msigdb_ensembl <- read_tsv(msigdb_ensembl_url, col_types = cols())

# Get a list of all MSigDB genes (Ensembl IDs)
msigdb_ensembl_genes <- msigdb_ensembl %>% pull(`Probe Set ID`)
length(msigdb_ensembl_genes)

# Import HCOP orthologs ---------------------------------------------------

# Import the human and ortholog data from all HCOP species
hcop_txt_url <- "ftp://ftp.ebi.ac.uk/pub/databases/genenames/hcop/human_all_hcop_sixteen_column.txt.gz"
hcop <- read_tsv(hcop_txt_url, col_types = cols())

# Check the number of genes in the HCOP table
n_distinct(hcop$human_entrez_gene)
n_distinct(hcop$human_ensembl_gene)
hcop %>% distinct(ortholog_species, ortholog_species_entrez_gene) %>% count(ortholog_species)

# Keep only the genes with Entrez IDs
hcop <-
  hcop %>%
  filter(
    human_entrez_gene != "-",
    ortholog_species_entrez_gene != "-",
    ortholog_species_symbol != "-"
  ) %>%
  mutate(
    human_entrez_gene = as.integer(human_entrez_gene),
    ortholog_species_entrez_gene = as.integer(ortholog_species_entrez_gene)
  )

# Keep only the genes found in MSigDB
hcop <-
  hcop %>%
  filter(
    human_entrez_gene %in% msigdb_entrez_genes,
    human_ensembl_gene %in% msigdb_ensembl_genes
  )

# Remove repeating databases (some are listed multiple times)
hcop <- mutate(hcop, support = strsplit(support, ",", fixed = TRUE))
hcop <- mutate(hcop, support = map(support, unique))
hcop <- mutate(hcop, support = map_chr(support, paste, collapse = ","))

# Keep only the genes in multiple ortholog/homolog databases
msigdbr_orthologs <-
  hcop %>%
  select(
    human_entrez_gene,
    human_ensembl_gene,
    human_gene_symbol = human_symbol,
    species_id = ortholog_species,
    entrez_gene = ortholog_species_entrez_gene,
    ensembl_gene = ortholog_species_ensembl_gene,
    gene_symbol = ortholog_species_symbol,
    ortholog_sources = support
  ) %>%
  mutate(num_ortholog_sources = str_count(ortholog_sources, ",") + 1) %>%
  filter(num_ortholog_sources > 2)

# List the number of supporting sources
msigdbr_orthologs %>% select(species_id, num_ortholog_sources) %>% table(useNA = "ifany")

# Names and IDs of common species
species_tbl <-
  tibble(species_id = integer(), species_name = character(), species_common_name = character()) %>%
  add_row(species_id = 4932, species_name = "Saccharomyces cerevisiae", species_common_name = "baker's or brewer's yeast") %>%
  add_row(species_id = 6239, species_name = "Caenorhabditis elegans", species_common_name = "roundworm") %>%
  add_row(species_id = 7227, species_name = "Drosophila melanogaster", species_common_name = "fruit fly") %>%
  add_row(species_id = 7955, species_name = "Danio rerio", species_common_name = "zebrafish") %>%
  add_row(species_id = 8364, species_name = "Xenopus tropicalis", species_common_name = "tropical clawed frog") %>%
  add_row(species_id = 9031, species_name = "Gallus gallus", species_common_name = "chicken") %>%
  add_row(species_id = 9258, species_name = "Ornithorhynchus anatinus", species_common_name = "platypus") %>%
  add_row(species_id = 9544, species_name = "Macaca mulatta", species_common_name = "Rhesus monkey") %>%
  add_row(species_id = 9598, species_name = "Pan troglodytes", species_common_name = "chimpanzee") %>%
  add_row(species_id = 9615, species_name = "Canis lupus familiaris", species_common_name = "dog") %>%
  add_row(species_id = 9823, species_name = "Sus scrofa", species_common_name = "pig") %>%
  add_row(species_id = 9913, species_name = "Bos taurus", species_common_name = "cattle") %>%
  add_row(species_id = 10090, species_name = "Mus musculus", species_common_name = "house mouse") %>%
  add_row(species_id = 10116, species_name = "Rattus norvegicus", species_common_name = "Norway rat")

# List available ortholog species
msigdbr_orthologs %>%
  pull(species_id) %>%
  unique() %>%
  sort()

# Add species names
msigdbr_orthologs <- inner_join(species_tbl, msigdbr_orthologs, by = "species_id")

# For each human gene, only keep the best ortholog (found in the most databases)
msigdbr_orthologs <-
  msigdbr_orthologs %>%
  group_by(human_entrez_gene, species_name) %>%
  top_n(1, num_ortholog_sources) %>%
  ungroup()

# For each human gene, ignore ortholog pairs with many orthologs
msigdbr_orthologs <-
  msigdbr_orthologs %>%
  add_count(human_entrez_gene, species_name) %>%
  filter(n <= 3) %>%
  select(-n)

# Create a table of human genes in orthologs table format
human_genes <-
  hcop %>%
  distinct(human_entrez_gene, human_ensembl_gene) %>%
  right_join(human_genes, by = "human_entrez_gene") %>%
  select(human_entrez_gene, human_ensembl_gene, human_gene_symbol) %>%
  distinct() %>%
  mutate(
    species_name = "Homo sapiens",
    species_common_name = "human",
    entrez_gene = human_entrez_gene,
    ensembl_gene = human_ensembl_gene,
    gene_symbol = human_gene_symbol
  )

# Add human genes to the orthologs table
msigdbr_orthologs <-
  msigdbr_orthologs %>%
  bind_rows(human_genes) %>%
  select(
    human_entrez_gene, human_gene_symbol,
    species_name, species_common_name,
    entrez_gene, ensembl_gene, gene_symbol,
    ortholog_sources, num_ortholog_sources
  ) %>%
  arrange(human_gene_symbol, human_entrez_gene, species_name) %>%
  distinct()

# Show the orthologs summary stats
hcop %>%
  inner_join(species_tbl, by = c("ortholog_species" = "species_id")) %>%
  group_by(species_name, species_common_name) %>%
  summarize(n_distinct(ortholog_species_symbol))
msigdbr_orthologs %>%
  group_by(species_name) %>%
  summarize(n_distinct(human_gene_symbol), n_distinct(gene_symbol), max(num_ortholog_sources))

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
