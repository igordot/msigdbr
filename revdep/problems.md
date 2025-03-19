# tidybulk

<details>

* Version: 1.18.0
* GitHub: https://github.com/stemangiola/tidybulk
* Source code: https://github.com/cran/tidybulk
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 404

Run `revdepcheck::revdep_details(, "tidybulk")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
      Running ‘testthat.R’
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Error ('test-bulk_methods.R:2056:2'): gene over representation ──────────────
      Error in `nest(., data = -gs_cat)`: In expression named `data`:
      Caused by error:
      ! Can't select columns that don't exist.
      ✖ Column `gs_cat` doesn't exist.
      ── Error ('test-bulk_methods_SummarizedExperiment.R:743:3'): gene over representation ──
      Error in `nest(., data = -gs_cat)`: In expression named `data`:
      Caused by error:
      ! Can't select columns that don't exist.
      ✖ Column `gs_cat` doesn't exist.
      
      [ FAIL 2 | WARN 49 | SKIP 3 | PASS 225 ]
      Error: Test failures
      Execution halted
    ```

*   checking running R code from vignettes ...
    ```
      ‘introduction.Rmd’ using ‘UTF-8’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘introduction.Rmd’
      ...
    
    > knitr::include_graphics("../man/figures/new_SE_usage-01.png")
    
      When sourcing ‘introduction.R’:
    Error: Cannot find the file(s): "../man/figures/new_SE_usage-01.png"
    Execution halted
    ```

## Newly fixed

*   R CMD check timed out
    

## In both

*   checking R code for possible problems ... NOTE
    ```
    .adjust_abundance_se: no visible binding for global variable ‘x’
    .aggregate_duplicates_se: no visible binding for global variable
      ‘group_name’
    .aggregate_duplicates_se: no visible binding for global variable
      ‘group’
    .deconvolve_cellularity_se: no visible binding for global variable
      ‘X_cibersort’
    .describe_transcript_SE: no visible binding for global variable
      ‘transcript’
    .describe_transcript_SE: no visible binding for global variable
    ...
      sample b sample_idx samples sdev se_data seurat_clusters surv_test
      tagwise.dispersion temp term test tot tot_filt transcript
      transcript_upper tt_columns update.formula upper value variable vcov
      web_page where with_groups x
    Consider adding
      importFrom("base", "sample")
      importFrom("stats", "AIC", "anova", "coef", "kmeans", "logLik",
                 "predict", "update.formula", "vcov")
      importFrom("utils", "combn")
    to your NAMESPACE file.
    ```

*   checking Rd files ... NOTE
    ```
    checkRd: (-1) remove_redundancy-methods.Rd:158-175: Lost braces
       158 | select_closest_pairs = function(df) {
           |                                     ^
    checkRd: (-1) remove_redundancy-methods.Rd:161-171: Lost braces
       161 |                 while (df |> nrow() > 0) {
           |                                          ^
    checkRd: (-1) rotate_dimensions-methods.Rd:126-134: Lost braces
       126 |         rotation = function(m, d) {
           |                                   ^
    ```

*   checking Rd \usage sections ... NOTE
    ```
    Documented arguments not in \usage in Rd file 'get_reduced_dimensions_UMAP_bulk.Rd':
      ‘log_transform’
    
    Documented arguments not in \usage in Rd file 'get_reduced_dimensions_UMAP_bulk_SE.Rd':
      ‘.abundance’ ‘.feature’ ‘.element’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

