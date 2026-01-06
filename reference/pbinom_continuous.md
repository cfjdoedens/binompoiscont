# Under construction: Continuous version of pbinom(k, n, p, log = FALSE)

HOW COME the frequentist prior of beta(0, 1) equals the outcome of the
non continuous version: pbinom()??? (on the integer parameter values for
k and n)

pbinom_continuous(k, n, p) is a continuous version of pbinom(k, n, p,
log = FALSE). In pbinom(k, n, p, log = FALSE), n is restricted to be a
non negative whole number. In pbinom_continuous(k, n, p), n can be any
non negative real number.

pbinom_continuous(k, n, p) is the cumulative density function of a
continuous version of the binomial chance density function, given n
samples from a mass with a fraction of p errors.

The problem I want to tackle with this continuous binomial distribution
is to assess the probability of the result of n monetary unit samples
drawn from a monetary mass, given we know p, the total fraction of
errors of the monetary mass. We then take k to be the sum of the
fractions of errors in the n samples. So this explains a non integer k.
The non integer n can be used for the case where the monetary interval
used is not a whole integer multiple of the total monetary mass.

Not only is pbinom_continuous(k, n, p) continuous in n, whereas
pbinom(k, n, p) is not; pbinom_continuous is also different from pbinom
in the way vector arguments of length \> 1 are treated. pbinom() allows
for a mix of lengths for k, n and p; this makes the semantics of
pbinom() less clear. Therefore with pbinom_continuous, only one of k and
n and p can have a length \> 1.

Mathematically we know that pbinom(k, n, p) equals pbeta(q = 1 - p,
shape1 = n - k, shape2 = k + 1). This we use below to implement
pbinom_continuous().

For the moment LOG = TRUE is not implemented.

## Usage

``` r
pbinom_continuous(
  k = 0,
  n = 300,
  p = 0.01,
  lower.tail = TRUE,
  bayesian = FALSE
)
```

## Arguments

- k:

  The number of defects, or the sum of the partial defects, in the `n`
  drawn items. `k` is a vector of 1 or more non negative real numbers;
  so `k` can be a non integer number `>= 0`; `k <= n`

- n:

  The number of drawn items. `n` is a vector of 1 or more positive real
  numbers; so `n` can be a non integer number `>= 0`; `k <= n`

- p:

  Right limit along the p-axis of the part of the surface below the
  chance curve that is returned by pbinom_continuous(). `p` is a vector
  of 1 or more real numbers in \[0, 1\]

- lower.tail:

  TRUE or FALSE. When TRUE the cumulative density is returned, i.e. the
  surface left of the location of p is returned. When FALSE 1 - the
  cumulative density is returned, i.e. the surface right of the location
  of p is returned.

- bayesian:

  TRUE or FALSE When FALSE the frequentist asymmetric prior beta(0, 1)
  is used. When TRUE the bayesian and symmetric prior beta(1, 1) is
  used.

## Value

A real number in \[0, 1\], which represents the cumulative chance
density of observing `k` successes in `n` trials, each with probability
`p`.
