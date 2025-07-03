# Platypus

<details>

* Version: 3.6.0
* GitHub: NA
* Source code: https://github.com/cran/Platypus
* Date/Publication: 2024-10-18 11:10:17 UTC
* Number of recursive dependencies: 255

Run `revdepcheck::revdep_details(, "Platypus")` for more info

</details>

## Newly broken

*   R CMD check timed out
    

## In both

*   checking DESCRIPTION meta-information ... NOTE
    ```
      Missing dependency on R >= 4.1.0 because package code uses the pipe
      |> or function shorthand \(...) syntax added in R 4.1.0.
      File(s) using such syntax:
        ‘VDJ_build.R’
    ```

