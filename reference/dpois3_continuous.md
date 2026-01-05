# Poisson density function, version continuous in both arguments

Poisson density function, version continuous in both arguments

## Usage

``` r
dpois3_continuous(k, n, p)
```

## Arguments

- k:

  Number of successes

- n:

  Number of trials

- p:

  Probability of success

## Value

The probability of k successes in n trials with probability p based on
the Poisson model.

## Details

dpois3(k, n, p) = dpois_continuous(k, n \* p) = lambda^x \* exp(-lambda)
/ gamma(x + 1) Here x = k and lambda = n*p. So dpois3(k, n, p) = (n*p)^k
\* exp(-n\*p) / gamma(k + 1)

We can compare this to dgamma(x, shape, rate). Here shape = k + 1 and
rate = n. And rate = 1/scale.

dgamma(x, shape, rate) = ((scale^shape) \* gamma(shape))^-1 \*
x^(shape-1) \* exp(-(x/scale)) divide instead of ^-1 = x^(shape-1) \*
exp(-(x/scale)) / ((scale^shape) \* gamma(shape)) fill in shape = x^(k +
1 -1) \* exp(-(x/scale)) / ((scale^(k + 1)) \* gamma(k + 1)) k + 1 -1 =
k = x^k \* exp(-(x/scale)) / ((scale^(k + 1)) \* gamma(k + 1)) scale =
1/n = x^k \* exp(-(x*n)) / (((1/n)^(k + 1)) \* gamma(k + 1))
(1/n)^(k + 1) = (n^(k+1))^-1 = 1/(n^(k+1)) = x^k \* exp(-(x*n)) \*
(n^(k + 1)) / gamma(k + 1) x = p = p^k \* exp(-(p*n)) \* (n^(k + 1)) /
gamma(k + 1) exp(-(p*n)) = exp(-n*p) = p^k \* exp(-n*p) \* (n^(k + 1)) /
gamma(k + 1) remove some () = p^k \* exp(-n*p) \* n^(k + 1) /
gamma(k + 1) p^k \* n^(k + 1) = n \* (n*p)^k = n \* (n*p)^k \*
exp(-(n*p)) / gamma(k + 1)

## Examples

``` r
  dpois3_continuous(3, 10, 0.3)
#> [1] 0.2240418
  dpois3_continuous(0, 300, 0.01)
#> [1] 0.04978707
```
