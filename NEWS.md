# msigdbr 24.1.0

* Updated the package to download the data, removing the non-CRAN msigdbdf data package dependency.
* Included the MSigDB v2024.1 data.
* Updated the package versioning scheme so it is tied to the MSigDB release.

# msigdbr 10.0.2

* Updated tests.

# msigdbr 10.0.1

* Updated documentation.

# msigdbr 10.0.0

* Removed the MSigDB data (now a separate package msigdbdf).
* Updated the package versioning scheme so it is not tied to the MSigDB release.
* Added support for mouse versions of MSigDB (`msigdbr()` gains a `db_species` argument).
* Updated the annotation fields in the returned gene sets.
* Updated the `msigdbr()` arguments `gs_cat` and `gs_subcat` to `gs_collection` and `gs_subcollection`.

# msigdbr 2023.1.1

* Based on MSigDB v2023.1.Hs release.
* Not available on CRAN.

# msigdbr 2022.1.1

* Based on MSigDB v2022.1.Hs release.
* Not available on CRAN.

# msigdbr 7.5.1

* Based on MSigDB v7.5.1 release.

# msigdbr 7.4.1

* Based on MSigDB v7.4 release.
* Added Ensembl gene IDs to the returned gene sets.

# msigdbr 7.2.1

* Based on MSigDB v7.2 release.
* Added more annotation fields to the returned gene sets.
* Added `msigdbr_species()` as an alternative to `msigdbr_show_species()`.
* Added `msigdbr_collections()`.

# msigdbr 7.1.1

* Based on MSigDB v7.1 release.
* Increased ortholog prediction stringency.

# msigdbr 7.0.1

* Based on MSigDB v7.0 release.
* Fixed output when selecting multiple collections.

# msigdbr 6.2.1

* Based on MSigDB v6.2 release.

# msigdbr 6.1.1

* Based on MSigDB v6.1 release.
* Initial CRAN submission.
