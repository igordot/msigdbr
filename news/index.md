# Changelog

## msigdbr 26.1.0

CRAN release: 2026-03-12

- Updated to MSigDB v2026.1.
- Split source data per collection for faster loading.

## msigdbr 25.1.1

CRAN release: 2025-07-21

- Updated tests and examples to comply with CRAN policies.

## msigdbr 25.1.0

CRAN release: 2025-07-03

- Included the MSigDB v2025.1 data.

## msigdbr 24.1.0

CRAN release: 2025-05-13

- Updated the package to download the data, removing the non-CRAN data
  package dependency.
- Included the MSigDB v2024.1 data.
- Updated the package versioning scheme so it is tied to the MSigDB
  release.

## msigdbr 10.0.2

CRAN release: 2025-04-14

- Updated tests.

## msigdbr 10.0.1

CRAN release: 2025-03-19

- Updated documentation.

## msigdbr 10.0.0

CRAN release: 2025-03-12

- Removed the MSigDB data (now a separate package).
- Updated the package versioning scheme so it is not tied to the MSigDB
  release.
- Added support for mouse versions of MSigDB
  ([`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
  gains a `db_species` argument).
- Updated the annotation fields in the returned gene sets.
- Updated the
  [`msigdbr()`](https://igordot.github.io/msigdbr/reference/msigdbr.md)
  arguments `gs_cat` and `gs_subcat` to `gs_collection` and
  `gs_subcollection`.

## msigdbr 2023.1.1

- Based on MSigDB v2023.1.Hs release.
- Not available on CRAN.

## msigdbr 2022.1.1

- Based on MSigDB v2022.1.Hs release.
- Not available on CRAN.

## msigdbr 7.5.1

CRAN release: 2022-03-30

- Based on MSigDB v7.5.1 release.

## msigdbr 7.4.1

CRAN release: 2021-05-05

- Based on MSigDB v7.4 release.
- Added Ensembl gene IDs to the returned gene sets.

## msigdbr 7.2.1

CRAN release: 2020-10-02

- Based on MSigDB v7.2 release.
- Added more annotation fields to the returned gene sets.
- Added
  [`msigdbr_species()`](https://igordot.github.io/msigdbr/reference/msigdbr_species.md)
  as an alternative to `msigdbr_show_species()`.
- Added
  [`msigdbr_collections()`](https://igordot.github.io/msigdbr/reference/msigdbr_collections.md).

## msigdbr 7.1.1

CRAN release: 2020-05-14

- Based on MSigDB v7.1 release.
- Increased ortholog prediction stringency.

## msigdbr 7.0.1

CRAN release: 2019-09-04

- Based on MSigDB v7.0 release.
- Fixed output when selecting multiple collections.

## msigdbr 6.2.1

CRAN release: 2018-10-09

- Based on MSigDB v6.2 release.

## msigdbr 6.1.1

CRAN release: 2018-04-12

- Based on MSigDB v6.1 release.
- Initial CRAN submission.
