# CAESAR.Suite

<details>

* Version: 0.2.0
* GitHub: https://github.com/XiaoZhangryy/CAESAR.Suite
* Source code: https://github.com/cran/CAESAR.Suite
* Date/Publication: 2025-03-03 10:10:01 UTC
* Number of recursive dependencies: 269

Run `revdepcheck::revdep_details(, "CAESAR.Suite")` for more info

</details>

## In both

*   R CMD check timed out
    

# CatsCradle

<details>

* Version: 1.0.1
* GitHub: https://github.com/AnnaLaddach/CatsCradle
* Source code: https://github.com/cran/CatsCradle
* Date/Publication: 2025-02-13
* Number of recursive dependencies: 202

Run `revdepcheck::revdep_details(, "CatsCradle")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking for code/documentation mismatches ... WARNING
    ```
    Codoc mismatches from Rd file 'aggregateGeneExpression.Rd':
    aggregateGeneExpression
      Code: function(f, neighbourhoods, self = FALSE, verbose = TRUE,
                     returnType = "Seurat")
      Docs: function(f, neighbourhoods, verbose = TRUE, returnType =
                     "Seurat")
      Argument names in code not in docs:
        self
      Mismatches in argument names:
        Position: 3 Code: self Docs: verbose
        Position: 4 Code: verbose Docs: returnType
    
    Codoc mismatches from Rd file 'nbhdsAsEdgesToNbhdsAsList.Rd':
    nbhdsAsEdgesToNbhdsAsList
      Code: function(cells, neighbourhoods, self = FALSE)
      Docs: function(cells, neighbourhoods)
      Argument names in code not in docs:
        self
    ```

*   checking Rd \usage sections ... WARNING
    ```
    Undocumented arguments in Rd file 'getFeatureZScores.Rd'
      ‘features’
    Documented arguments not in \usage in Rd file 'getFeatureZScores.Rd':
      ‘featurs’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  8.2Mb
      sub-directories of 1Mb or more:
        data   1.2Mb
        doc    6.6Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    edgeLengthPlot: no visible binding for global variable ‘cellTypePair’
    edgeLengthPlot: no visible binding for global variable ‘cutoff’
    make.getExample : getExample: no visible binding for global variable
      ‘seuratGenes’
    make.getExample : getExample: no visible binding for global variable
      ‘seuratCells’
    make.getExample : getExample: no visible binding for global variable
      ‘xeniumCells’
    make.getExample : getExample: no visible binding for global variable
      ‘moransI’
    ...
      ‘humanLRN’
    make.getExample : getExample: no visible binding for global variable
      ‘mouseLRN’
    meanGeneClusterOnCellUMAP: no visible binding for global variable
      ‘UMAP_1’
    meanGeneClusterOnCellUMAP: no visible binding for global variable
      ‘UMAP_2’
    Undefined global functions or variables:
      UMAP_1 UMAP_2 cellTypePair cutoff humanLRN moransI
      moransILigandReceptor mouseLRN seuratCells seuratGenes xeniumCells
    ```

# ChromSCape

<details>

* Version: 1.16.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 230

Run `revdepcheck::revdep_details(, "ChromSCape")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... WARNING
    ```
    'library' or 'require' call not declared from: ‘dplyr’
    'library' or 'require' call to ‘dplyr’ in package code.
      Please use :: or requireNamespace() instead.
      See section 'Suggested packages' in the 'Writing R Extensions' manual.
    ```

*   checking for code/documentation mismatches ... WARNING
    ```
    Codoc mismatches from Rd file 'generate_analysis.Rd':
    generate_analysis
      Code: function(input_data_folder, analysis_name = "Analysis_1",
                     output_directory = "./", input_data_type = c("scBED",
                     "DenseMatrix", "SparseMatrix", "scBAM")[1],
                     feature_count_on = c("bins", "genebody", "peaks")[1],
                     feature_count_parameter = 50000, rebin_sparse_matrix =
                     FALSE, ref_genome = c("hg38", "mm10")[1], run =
                     c("filter", "CNA", "cluster", "consensus", "coverage",
                     "DA", "GSA", "report")[c(1, 3, 5, 6, 7, 8)],
    ...
      Mismatches in argument names:
        Position: 5 Code: feature_count_on Docs: rebin_sparse_matrix
        Position: 6 Code: feature_count_parameter Docs: feature_count_on
        Position: 7 Code: rebin_sparse_matrix Docs: feature_count_parameter
      Mismatches in argument default values:
        Name: 'run'
        Code: c("filter", "CNA", "cluster", "consensus", "coverage", "DA", 
              "GSA", "report")[c(1, 3, 5, 6, 7, 8)]
        Docs: c("filter", "CNA", "cluster", "consensus", "peak_call", "coverage", 
              "DA", "GSA", "report")[c(1, 3, 6, 7, 8, 9)]
    ```

*   checking Rd \usage sections ... WARNING
    ```
    Undocumented arguments in Rd file 'rebin_matrix.Rd'
      ‘rebin_function’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

*   checking for hidden files and directories ... NOTE
    ```
    Found the following hidden files and directories:
      .BBSoptions
    These were most likely included in error. See section ‘Package
    structure’ in the ‘Writing R Extensions’ manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.6Mb
      sub-directories of 1Mb or more:
        data   1.5Mb
        doc    2.9Mb
        www    2.1Mb
    ```

*   checking R code for possible problems ... NOTE
    ```
    bams_to_matrix_indexes: no visible binding for global variable
      ‘files_dir_list’
    enrich_TF_ChEA3_genes: no visible binding for global variable
      ‘CheA3_TF_nTargets’
    filter_correlated_cell_scExp: no visible binding for global variable
      ‘run_tsne’
    generate_analysis: no visible global function definition for ‘head’
    generate_analysis: no visible binding for global variable ‘k’
    generate_analysis: no visible binding for global variable
      ‘clusterConsensus’
    ...
    subset_bam_call_peaks: no visible binding for global variable
      ‘merged_bam’
    Undefined global functions or variables:
      CheA3_TF_nTargets Component Fri_cyto Gain_or_Loss Gene TF V1 V2
      absolute_value cluster clusterConsensus cytoBand files_dir_list genes
      group head k merged_bam molecule ncells new_row orientation
      origin_value percent_active run_tsne sample_id total_counts
    Consider adding
      importFrom("utils", "head")
    to your NAMESPACE file.
    ```

*   checking Rd files ... NOTE
    ```
    prepare_Rd: raw_counts_to_sparse_matrix.Rd:6-8: Dropping empty section \source
    ```

# epiregulon.extra

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```

  There is a binary version available but the source version is later:
      binary source needs_compilation
fgsea 1.32.0 1.32.2              TRUE

  Binaries will be installed


installing the source packages ‘BSgenome.Hsapiens.UCSC.hg19’, ‘BSgenome.Hsapiens.UCSC.hg38’, ‘BSgenome.Mmusculus.UCSC.mm10’, ‘dorothea’, ‘scMultiome’



```
### CRAN

```

  There is a binary version available but the source version is later:
      binary source needs_compilation
fgsea 1.32.0 1.32.2              TRUE

  Binaries will be installed


installing the source packages ‘BSgenome.Hsapiens.UCSC.hg19’, ‘BSgenome.Hsapiens.UCSC.hg38’, ‘BSgenome.Mmusculus.UCSC.mm10’, ‘dorothea’, ‘scMultiome’



```
# fgsea

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source package ‘reactome.db’



```
### CRAN

```



installing the source package ‘reactome.db’



```
# hypeR

<details>

* Version: 2.4.0
* GitHub: https://github.com/montilab/hypeR
* Source code: https://github.com/cran/hypeR
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 165

Run `revdepcheck::revdep_details(, "hypeR")` for more info

</details>

## In both

*   checking whether package ‘hypeR’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/hypeR/new/hypeR.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘hypeR’ ...
** package ‘hypeR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error: object ‘msigdbr_show_species’ is not exported by 'namespace:msigdbr'
Execution halted
ERROR: lazy loading failed for package ‘hypeR’
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/hypeR/new/hypeR.Rcheck/hypeR’


```
### CRAN

```
* installing *source* package ‘hypeR’ ...
** package ‘hypeR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error: object ‘msigdbr_show_species’ is not exported by 'namespace:msigdbr'
Execution halted
ERROR: lazy loading failed for package ‘hypeR’
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/hypeR/old/hypeR.Rcheck/hypeR’


```
# pathfindR

<details>

* Version: 2.4.2
* GitHub: https://github.com/egeulgen/pathfindR
* Source code: https://github.com/cran/pathfindR
* Date/Publication: 2025-02-17 09:30:02 UTC
* Number of recursive dependencies: 145

Run `revdepcheck::revdep_details(, "pathfindR")` for more info

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
# rGREAT

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source package ‘reactome.db’



```
### CRAN

```



installing the source package ‘reactome.db’



```
# scFeatures

<details>

* Version: 1.6.0
* GitHub: https://github.com/SydneyBioX/scFeatures
* Source code: https://github.com/cran/scFeatures
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 317

Run `revdepcheck::revdep_details(, "scFeatures")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespaces in Imports field not imported from:
      'DT' 'Seurat'
      All declared Imports should be used.
    ```

*   checking R code for possible problems ... NOTE
    ```
    helper_CCI: no visible global function definition for 'data'
    helper_CCI: no visible binding for global variable 'LRdb'
    helper_CCI: no visible global function definition for 'capture.output'
    helper_pathway_gsva: no visible global function definition for
      'capture.output'
    run_pathway_gsva: no visible global function definition for
      'capture.output'
    Undefined global functions or variables:
      LRdb capture.output data
    Consider adding
      importFrom("utils", "capture.output", "data")
    to your NAMESPACE file.
    ```

# singleCellTK

<details>

* Version: 2.16.1
* GitHub: https://github.com/compbiomed/singleCellTK
* Source code: https://github.com/cran/singleCellTK
* Date/Publication: 2025-02-17
* Number of recursive dependencies: 405

Run `revdepcheck::revdep_details(, "singleCellTK")` for more info

</details>

## In both

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
      <https://github.com/compbiomed/singleCellTK/issues>.
    Warning: The `subcategory` argument of `msigdbr()` is deprecated as of msigdbr 10.0.0.
    ℹ Please use the `subcollection` argument instead.
    ℹ The deprecated feature was likely used in the singleCellTK package.
      Please report the issue at
      <https://github.com/compbiomed/singleCellTK/issues>.
    Error in (function (cond)  : 
      error in evaluating the argument 'x' in selecting a method for function 'as.data.frame': subcategory is not a character vector
    Calls: importGeneSetsFromMSigDB -> as.data.frame -> <Anonymous> -> <Anonymous>
    Execution halted
    ```

*   R CMD check timed out
    

*   checking Rd cross-references ... WARNING
    ```
    Missing link or links in Rd file 'importGeneSetsFromMSigDB.Rd':
      ‘[msigdbr]{msigdbr_show_species}’
    
    See section 'Cross-references' in the 'Writing R Extensions' manual.
    ```

*   checking installed package size ... NOTE
    ```
      installed size is  7.5Mb
      sub-directories of 1Mb or more:
        R         1.0Mb
        extdata   1.5Mb
        shiny     2.9Mb
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

  There is a binary version available but the source version is later:
      binary source needs_compilation
fgsea 1.32.0 1.32.2              TRUE

  Binaries will be installed


installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
### CRAN

```

  There is a binary version available but the source version is later:
      binary source needs_compilation
fgsea 1.32.0 1.32.2              TRUE

  Binaries will be installed


installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
