# hypeR

<details>

* Version: 1.4.0
* GitHub: https://github.com/montilab/hypeR
* Source code: https://github.com/cran/hypeR
* Date/Publication: 2020-04-27
* Number of recursive dependencies: 111

Run `revdep_details(, "hypeR")` for more info

</details>

## Newly broken

*   checking examples ... WARNING
    ```
    Found the following significant warnings:
    
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
      Warning: 'msigdbr::msigdbr_show_species' is deprecated.
    Deprecated functions may be defunct as soon as of the next release of
    R.
    See ?Deprecated.
    ```

## In both

*   checking R code for possible problems ... NOTE
    ```
    ...
      ‘is’
    hyp_to_table: no visible global function definition for ‘is’
    hyp_to_table: no visible global function definition for
      ‘packageVersion’
    hyp_to_table: no visible global function definition for ‘write.table’
    hypeR: no visible global function definition for ‘is’
    msigdb_available: no visible binding for global variable ‘gs_cat’
    msigdb_available: no visible binding for global variable ‘gs_subcat’
    msigdb_download: no visible binding for global variable ‘gs_name’
    msigdb_download: no visible binding for global variable ‘gene_symbol’
    msigdb_download: no visible binding for global variable ‘.’
    msigdb_version: no visible global function definition for
      ‘packageVersion’
    Undefined global functions or variables:
      . fdr from gene_symbol gs_cat gs_name gs_subcat is label
      packageVersion pval significance size to write.table x y
    Consider adding
      importFrom("methods", "is")
      importFrom("utils", "packageVersion", "write.table")
    to your NAMESPACE file (and ensure that your DESCRIPTION Imports field
    contains 'methods').
    ```

*   checking for unstated dependencies in vignettes ... NOTE
    ```
    'library' or 'require' call not declared from: ‘tidyverse’
    ```

