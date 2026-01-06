# binompoiscont

The goal of binompoiscont is to provide continuous versions of the
binomial and Poisson distributions. These versions are implemented as
the functions `dbinom_continuous(k, n, p)`, `dpois3_continuous(k, n, p)`
and `dpois_continuous(x, lambda)`.

For a background article see “Continuous counterparts of Poisson and
binomial distributions and their properties” by Andrii Ilienko. For
example to be found through the following link:
<https://arxiv.org/abs/1303.5990>.

The function
[`dbinom_continuous()`](https://cfjdoedens.github.io/binompoiscont/reference/dbinom_continuous.md)
provided by this package is based on a beta() function equivalent. This
is done by straightforward derivation of both shape parameters,
`shape1`, and `shape2`, from the arguments `k` and `n` for
[`dbinom()`](https://rdrr.io/r/stats/Binomial.html). `shape1 = k + 1`,
`shape2 = n - k + 1`. It is not clear to me how to derive the beta
function shape parameters `shape1` and `shape2` from the parameters of
[`pbinom()`](https://rdrr.io/r/stats/Binomial.html),
[`qbinom()`](https://rdrr.io/r/stats/Binomial.html),
[`rbinom()`](https://rdrr.io/r/stats/Binomial.html). The parameter `k`,
or an equivalent, is not used by these functions. And I do not know how
to formulate in other ways equivalent (but continuous) beta functions
for [`pbinom()`](https://rdrr.io/r/stats/Binomial.html),
[`qbinom()`](https://rdrr.io/r/stats/Binomial.html), and
[`rbinom()`](https://rdrr.io/r/stats/Binomial.html) functions. Therefore
continuous versions of these latter functions are not provided in this
package.

The functions `dpois_continous()` and `dpois3_continous()` are based on
the [`gamma()`](https://rdrr.io/r/base/Special.html) function. I have
not looked into how to find continuous versions for
[`ppois()`](https://rdrr.io/r/stats/Poisson.html),
[`qpois()`](https://rdrr.io/r/stats/Poisson.html) and
[`rpois()`](https://rdrr.io/r/stats/Poisson.html).

## Installation

You can install the development version of binompoiscont from
[GitHub](https://github.com/) with:

``` r
  if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
  }
  devtools::install_github("cfjdoedens/binompoiscont")
```

## Interactive Visualization

Want to see the distributions in action? This package includes a Shiny
app. Run this in your R console:

binompoiscont::run_app()

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
#> [1] NaN

## The same for the dpois() function.
dpois(k, n * p)
#> [1] 0

## But this probability can be calculated with the continuous versions.
dbinom_continuous(k, n, p)
#> [1] 0.2457182
dpois3_continuous(k, n, p)
#> [1] 0.2028806
dpois_continuous(k, n * p)
#> [1] 0.2028806
```
