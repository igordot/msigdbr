# pairedGSEA

<details>

* Version: 1.7.0
* GitHub: https://github.com/shdam/pairedGSEA
* Source code: https://github.com/cran/pairedGSEA
* Date/Publication: 2025-03-06
* Number of recursive dependencies: 167

Run `revdepcheck::revdep_details(, "pairedGSEA")` for more info

</details>

## Newly broken

*   checking running R code from vignettes ...
    ```
      ‘User-Guide.Rmd’ using ‘UTF-8’... failed
     ERROR
    Errors in running code in vignettes:
    when running code in ‘User-Guide.Rmd’
      ...
    +     gene_sets = gene_sets, experiment_title = NULL)
    Running over-representation analyses
    Joining result
    
    > plot_ora(ora, plotly = FALSE, pattern = "Telomer", 
    +     cutoff = 0.05, lines = TRUE)
    
      When sourcing ‘User-Guide.R’:
    Error: No over-represented gene sets found.
    Execution halted
    ```

## Newly fixed

*   R CMD check timed out
    

