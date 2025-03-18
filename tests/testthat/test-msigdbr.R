library(dplyr)

test_that("species variations internal database", {
  # Human genes
  m_hs_hs <- msigdbr()
  expect_s3_class(m_hs_hs, "tbl_df")
  expect_gt(nrow(m_hs_hs), 10000)
  expect_identical(m_hs_hs, msigdbr(species = "Homo sapiens"))
  expect_identical(m_hs_hs, msigdbr(db_species = "hs", species = "human"))
  # Mouse genes
  m_hs_mm <- msigdbr(species = "Mus musculus")
  expect_s3_class(m_hs_mm, "tbl_df")
  expect_gt(nrow(m_hs_mm), 10000)
  expect_identical(m_hs_mm, msigdbr(db_species = "hs", species = "mouse"))
  # Rat genes
  m_hs_rn <- msigdbr(species = "Rattus norvegicus")
  expect_s3_class(m_hs_rn, "tbl_df")
  expect_gt(nrow(m_hs_rn), 10000)
  # Column names should be identical (extra output with orthologs)
  expect_identical(names(m_hs_hs)[1:19], names(m_hs_mm)[1:19])
  expect_identical(names(m_hs_mm)[1:19], names(m_hs_rn)[1:19])
  # Ortholog conversion should not reduce the database size substantially
  expect_gt(nrow(m_hs_mm), nrow(m_hs_hs) * 0.9)
  expect_gt(nrow(m_hs_rn), nrow(m_hs_hs) * 0.9)
  # Non-supported combinations
  expect_error(msigdbr(db_species = "mm", species = "Homo sapiens"))
  expect_error(msigdbr(db_species = "mm", species = "human"))
  expect_error(msigdbr(db_species = "mm", species = "Rattus norvegicus"))
})

test_that("human and mouse databases", {
  skip_if_not_installed("msigdbdf")
  # Human database and mouse genes
  m_hs_mm <- msigdbr(species = "Mus musculus")
  expect_s3_class(m_hs_mm, "tbl_df")
  # Mouse database and genes
  m_mm_mm <- msigdbr(db_species = "mm", species = "Mus musculus")
  expect_s3_class(m_mm_mm, "tbl_df")
  # Column names should be identical (extra output with orthologs)
  expect_identical(names(m_mm_mm)[1:19], names(m_hs_mm)[1:19])
})

test_that("human db human genes", {
  skip_if_not_installed("msigdbdf")
  m_hs <- msigdbr()
  expect_s3_class(m_hs, "tbl_df")
  expect_identical(m_hs, msigdbr(species = "human"))
  expect_identical(m_hs, msigdbr(db_species = "hs", species = "human"))
  expect_gt(nrow(m_hs), 1000000)
  expect_identical(names(m_hs)[1:3], c("gene_symbol", "ncbi_gene", "ensembl_gene"))
  expect_identical(names(m_hs)[4:8], c("db_gene_symbol", "db_ncbi_gene", "db_ensembl_gene", "source_gene", "gs_id"))
  expect_gt(n_distinct(m_hs$gs_id), 30000)
  expect_gt(n_distinct(m_hs$gene_symbol), 40000)
  expect_gt(n_distinct(m_hs$ncbi_gene), 40000)
  expect_gt(n_distinct(m_hs$ensembl_gene), 40000)
  expect_equal(min(table(m_hs$gs_id)), 5)
  m_hs_sym <- distinct(m_hs, gs_id, gene_symbol)
  expect_gt(nrow(m_hs_sym), 1000000)
})

test_that("human db mouse genes", {
  skip_if_not_installed("msigdbdf")
  m_mm <- msigdbr(species = "Mus musculus")
  expect_s3_class(m_mm, "tbl_df")
  expect_identical(m_mm, msigdbr(species = "mouse"))
  expect_gt(nrow(m_mm), 1000000)
  expect_gt(n_distinct(m_mm$gs_id), 30000)
  expect_gt(n_distinct(m_mm$gene_symbol), 15000)
  expect_gt(n_distinct(m_mm$ncbi_gene), 15000)
  expect_gt(n_distinct(m_mm$ensembl_gene), 15000)
  expect_equal(max(m_mm$num_ortholog_sources), 12)
})

test_that("human db rat genes", {
  skip_if_not_installed("msigdbdf")
  m_rn <- msigdbr(species = "Rattus norvegicus")
  expect_s3_class(m_rn, "tbl_df")
  expect_identical(m_rn, msigdbr(species = "rat"))
  expect_gt(nrow(m_rn), 1000000)
  expect_gt(n_distinct(m_rn$gs_id), 30000)
  expect_gt(n_distinct(m_rn$gene_symbol), 15000)
  expect_gt(n_distinct(m_rn$ncbi_gene), 15000)
  expect_gt(n_distinct(m_rn$ensembl_gene), 15000)
  expect_equal(max(m_rn$num_ortholog_sources), 10)
})

test_that("human hallmark category", {
  # All Hallmark gene sets are present in the internal test dataset
  # Should be using internal data if msigdbdf is not installed
  m_hs_h <- msigdbr(species = "Homo sapiens", collection = "H")
  expect_s3_class(m_hs_h, "tbl_df")
  expect_gt(nrow(m_hs_h), 5000)
  expect_equal(n_distinct(m_hs_h$gs_collection), 1)
  expect_equal(n_distinct(m_hs_h$gs_subcollection), 1)
  expect_equal(n_distinct(m_hs_h$gs_id), 50)
  expect_gt(min(table(m_hs_h$gs_id)), 30)
  expect_lt(max(table(m_hs_h$gs_id)), 350)
  m_hs_h_ncbi <- distinct(m_hs_h, gs_id, ncbi_gene)
  expect_gt(min(table(m_hs_h_ncbi$gs_id)), 30)
  expect_equal(max(table(m_hs_h_ncbi$gs_id)), 200)
  m_hs_h_sym <- distinct(m_hs_h, gs_id, gene_symbol)
  expect_gt(min(table(m_hs_h_sym$gs_id)), 30)
  expect_equal(max(table(m_hs_h_sym$gs_id)), 200)
})

# test_that("collections and subcollections", {
#   m_rn_bp <- msigdbr(species = "Rattus norvegicus", collection = "C5", subcollection = "BP")
#   expect_s3_class(m_rn_bp, "tbl_df")
#   expect_gt(nrow(m_rn_bp), 100)
#   expect_equal(n_distinct(m_rn_bp$gs_collection), 1)
#   expect_equal(n_distinct(m_rn_bp$gs_subcollection), 1)
#   expect_gt(n_distinct(m_rn_bp$gs_id), 1)
# })

# test_that("subcollection partial match", {
#   m_mm_gomf <- msigdbr(species = "mouse", collection = "C5", subcollection = "GO:MF")
#   expect_s3_class(m_mm_gomf, "tbl_df")
#   expect_gt(nrow(m_mm_gomf), 100)
#   m_mm_mf <- msigdbr(species = "mouse", collection = "C5", subcollection = "MF")
#   expect_s3_class(m_mm_mf, "tbl_df")
#   expect_gt(nrow(m_mm_mf), 100)
#   expect_equal(nrow(m_mm_gomf), nrow(m_mm_mf))
#   expect_identical(m_mm_gomf, m_mm_mf)
# })

test_that("wrong parameters", {
  expect_error(msigdbr(db_species = "X"))
  expect_error(msigdbr(db_species = "RN"))
  expect_error(msigdbr(species = "test"))
  expect_error(msigdbr(species = c("Homo sapiens", "Mus musculus")))
  expect_error(msigdbr(species = ""))
  expect_error(msigdbr(species = NA))
  expect_error(msigdbr(species = "Homo sapiens", collection = "X"))
  expect_error(msigdbr(species = "Homo sapiens", collection = "X", subcollection = "X"))
  expect_error(msigdbr(species = "Homo sapiens", collection = "H", subcollection = "H"))
  expect_error(msigdbr(species = "Homo sapiens", collection = c("C1", "C2")))
  expect_error(msigdbr(species = "Homo sapiens", collection = "C2", subcollection = c("CGP", "CP")))
})

test_that("deprecated parameters", {
  expect_warning(msigdbr(species = "Homo sapiens", category = "H"))
  expect_warning(msigdbr(species = "Homo sapiens", subcategory = "CGP"))
  expect_no_error(msigdbr(species = "Homo sapiens", category = NULL))
  expect_no_error(msigdbr(species = "Homo sapiens", subcategory = NULL))
  expect_identical(nrow(msigdbr(species = "human")), nrow(msigdbr(species = "human", category = NULL)))
  m_hs <- msigdbr(species = "Homo sapiens", category = "H")
  expect_contains(colnames(m_hs), c("gene_symbol", "entrez_gene", "ensembl_gene", "gs_cat", "gs_subcat"))
})
