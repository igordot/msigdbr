library(msigdbr)
context("functions")

species = msigdbr_show_species()
expect_type(species, "character")
expect_gt(length(species), 5)
expect_match(species, "Homo sapiens", fixed = TRUE, all = FALSE)
expect_match(species, "Mus musculus", fixed = TRUE, all = FALSE)
expect_match(species, "Drosophila melanogaster", fixed = TRUE, all = FALSE)

msigdbr_hs = msigdbr()
expect_s3_class(msigdbr_hs, "tbl_df")
expect_gt(nrow(msigdbr_hs), 1000)

msigdbr_mm = msigdbr(species = "Mus musculus")
expect_s3_class(msigdbr_mm, "tbl_df")
expect_gt(nrow(msigdbr_mm), 1000)
