# pairedGSEA

<details>

* Version: 1.8.0
* GitHub: https://github.com/shdam/pairedGSEA
* Source code: https://github.com/cran/pairedGSEA
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 168

Run `revdepcheck::revdep_details(, "pairedGSEA")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

# ReducedExperiment

<details>

* Version: 0.99.6
* GitHub: https://github.com/jackgisby/ReducedExperiment
* Source code: https://github.com/cran/ReducedExperiment
* Date/Publication: 2025-01-15
* Number of recursive dependencies: 219

Run `revdepcheck::revdep_details(, "ReducedExperiment")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

## Newly fixed

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
        |===================================                                   |  50%
        |                                                                            
        |======================================================================| 100%
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 584 ]
      
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure ('test_features.R:85:5'): Get MSGIDB data ───────────────────────────
      nrow(t2g) > 1e+05 is not TRUE
      
      `actual`:   FALSE
      `expected`: TRUE 
      
      [ FAIL 1 | WARN 1 | SKIP 0 | PASS 584 ]
      Error: Test failures
      Execution halted
    ```

*   checking running R code from vignettes ...
    ```
      ‘ReducedExperiment.Rmd’ using ‘UTF-8’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘ReducedExperiment.Rmd’
      ...
    > ggplot(module_1_enrich[1:15, ], aes(-log10(p.adjust), 
    +     reorder(substr(ID, 1, 45), -log10(p.adjust)))) + geom_point(pch = 21, 
    +     size = 3)  .... [TRUNCATED] 
    
      When sourcing ‘ReducedExperiment.R’:
    Error: Problem while computing aesthetics.
    ℹ Error occurred in the 1st layer.
    Caused by error in `log10()`:
    ! non-numeric argument to mathematical function
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Unexported objects imported by ':::' calls:
      ‘BiocGenerics:::replaceSlots’
      ‘SummarizedExperiment:::.SummarizedExperiment.charbound’
      See the note in ?`:::` about the use of this operator.
    ```

