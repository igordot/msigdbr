local_release_cache <- function(env = parent.frame()) {
  summary_rds <- resolve_cache()
  archive <- download_zip(tools::R_user_dir("msigdbr", "cache"))
  root <- withr::local_tempdir(.local_envir = env)
  withr::local_envvar(R_USER_CACHE_DIR = root, .local_envir = env)
  local_mocked_bindings(pkg_env = new.env(parent = emptyenv()), .env = env)
  cache_dir <- tools::R_user_dir("msigdbr", "cache")
  dir.create(cache_dir, recursive = TRUE)
  file.copy(archive, cache_dir)
  utils::unzip(archive, exdir = cache_dir)
  file.path(cache_dir, summary_rds)
}

test_that("listing collections restores a truncated summary", {
  skip_on_cran()
  path <- local_release_cache()
  checksum <- tools::md5sum(path)
  writeBin(readBin(path, "raw", 8), path)
  expect_gt(nrow(msigdbr_collections()), 0)
  expect_identical(tools::md5sum(path), checksum)
})

test_that("loading gene sets restores an empty collection", {
  skip_on_cran()
  summary_path <- local_release_cache()
  summary <- readRDS(summary_path)
  path <- file.path(
    dirname(summary_path),
    summary$df_rds[match("H", summary$gs_collection)]
  )
  checksum <- tools::md5sum(path)
  file.create(path)
  expect_gt(nrow(msigdbr(collection = "H")), 0)
  expect_identical(tools::md5sum(path), checksum)
})

test_that("overwriting refreshes cached summaries, gene sets, and orthologs", {
  skip_on_cran()
  resolve_cache()
  archive <- download_zip(tools::R_user_dir("msigdbr", "cache"))
  withr::local_envvar(R_USER_CACHE_DIR = withr::local_tempdir())
  local_mocked_bindings(
    pkg_env = new.env(parent = emptyenv()),
    download_zip = function(...) archive
  )

  expected <- msigdbr(species = "mouse", collection = "H")
  resolve_cache(overwrite = TRUE)

  expect_length(ls(pkg_env), 0L)
  expect_identical(
    msigdbr(species = "mouse", collection = "H"),
    expected
  )
})

test_that("missing collection files are restored from the cached archive", {
  skip_on_cran()
  summary_rds <- resolve_cache()
  archive <- download_zip(tools::R_user_dir("msigdbr", "cache"))
  withr::local_envvar(R_USER_CACHE_DIR = withr::local_tempdir())
  local_mocked_bindings(
    pkg_env = new.env(parent = emptyenv()),
    download_zip = function(...) archive
  )

  expected <- load_gene_sets("HS", "H")
  cache_dir <- tools::R_user_dir("msigdbr", "cache")
  summary <- readRDS(file.path(cache_dir, summary_rds))
  collection_path <- file.path(
    cache_dir,
    summary$df_rds[match("H", summary$gs_collection)]
  )
  unlink(collection_path)

  resolve_cache()

  expect_identical(file.exists(collection_path), TRUE)
  expect_identical(load_gene_sets("HS", "H"), expected)
})

test_that("valid cached archives are reused and corrupt ones are replaced", {
  skip_on_cran()
  resolve_cache()
  archive <- download_zip(tools::R_user_dir("msigdbr", "cache"))
  cache_dir <- withr::local_tempdir()
  cached_zip <- file.path(cache_dir, basename(archive))
  file.copy(archive, cached_zip)

  downloads <- 0L
  local_mocked_bindings(
    curl_download = function(url, destfile, ...) {
      downloads <<- downloads + 1L
      file.copy(archive, destfile, overwrite = TRUE)
      invisible(destfile)
    },
    .package = "curl"
  )

  expect_identical(download_zip(cache_dir), cached_zip)
  expect_identical(downloads, 0L)

  writeLines("corrupt archive", cached_zip)
  expect_identical(suppressMessages(download_zip(cache_dir)), cached_zip)
  expect_identical(downloads, 1L)
  expect_identical(
    unname(tools::md5sum(cached_zip)),
    unname(tools::md5sum(archive))
  )
})
