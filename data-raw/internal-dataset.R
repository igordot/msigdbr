# Prepare the test dataset

library(dplyr)

# Get the full human dataset
mdb <- msigdbdf::msigdbdf(target_species = "HS")

# Get the Hallmark gene sets
hallmark_gs_ids <- filter(mdb, gs_collection == "H") |>
  pull(gs_id) |>
  unique()

# Get genes that are part of many C2 (curated gene sets) gene sets
common_genes <- mdb |>
  filter(gs_collection == "C2") |>
  distinct(gs_id, db_gene_symbol) |>
  count(db_gene_symbol, sort = TRUE) |>
  pull(db_gene_symbol) |>
  head(100)

# Get gene sets that include popular genes (likely more familiar)
common_gs_ids <- mdb |>
  filter(db_gene_symbol %in% common_genes) |>
  pull(gs_id) |>
  unique()

# Subsample smaller gene sets from every collection and sub-collection
set.seed(99)
random_gs_ids <- mdb |>
  filter(gs_id %in% common_gs_ids) |>
  distinct(source_gene, gs_id, gs_collection, gs_subcollection) |>
  count(gs_id, gs_collection, gs_subcollection) |>
  filter(n < 100) |>
  group_by(gs_collection, gs_subcollection) |>
  slice_sample(n = 20) |>
  slice_min(order_by = n, n = 5, with_ties = FALSE) |>
  pull(gs_id)

# Subset the full table to the selected gene sets
subset_gs_ids <- unique(sort(c(hallmark_gs_ids, random_gs_ids)))
testdb <- filter(mdb, gs_id %in% subset_gs_ids)
testdb <- arrange(testdb, gs_name, db_gene_symbol)

# count(testdb, gs_collection, gs_subcollection)
# count(testdb, db_gene_symbol, sort = TRUE)

# Modify the version to indicate that this is a test dataset
testdb$db_version <- paste0("TEST.", testdb$db_version)

# Save package data
usethis::use_data(testdb, internal = TRUE, overwrite = TRUE, compress = "xz")

