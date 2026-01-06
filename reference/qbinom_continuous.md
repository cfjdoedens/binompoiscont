# Under construction: Calculate the Maximum Estimated Defect Rate (Continuous Case)

This function calculates the maximum estimated defect rate (p) for a
population, given a number of observed defects (k) in a sample of size
(n). It is equivalent to finding the upper bound of a one-sided
confidence interval for a binomial proportion.

## Usage

``` r
qbinom_continuous(k, n, certainty)
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

## Details

The function finds the value of `p` that solves the equation: P(X \<= k
\| n, p) = 1 - certainty where X follows a binomial distribution.
