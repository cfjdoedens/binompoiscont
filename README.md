
<!-- README.md is generated from README.Rmd. Please edit that file -->

# binompoiscont

<!-- badges: start -->

<!-- badges: end -->

The goal of binompoiscont is to provide continuous versions of the
binomial and Poisson distributions. These versions are implemented as
the functions `dbinom_continuous(k, n, p)`, `dpois3_continuous(k, n, p)`
and `dpois_continuous(x, lambda)`.

For a background article see “Continuous counterparts of Poisson and
binomial distributions and their properties” by Andrii Ilienko. For
example to be found through the following link:
<https://arxiv.org/abs/1303.5990>.

The function `dbinom_continuous()` provided by this package is based on
a beta() function equivalent. This is done by straightforward derivation
of both shape parameters, `shape1`, and `shape2`, from the arguments `k`
and `n` for `dbinom()`. `shape1 = k + 1`, `shape2 = n - k + 1`. It is
not clear to me how to derive the beta function shape parameters
`shape1` and `shape2` from the parameters of `pbinom()`, `qbinom()`,
`rbinom()`. The parameter `k`, or an equivalent, is not used by these
functions. And I do not know how to formulate in other ways equivalent
(but continuous) beta functions for `pbinom()`, `qbinom()`, and
`rbinom()` functions. Therefore continuous versions of these latter
functions are not provided in this package.

The functions `dpois_continous()` and `dpois3_continous()` are based on
the `gamma()` function. I have not looked into how to find continuous
versions for `ppois()`, `qpois()` and `rpois()`.

## Installation

You can install the development version of binompoiscont from
[GitHub](https://github.com/) with:

``` r
install.packages("pak")
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

## But this probability can be calculated with the continuous versions.
dbinom_continuous(k, n, p)
#> [1] 0.2457182
dpois3_continuous(k, n, p)
#> [1] 0.2028806
dpois_continuous(k, n * p)
#> [1] 0.2028806
```
