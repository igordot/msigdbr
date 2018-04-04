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
expect_gt(nrow(msigdbr_hs), 100000)

msigdbr_mm = msigdbr(species = "Mus musculus")
expect_s3_class(msigdbr_mm, "tbl_df")
expect_gt(nrow(msigdbr_mm), 100000)

msigdbr_h = msigdbr(species = "Homo sapiens", category = "H")
expect_s3_class(msigdbr_h, "tbl_df")
expect_gt(nrow(msigdbr_h), 1000)

msigdbr_cp = msigdbr(species = "Homo sapiens", category = "C2", subcategory = "CP")
expect_s3_class(msigdbr_cp, "tbl_df")
expect_gt(nrow(msigdbr_cp), 1000)

msigdbr_bp = msigdbr(species = "Homo sapiens", category = "C5", subcategory = "BP")
expect_s3_class(msigdbr_bp, "tbl_df")
expect_gt(nrow(msigdbr_bp), 1000)

expect_error(msigdbr(species = "x"))
