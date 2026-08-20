# CAESAR.Suite (0.3.0)

* GitHub: <https://github.com/XiaoZhangryy/CAESAR.Suite>
* Email: <mailto:zhangxiao1994@cuhk.edu.cn>
* GitHub mirror: <https://github.com/cran/CAESAR.Suite>

Run `revdepcheck::revdep_details(, "CAESAR.Suite")` for more info

## In both

*   checking whether package ‘CAESAR.Suite’ can be installed ... ERROR
     ```
     Installation failed.
     See ‘/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/new/CAESAR.Suite.Rcheck/00install.out’ for details.
     ```

## Installation

### Devel

```
* installing *source* package ‘CAESAR.Suite’ ...
** this is package ‘CAESAR.Suite’ version ‘0.3.0’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 21.0.0 (clang-2100.1.1.101)’
using SDK: ‘MacOSX26.5.sdk’
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c gene_embed.cpp -o gene_embed.o
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c imfactor.cpp -o imfactor.o
clang++ -arch arm64 -std=gnu++20 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -L/opt/R/arm64/lib -o CAESAR.Suite.so RcppExports.o gene_embed.o imfactor.o -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/14.2.0 -L/opt/gfortran/lib -lemutls_w -lheapt_w -lgfortran -lquadmath -F/Library/Frameworks/R.framework/Versions/4.6 -framework R
ld: warning: search path '/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/14.2.0' not found
ld: warning: search path '/opt/gfortran/lib' not found
ld: library 'emutls_w' not found
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [CAESAR.Suite.so] Error 1
ERROR: compilation failed for package ‘CAESAR.Suite’
* removing ‘/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/new/CAESAR.Suite.Rcheck/CAESAR.Suite’


```
### CRAN

```
* installing *source* package ‘CAESAR.Suite’ ...
** this is package ‘CAESAR.Suite’ version ‘0.3.0’
** package ‘CAESAR.Suite’ successfully unpacked and MD5 sums checked
** using staged installation
** libs
using C++ compiler: ‘Apple clang version 21.0.0 (clang-2100.1.1.101)’
using SDK: ‘MacOSX26.5.sdk’
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c RcppExports.cpp -o RcppExports.o
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c gene_embed.cpp -o gene_embed.o
clang++ -arch arm64 -std=gnu++20 -I"/Library/Frameworks/R.framework/Versions/4.6/Resources/include" -DNDEBUG  -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/Rcpp/include' -I'/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/library.noindex/CAESAR.Suite/RcppArmadillo/include' -I/opt/R/arm64/include    -fPIC  -falign-functions=64 -Wall -g -O2   -c imfactor.cpp -o imfactor.o
clang++ -arch arm64 -std=gnu++20 -dynamiclib -Wl,-headerpad_max_install_names -undefined dynamic_lookup -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -L/opt/R/arm64/lib -o CAESAR.Suite.so RcppExports.o gene_embed.o imfactor.o -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -lRlapack -L/Library/Frameworks/R.framework/Versions/4.6/Resources/lib -lRblas -L/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/14.2.0 -L/opt/gfortran/lib -lemutls_w -lheapt_w -lgfortran -lquadmath -F/Library/Frameworks/R.framework/Versions/4.6 -framework R
ld: warning: search path '/opt/gfortran/lib/gcc/aarch64-apple-darwin20.0/14.2.0' not found
ld: warning: search path '/opt/gfortran/lib' not found
ld: library 'emutls_w' not found
clang++: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [CAESAR.Suite.so] Error 1
ERROR: compilation failed for package ‘CAESAR.Suite’
* removing ‘/Users/id460/Library/CloudStorage/Dropbox-NYULangoneHealth/Igor Dolgalev/repos/msigdbr/revdep/checks.noindex/CAESAR.Suite/old/CAESAR.Suite.Rcheck/CAESAR.Suite’


```
# pathfindR (3.0.2)

* GitHub: <https://github.com/egeulgen/pathfindR>
* Email: <mailto:egeulgen@gmail.com>
* GitHub mirror: <https://github.com/cran/pathfindR>

Run `revdepcheck::revdep_details(, "pathfindR")` for more info

## In both

*   R CMD check timed out


