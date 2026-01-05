# Bayesian upper, i.e. Maximum, credible bound for defect rate for Poisson model

This function calculates the maximum estimated defect rate (p) given
minimal certainty of `certainty`, for a population, which was sampled
with `n` samples of which the sum of defects rates is `k`. The
calculation is based on the Poisson model.

In other words, the function finds the value of `p` that solves the
equation: `P(X <= k | n, p) = 1 - certainty` where `X` follows a Poisson
distribution.

## Usage

``` r
mpois_continuous(k, n, certainty)
```

## Arguments

- k:

  A numeric value representing the number of observed defects. Need not
  be an integer. Must be non-negative.

- n:

  A numeric value representing the sample size. Need not be an integer.
  Must be greater than 0.

- certainty:

  A numeric value between 0 and 1 representing the desired level of
  confidence (e.g., 0.95 for 95% certainty).

## Value

A numeric value representing the maximum estimated defect rate (p).
