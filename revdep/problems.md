# singleCellTK

<details>

* Version: 2.0.0
* GitHub: https://github.com/compbiomed/singleCellTK
* Source code: https://github.com/cran/singleCellTK
* Date/Publication: 2020-10-27
* Number of recursive dependencies: 339

Run `revdep_details(, "singleCellTK")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘singleCellTK-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: importGeneSetsFromMSigDB
    > ### Title: Imports gene sets from MSigDB
    > ### Aliases: importGeneSetsFromMSigDB
    > 
    > ### ** Examples
    > 
    > data(scExample)
    ...
    > sce <- importGeneSetsFromMSigDB(inSCE = sce,
    +                                 categoryIDs = "H",
    +                                 species = "Homo sapiens",
    +                                 mapping = "gene_symbol",
    +                                 by = "feature_name")
    Tue May  4 13:37:02 2021 .. Importing 'H' gene sets (n = 50)
    Error in validObject(.Object) : 
      invalid class “GeneSet” object: gene symbols must be unique
    Calls: importGeneSetsFromMSigDB ... <Anonymous> -> initialize -> initialize -> validObject
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      Error: invalid class "GeneSet" object: gene symbols must be unique
      Backtrace:
          █
       1. └─singleCellTK::importGeneSetsFromMSigDB(...) test-import.R:107:2
       2.   ├─GSEABase::GeneSet(...)
       3.   └─GSEABase::GeneSet(...)
       4.     ├─base::do.call(new, c("GeneSet", list(... = ..., setIdentifier = setIdentifier)))
       5.     └─(function (Class, ...) ...
       6.       ├─methods::initialize(value, ...)
       7.       └─methods::initialize(value, ...)
       8.         └─methods::validObject(.Object)
      
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 36 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking whether package ‘singleCellTK’ can be installed ... WARNING
    ```
    Found the following significant warnings:
      Warning: package ‘BiocGenerics’ was built under R version 4.0.5
      Warning: package ‘GenomeInfoDb’ was built under R version 4.0.5
      Warning: package ‘DelayedArray’ was built under R version 4.0.4
    See ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/singleCellTK/new/singleCellTK.Rcheck/00install.out’ for details.
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      'BiocGenerics' 'ggplotify' 'kableExtra' 'shinyBS' 'shinyFiles'
      'shinyWidgets' 'shinyjqui' 'shinythemes'
      All declared Imports should be used.
    ```

