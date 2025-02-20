# Prepare the test dataset

library(dplyr)

# Get the full human dataset
mdb <- msigdbdf::msigdbdf(target_species = "HS")

# Get the Hallmark gene sets
hallmark_gs_ids <- filter(mdb, gs_collection == "H") |> pull(gs_id)

# Subsample smaller gene sets from every collection and sub-collection
set.seed(99)
random_gs_ids <- mdb |>
  count(gs_id, gs_collection, gs_subcollection) |>
  filter(n < 100) |>
  group_by(gs_collection, gs_subcollection) |>
  slice_sample(n = 5) |>
  pull(gs_id)

# Subset the full table to the
subset_gs_ids <- unique(sort(c(hallmark_gs_ids, random_gs_ids)))
testdb <- filter(mdb, gs_id %in% subset_gs_ids)

# count(testdb, gs_collection, gs_subcollection)
# count(testdb, db_gene_symbol, sort = TRUE)

# Modify the version to indicate that this is a test dataset
testdb$db_version <- paste0("TEST.", testdb$db_version)

# Save package data
usethis::use_data(testdb, internal = TRUE, overwrite = TRUE, compress = "xz")
