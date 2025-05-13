# CAESAR.Suite

<details>

* Version: 0.2.2
* GitHub: https://github.com/XiaoZhangryy/CAESAR.Suite
* Source code: https://github.com/cran/CAESAR.Suite
* Date/Publication: 2025-04-01 09:00:07 UTC
* Number of recursive dependencies: 253

Run `revdepcheck::revdep_details(, "CAESAR.Suite")` for more info

</details>

## In both

*   checking whether package ‘CAESAR.Suite’ can be installed ... ERROR
    ```
    Installation failed.
    See ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/new/CAESAR.Suite.Rcheck/00install.out’ for details.
    ```

## Installation

### Devel

```
* installing *source* package ‘CAESAR.Suite’ ...
** this is package ‘CAESAR.Suite’ version ‘0.2.2’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 17.0.0 (clang-1700.0.13.3)’
using SDK: ‘MacOSX15.4.sdk’
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c RcppExports.cpp -o RcppExports.o
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c gene_embed.cpp -o gene_embed.o
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c imfactor.cpp -o imfactor.o
clang++ -arch x86_64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -L/opt/R/x86_64/lib -o CAESAR.Suite.so RcppExports.o gene_embed.o imfactor.o -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/x86_64-apple-darwin20.0/14.2.0 -L/opt/gfortran/lib -lemutls_w -lheapt_w -lgfortran -lquadmath -F/Library/Frameworks/R.framework/Versions/4.5-x86_64 -framework R
ld: warning: search path '/opt/gfortran/lib/gcc/x86_64-apple-darwin20.0/14.2.0' not found
ld: library 'emutls_w' not found
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [CAESAR.Suite.so] Error 1
ERROR: compilation failed for package ‘CAESAR.Suite’
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/new/CAESAR.Suite.Rcheck/CAESAR.Suite’


```
### CRAN

```
* installing *source* package ‘CAESAR.Suite’ ...
** this is package ‘CAESAR.Suite’ version ‘0.2.2’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 17.0.0 (clang-1700.0.13.3)’
using SDK: ‘MacOSX15.4.sdk’
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c RcppExports.cpp -o RcppExports.o
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c gene_embed.cpp -o gene_embed.o
clang++ -arch x86_64 -std=gnu++17 -I"/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/include" -DNDEBUG  -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/x86_64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c imfactor.cpp -o imfactor.o
clang++ -arch x86_64 -std=gnu++17 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -L/opt/R/x86_64/lib -o CAESAR.Suite.so RcppExports.o gene_embed.o imfactor.o -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Versions/4.5-x86_64/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/x86_64-apple-darwin20.0/14.2.0 -L/opt/gfortran/lib -lemutls_w -lheapt_w -lgfortran -lquadmath -F/Library/Frameworks/R.framework/Versions/4.5-x86_64 -framework R
ld: warning: search path '/opt/gfortran/lib/gcc/x86_64-apple-darwin20.0/14.2.0' not found
ld: library 'emutls_w' not found
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [CAESAR.Suite.so] Error 1
ERROR: compilation failed for package ‘CAESAR.Suite’
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/old/CAESAR.Suite.Rcheck/CAESAR.Suite’


```
# CatsCradle

<details>

* Version: 1.2.0
* GitHub: https://github.com/AnnaLaddach/CatsCradle
* Source code: https://github.com/cran/CatsCradle
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 201

Run `revdepcheck::revdep_details(, "CatsCradle")` for more info

</details>

## In both

*   R CMD check timed out
    

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

* Version: 1.17.0
* GitHub: https://github.com/vallotlab/ChromSCape
* Source code: https://github.com/cran/ChromSCape
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 229

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

# EnrichmentBrowser

<details>

* Version: 2.38.0
* GitHub: https://github.com/lgeistlinger/EnrichmentBrowser
* Source code: https://github.com/cran/EnrichmentBrowser
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 199

Run `revdepcheck::revdep_details(, "EnrichmentBrowser")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Unexported object imported by a ':::' call: 'pathview:::parseKGML2Graph2'
      See the note in ?`:::` about the use of this operator.
    ```

*   checking R code for possible problems ... NOTE
    ```
    .getGOFromBiomart: no visible binding for global variable
      ‘go_linkage_type’
    Undefined global functions or variables:
      go_linkage_type
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



installing the source packages ‘org.Mm.eg.db’, ‘reactome.db’



```
### CRAN

```



installing the source packages ‘org.Mm.eg.db’, ‘reactome.db’



```
# gCrisprTools

<details>

* Version: 2.14.0
* GitHub: NA
* Source code: https://github.com/cran/gCrisprTools
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 149

Run `revdepcheck::revdep_details(, "gCrisprTools")` for more info

</details>

## In both

*   R CMD check timed out
    

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘RobustRankAggreg’
      All declared Imports should be used.
    ```

*   checking Rd \usage sections ... NOTE
    ```
    Documented arguments not in \usage in Rd file 'ct.targetSetEnrichment.Rd':
      ‘pvalue.cutoff’ ‘organism’ ‘db.cut’ ‘species’
    
    Functions with \usage entries need to have the appropriate \alias
    entries, and all their arguments documented.
    The \usage entries must correspond to syntactically valid R code.
    See chapter ‘Writing R documentation files’ in the ‘Writing R
    Extensions’ manual.
    ```

# GenomicSuperSignature

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source packages ‘bcellViper’, ‘GO.db’, ‘org.Hs.eg.db’



```
### CRAN

```



installing the source packages ‘bcellViper’, ‘GO.db’, ‘org.Hs.eg.db’



```
# hypeR

<details>

* Version: 2.5.0
* GitHub: https://github.com/montilab/hypeR
* Source code: https://github.com/cran/hypeR
* Date/Publication: 2024-10-29
* Number of recursive dependencies: 164

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
** this is package ‘hypeR’ version ‘2.5.0’
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
** this is package ‘hypeR’ version ‘2.5.0’
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
Error: object ‘msigdbr_show_species’ is not exported by 'namespace:msigdbr'
Execution halted
ERROR: lazy loading failed for package ‘hypeR’
* removing ‘/Users/id460/repos/msigdbr/revdep/checks.noindex/hypeR/old/hypeR.Rcheck/hypeR’


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



installing the source packages ‘celldex’, ‘DropletTestFiles’, ‘EnsDb.Hsapiens.v86’, ‘GO.db’, ‘HCAData’, ‘MouseGastrulationData’, ‘org.Hs.eg.db’, ‘org.Mm.eg.db’, ‘OSCA.basic’, ‘OSCA.multisample’, ‘OSCA.workflows’, ‘scRNAseq’, ‘TENxBrainData’, ‘TENxPBMCData’



```
### CRAN

```



installing the source packages ‘celldex’, ‘DropletTestFiles’, ‘EnsDb.Hsapiens.v86’, ‘GO.db’, ‘HCAData’, ‘MouseGastrulationData’, ‘org.Hs.eg.db’, ‘org.Mm.eg.db’, ‘OSCA.basic’, ‘OSCA.multisample’, ‘OSCA.workflows’, ‘scRNAseq’, ‘TENxBrainData’, ‘TENxPBMCData’



```
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
    

# pathfindR

<details>

* Version: 2.4.2
* GitHub: https://github.com/egeulgen/pathfindR
* Source code: https://github.com/cran/pathfindR
* Date/Publication: 2025-02-17 09:30:02 UTC
* Number of recursive dependencies: 143

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
** this is package ‘pathfindR’ version ‘2.4.2’
** package ‘pathfindR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
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
** this is package ‘pathfindR’ version ‘2.4.2’
** package ‘pathfindR’ successfully unpacked and MD5 sums checked
** using staged installation
** R
** inst
** byte-compile and prepare package for lazy loading
** help
*** installing help indices
*** copying figures
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



installing the source packages ‘org.Mm.eg.db’, ‘reactome.db’, ‘TxDb.Hsapiens.UCSC.hg19.knownGene’, ‘TxDb.Hsapiens.UCSC.hg38.knownGene’



```
### CRAN

```



installing the source packages ‘org.Mm.eg.db’, ‘reactome.db’, ‘TxDb.Hsapiens.UCSC.hg19.knownGene’, ‘TxDb.Hsapiens.UCSC.hg38.knownGene’



```
# scFeatures

<details>

* Version: 1.8.0
* GitHub: https://github.com/SydneyBioX/scFeatures
* Source code: https://github.com/cran/scFeatures
* Date/Publication: 2025-04-15
* Number of recursive dependencies: 318

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

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source packages ‘celldex’, ‘GSVAdata’, ‘hgu95a.db’, ‘org.Mm.eg.db’, ‘scRNAseq’, ‘TENxPBMCData’



```
### CRAN

```



installing the source packages ‘celldex’, ‘GSVAdata’, ‘hgu95a.db’, ‘org.Mm.eg.db’, ‘scRNAseq’, ‘TENxPBMCData’



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



installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
### CRAN

```



installing the source packages ‘geneLenDataBase’, ‘PANTHER.db’, ‘reactome.db’



```
# tidybulk

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source packages ‘EGSEAdata’, ‘hgu133a.db’, ‘hgu133plus2.db’, ‘KEGGdzPathwaysGEO’, ‘org.Mm.eg.db’, ‘org.Rn.eg.db’, ‘pasilla’



```
### CRAN

```



installing the source packages ‘EGSEAdata’, ‘hgu133a.db’, ‘hgu133plus2.db’, ‘KEGGdzPathwaysGEO’, ‘org.Mm.eg.db’, ‘org.Rn.eg.db’, ‘pasilla’



```
