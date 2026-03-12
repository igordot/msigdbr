# CAESAR.Suite

<details>

* Version: 0.3.0
* GitHub: https://github.com/XiaoZhangryy/CAESAR.Suite
* Source code: https://github.com/cran/CAESAR.Suite
* Date/Publication: 2025-12-23 03:30:10 UTC
* Number of recursive dependencies: 221

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
** this is package ‘CAESAR.Suite’ version ‘0.3.0’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 17.0.0 (clang-1700.6.4.2)’
using SDK: ‘MacOSX26.2.sdk’
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
** this is package ‘CAESAR.Suite’ version ‘0.3.0’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 17.0.0 (clang-1700.6.4.2)’
using SDK: ‘MacOSX26.2.sdk’
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
# OlinkAnalyze

<details>

* Version: 4.5.0
* GitHub: https://github.com/Olink-Proteomics/OlinkRPackage
* Source code: https://github.com/cran/OlinkAnalyze
* Date/Publication: 2026-01-28 17:50:02 UTC
* Number of recursive dependencies: 164

Run `revdepcheck::revdep_details(, "OlinkAnalyze")` for more info

</details>

## In both

*   R CMD check timed out
    

# pathfindR

<details>

* Version: 
* GitHub: https://github.com/igordot/msigdbr
* Source code: NA
* Number of recursive dependencies: 0

</details>

## Error before installation

### Devel

```



installing the source package ‘org.Hs.eg.db’



```
### CRAN

```



installing the source package ‘org.Hs.eg.db’



```
