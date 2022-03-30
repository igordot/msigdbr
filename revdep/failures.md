# ChromSCape

<details>

* Version: 1.4.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2021-10-26
* Number of recursive dependencies: 272

Run `revdep_details(, "ChromSCape")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .BBSoptions
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.4Mb
      sub-directories of 1Mb or more:
        data   1.3Mb
        doc    2.9Mb
        www    2.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    CompareWilcox: no visible binding for global variable ‘annot.’
    bams_to_matrix_indexes: no visible binding for global variable
      ‘files_dir_list’
    filter_correlated_cell_scExp: no visible binding for global variable
      ‘run_tsne’
    generate_analysis: no visible binding for global variable ‘k’
    generate_analysis: no visible binding for global variable
      ‘clusterConsensus’
    get_most_variable_cyto: no visible binding for global variable
      ‘cytoBand’
    ...
    plot_reduced_dim_scExp: no visible binding for global variable ‘V1’
    plot_reduced_dim_scExp: no visible binding for global variable ‘V2’
    plot_reduced_dim_scExp: no visible binding for global variable
      ‘cluster’
    subset_bam_call_peaks: no visible binding for global variable
      ‘merged_bam’
    Undefined global functions or variables:
      Fri_cyto Gain_or_Loss V1 V2 absolute_value annot. cluster
      clusterConsensus cytoBand files_dir_list genes k merged_bam ncells
      run_tsne sample_id total_counts
    ```

*   checking Rd files ... NOTE
    ```
    prepare_Rd: raw_counts_to_sparse_matrix.Rd:6-8: Dropping empty section \source
    ```

*   checking files in ‘vignettes’ ... NOTE
    ```
    Files named as vignettes but with no recognized vignette engine:
       ‘vignettes/PairedTag_Zhu_H3K4me1.Rmd’
       ‘vignettes/scChIC_Ku_H3K4me3.Rmd’
    (Is a VignetteBuilder field missing?)
    ```

# OSCA.advanced

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE

  Binaries will be installed


installing the source packages ‘celldex’, ‘DropletTestFiles’, ‘EnsDb.Hsapiens.v86’, ‘HCAData’, ‘MouseGastrulationData’, ‘OSCA.basic’, ‘OSCA.multisample’, ‘OSCA.workflows’, ‘scRNAseq’, ‘TENxBrainData’, ‘TENxPBMCData’



```
### CRAN

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE

  Binaries will be installed


installing the source packages ‘celldex’, ‘DropletTestFiles’, ‘EnsDb.Hsapiens.v86’, ‘HCAData’, ‘MouseGastrulationData’, ‘OSCA.basic’, ‘OSCA.multisample’, ‘OSCA.workflows’, ‘scRNAseq’, ‘TENxBrainData’, ‘TENxPBMCData’



```
# pathfindR

<details>

* Version: 1.6.3
* GitHub: https://github.com/egeulgen/pathfindR
* Source code: https://github.com/cran/pathfindR
* Date/Publication: 2021-11-15 09:20:04 UTC
* Number of recursive dependencies: 141

Run `revdep_details(, "pathfindR")` for more info

</details>

## In both

*   checking whether package ‘pathfindR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/pathfindR/new/pathfindR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘pathfindR’ ...
** package ‘pathfindR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
** building package indices
...
Warning in system2(java, "-version", stderr = TRUE, stdout = TRUE) :
  running command ''/usr/bin/java' -version 2>&1' had status 1
Error: package or namespace load failed for ‘pathfindR’:
 .onAttach failed in attachNamespace() for 'pathfindR', details:
  call: check_java_version()
  error: Java version detected but couldn't parse version from The operation couldn’t be completed. Unable to locate a Java Runtime. - Please visit http://www.java.com for information on installing Java. - 
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/pathfindR/new/pathfindR.Rcheck/pathfindR’


```
### CRAN

```
* installing *source* package ‘pathfindR’ ...
** package ‘pathfindR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
** building package indices
...
Warning in system2(java, "-version", stderr = TRUE, stdout = TRUE) :
  running command ''/usr/bin/java' -version 2>&1' had status 1
Error: package or namespace load failed for ‘pathfindR’:
 .onAttach failed in attachNamespace() for 'pathfindR', details:
  call: check_java_version()
  error: Java version detected but couldn't parse version from The operation couldn’t be completed. Unable to locate a Java Runtime. - Please visit http://www.java.com for information on installing Java. - 
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/pathfindR/old/pathfindR.Rcheck/pathfindR’


```
# simplifyEnrichment

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE
testthat   3.1.2  3.1.3              TRUE

  Binaries will be installed


installing the source packages ‘hu6800.db’, ‘reactome.db’



```
### CRAN

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE
testthat   3.1.2  3.1.3              TRUE

  Binaries will be installed


installing the source packages ‘hu6800.db’, ‘reactome.db’



```
# singleCellTK

<details>

* Version: 2.4.0
* GitHub: https://github.com/compbiomed/singleCellTK
* Source code: https://github.com/cran/singleCellTK
* Date/Publication: 2021-10-27
* Number of recursive dependencies: 379

Run `revdep_details(, "singleCellTK")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking installed package size ... NOTE
    ```
      installed size is  7.0Mb
      sub-directories of 1Mb or more:
        extdata   1.5Mb
        shiny     2.8Mb
    ```

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      'AnnotationDbi' 'RColorBrewer'
      All declared Imports should be used.
    ```

# sparrow

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE
testthat   3.1.2  3.1.3              TRUE

  Binaries will be installed


installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
### CRAN

```

  There are binary versions available but the source versions are later:
          binary source needs_compilation
cluster    2.1.2  2.1.3              TRUE
mgcv      1.8-39 1.8-40              TRUE
S4Vectors 0.32.3 0.32.4              TRUE
testthat   3.1.2  3.1.3              TRUE

  Binaries will be installed


installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
