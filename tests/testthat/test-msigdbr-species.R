test_that("msigdbr_species()", {
  species <- msigdbr_species()
  expect_s3_class(species, "tbl_df")
  expect_equal(nrow(species), 20)
  expect_identical(colnames(species), c("species_name", "species_common_name"))
  expect_match(species$species_name, "Homo sapiens", fixed = TRUE, all = FALSE)
  expect_match(species$species_name, "Mus musculus", fixed = TRUE, all = FALSE)
  expect_match(species$species_name, "Drosophila melanogaster", fixed = TRUE, all = FALSE)
})
