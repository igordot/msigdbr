library(msigdbr)
library(dplyr)

test_that("msigdbr_species()", {
  species = msigdbr_species()
  expect_s3_class(species, "tbl_df")
  expect_gt(nrow(species), 5)
  expect_lt(nrow(species), 15)
  expect_match(species$species_name, "Homo sapiens", fixed = TRUE, all = FALSE)
  expect_match(species$species_name, "Mus musculus", fixed = TRUE, all = FALSE)
  expect_match(species$species_name, "Drosophila melanogaster", fixed = TRUE, all = FALSE)
})

test_that("msigdbr_show_species()", {
  expect_warning(msigdbr_show_species())
})

test_that("msigdbr_collections()", {
  collections = msigdbr_collections()
  expect_s3_class(collections, "tbl_df")
  expect_gt(nrow(collections), 10)
  expect_lt(nrow(collections), 25)
  expect_match(collections$gs_cat, "C2", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_cat, "C7", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_subcat, "CGP", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_subcat, "CP:REACTOME", fixed = TRUE, all = FALSE)
})

test_that("all gene sets default", {
  msigdbr_hs = msigdbr()
  expect_s3_class(msigdbr_hs, "tbl_df")
  expect_gt(nrow(msigdbr_hs), 100000)
  expect_equal(min(rle(msigdbr_hs$gs_id)$lengths), 5)
  expect_lt(max(rle(msigdbr_hs$gs_id)$lengths), 2000)
})

test_that("all gene sets mouse", {
  msigdbr_mm = msigdbr(species = "Mus musculus")
  expect_s3_class(msigdbr_mm, "tbl_df")
  expect_gt(nrow(msigdbr_mm), 100000)
  expect_lt(max(msigdbr_mm$num_ortholog_sources), 15)
})

test_that("human hallmark category", {
  msigdbr_hs_h = msigdbr(species = "Homo sapiens", category = "H")
  expect_s3_class(msigdbr_hs_h, "tbl_df")
  expect_gt(nrow(msigdbr_hs_h), 5000)
  expect_equal(length(unique(msigdbr_hs_h$gs_cat)), 1)
  expect_equal(length(unique(msigdbr_hs_h$gs_subcat)), 1)
  expect_equal(length(unique(msigdbr_hs_h$gs_id)), 50)
})

test_that("mouse hallmark category", {
  msigdbr_mm_h = msigdbr(species = "Mus musculus", category = "H")
  expect_s3_class(msigdbr_mm_h, "tbl_df")
  expect_gt(nrow(msigdbr_mm_h), 5000)
  expect_equal(length(unique(msigdbr_mm_h$gs_cat)), 1)
  expect_equal(length(unique(msigdbr_mm_h$gs_subcat)), 1)
  expect_equal(length(unique(msigdbr_mm_h$gs_id)), 50)
})

test_that("human CGP subcategory", {
  msigdbr_hs_cgp = msigdbr(species = "Homo sapiens", category = "C2", subcategory = "CGP")
  expect_s3_class(msigdbr_hs_cgp, "tbl_df")
  expect_gt(nrow(msigdbr_hs_cgp), 100000)
  expect_equal(length(unique(msigdbr_hs_cgp$gs_cat)), 1)
  expect_equal(length(unique(msigdbr_hs_cgp$gs_subcat)), 1)
  expect_gt(length(unique(msigdbr_hs_cgp$gs_id)), 3000)
  expect_lt(length(unique(msigdbr_hs_cgp$gs_id)), 5000)
})

test_that("human BP subcategory", {
  msigdbr_hs_bp = msigdbr(species = "Homo sapiens", category = "C5", subcategory = "BP")
  expect_s3_class(msigdbr_hs_bp, "tbl_df")
  expect_gt(nrow(msigdbr_hs_bp), 100000)
  expect_equal(length(unique(msigdbr_hs_bp$gs_cat)), 1)
  expect_equal(length(unique(msigdbr_hs_bp$gs_subcat)), 1)
  expect_gt(length(unique(msigdbr_hs_bp$gs_id)), 7000)
  expect_lt(length(unique(msigdbr_hs_bp$gs_id)), 9000)
})

test_that("rat BP subcategory", {
  msigdbr_rn_bp = msigdbr(species = "Rattus norvegicus", category = "C5", subcategory = "BP")
  expect_s3_class(msigdbr_rn_bp, "tbl_df")
  expect_gt(nrow(msigdbr_rn_bp), 100000)
  expect_equal(length(unique(msigdbr_rn_bp$gs_cat)), 1)
  expect_equal(length(unique(msigdbr_rn_bp$gs_subcat)), 1)
  expect_gt(length(unique(msigdbr_rn_bp$gs_id)), 7000)
  expect_lt(length(unique(msigdbr_rn_bp$gs_id)), 9000)
})

test_that("subcategory partial match", {
  msigdbr_mm_gomf = msigdbr(species = "Mus musculus", category = "C5", subcategory = "GO:MF")
  expect_s3_class(msigdbr_mm_gomf, "tbl_df")
  msigdbr_mm_mf = msigdbr(species = "Mus musculus", category = "C5", subcategory = "MF")
  expect_s3_class(msigdbr_mm_mf, "tbl_df")
  expect_equal(nrow(msigdbr_mm_gomf), nrow(msigdbr_mm_mf))
  expect_identical(msigdbr_mm_gomf, msigdbr_mm_mf)
})

test_that("specific genes present in msigdbr() data frame", {
  msigdbr_hs = msigdbr()
  expect_gt(nrow(filter(msigdbr_hs, gene_symbol == "NRAS")), 100)
  expect_gt(nrow(filter(msigdbr_hs, gene_symbol == "PIK3CA")), 100)
  expect_equal(nrow(filter(msigdbr_hs, gs_id == "M30055", gene_symbol == "FOS")), 1)
  expect_equal(nrow(filter(msigdbr_hs, gs_id == "M8918", gene_symbol == "NEPNP")), 1)
})

#
test_that("wrong msigdbr() parameters", {
  expect_error(msigdbr(species = "test"))
  expect_error(msigdbr(species = c("Homo sapiens", "Mus musculus")))
  expect_error(msigdbr(species = "Homo sapiens", category = c("X")))
  expect_error(msigdbr(species = "Homo sapiens", category = c("C1", "C2")))
  expect_error(msigdbr(species = "Homo sapiens", category = "C2", subcategory = c("CGP", "CP")))
})
