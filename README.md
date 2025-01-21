
<!-- README.md is generated from README.Rmd. Please edit that file -->

# binompoiscont

<!-- badges: start -->

<!-- badges: end -->

The goal of binompoiscont is to provide continuous versions of the
binomial and Poisson distributions. These versions are implemented as
the functions dbinom_continuous(k, n, p), dpois3_continuous(k, n, p) and
dpois_continuous(x, lambda).

## Installation

You can install the development version of binompoiscont from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("cfjdoedens/binompoiscont")
```

## Example

The following code shows the usefulness of dbinom_continuous(k, n, p),
dpois3_continuous(k, n, p) and dpois_continuous(x, lambda).

``` r
library(binompoiscont)
## Suppose we do 10.3 trials with a probability of success of 0.3, and we
## want to know the probability that the sum of the successes
## is 3.5.
n <- 10.3
k <- 3.5
p <- 0.3

## If we use the dbinom() function we get an error: computer says no, can't do this.
dbinom(k, n, p)
#> Warning in dbinom(k, n, p): NaNs produced
#> [1] NaN

## The same for the dpois() function.
dpois(k, n * p)
#> Warning in dpois(k, n * p): non-integer x = 3.500000
#> [1] 0

## But his probability can be calculated with the continuous versions.
dbinom_continuous(k, n, p)
#> [1] 0.2457182
dpois3_continuous(k, n, p)
#> [1] 0.2028806
dpois_continuous(k, n * p)
#> [1] 0.2028806
```
