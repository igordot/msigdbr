## Test environments
* local R installation (macOS): R 4.4.2
* ubuntu-latest (on GitHub Actions): R 4.1, R-release, R-devel
* macOS (on GitHub Actions): R-release
* Windows (on GitHub Actions): R-release
* win-builder: R-devel

## R CMD check results

0 errors | 0 warnings | 1 note

## revdepcheck results

We checked 36 reverse dependencies (14 from CRAN + 22 from Bioconductor), comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 2 new problems
 * We failed to check 2 packages

## Resubmission

For the resubmission, I have:

 * Adjusted the included data to reduce the number of problems with reverse dependencies.
 * The maintainers of affected reverse dependencies have been notified on February 21.
