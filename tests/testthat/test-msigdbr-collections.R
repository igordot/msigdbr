library(msigdbr)

test_that("msigdbr_collections()", {
  collections <- msigdbr_collections()
  expect_s3_class(collections, "tbl_df")
  expect_gt(nrow(collections), 20)
  expect_lt(nrow(collections), 25)
  expect_match(collections$gs_cat, "C2", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_cat, "C7", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_subcat, "CGP", fixed = TRUE, all = FALSE)
  expect_match(collections$gs_subcat, "CP:REACTOME", fixed = TRUE, all = FALSE)
})
