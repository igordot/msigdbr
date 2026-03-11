# Skip on CRAN due to long run-time and use of web resources
skip_on_cran()

test_that("msigdbr_collections()", {
  chs <- msigdbr_collections(db_species = "Hs")
  expect_identical(chs, msigdbr_collections())
  expect_identical(names(chs), c("db_version", "gs_collection", "gs_subcollection", "gs_collection_name", "num_genesets"))
  expect_gt(nrow(chs), 10)
  expect_lt(nrow(chs), 30)
  expect_match(chs$gs_collection, "H", fixed = TRUE, all = FALSE)
  expect_match(chs$gs_collection, "C2", fixed = TRUE, all = FALSE)
  expect_match(chs$gs_collection, "C7", fixed = TRUE, all = FALSE)
  expect_match(chs$gs_collection, "C8", fixed = TRUE, all = FALSE)
  cmm <- msigdbr_collections(db_species = "Mm")
  expect_gt(nrow(cmm), 10)
  expect_lt(nrow(cmm), 30)
  expect_match(cmm$gs_collection, "MH", fixed = TRUE, all = FALSE)
  expect_match(cmm$gs_collection, "M8", fixed = TRUE, all = FALSE)
})
