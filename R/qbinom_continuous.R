#' Continuous version of qbinom(certainty, n, p, log = FALSE)
#'
#' @description
#' pbinom_continuous(certainty, n, p, log = FALSE) is a continuous version of
#' pbinom(certainty, n, p, log = FALSE).
#' In pbinom(certainty, n, p, log = FALSE), n is restricted to be a non
#' negative whole number.
#' In pbinom_continuous(certainty, n, p, log = FALSE), n can be any non
#' negative real number.
#'
#' pbinom_continuous(certainty, n, p, log = FALSE) is the
#' cumulative density function of a continuous version of the binomial
#' chance density function, given n samples from a mass with a fraction
#' of p errors.
#'
#' The problem I want to tackle with this continuous binomial distribution is
#' to assess the probability of the result of n monetary unit samples drawn from
#' a monetary mass, given we know p, the total fraction of
#' errors of the monetary mass. We then take k to be the sum of the
#' fractions of errors in the n samples. So this explains
#' a non integer k. The non integer n can be used for the case where the
#' monetary interval used is not a whole integer multiple of the total
#' monetary mass.
#'
#' Not only is pbinom_continuous(certainty, n, p) continuous in n,
#' whereas pbinom(certainty, n, p) is not; pbinom_continuous is also different from pbinom
#' in the way vector arguments of length > 1 are treated.
#' pbinom() allows for a mix of lengths for certainty, n and p.
#' This makes
#' the semantics of the function less clear.
#' Therefore with pbinom_continuous, only one of certainty and n and p can have a length > 1.
#'
#' Mathematically we know that pbinom(certainty, n, p) equals
#' pbeta(certainty, k + 1, n - k + 1) / (n + 1). This we use below to implement
#' dbinom_continuous().
#'
#' @param certainty a vector of 1 or more non negative real numbers;
#' so k can be a non integer number >= 0; k <= n
#' @param n a vector of 1 or more positive real numbers;
#' so n can be a non integer number >= 0; k <= n
#' @param p a vector of 1 or more real numbers in \[0, 1\]
#' @param log TRUE or FALSE
#'
#' @returns
#' A real number in \[0, 1\], which represents the cumulative chance density
#'  of observing k
#' successes in n trials, each with probability p.
#' @export
#'
#' @examples
#'   dbinom_continuous(0, 300, 0.01)
#' @importFrom stats dbeta
#'
dbinom_continuous <- function(k, n, p, log = FALSE) {
  # We allow that only one of k, n, p has a length > 1.
  if(length(k) > 1) {
    stopifnot(length(n) == 1 && length(p) == 1)
  }  else if(length(n) > 1) {
    stopifnot(length(k) == 1 && length(p) == 1)
  }  else if(length(p) > 1) {
    stopifnot(length(k) == 1 && length(n) == 1)
  }

  # When k is a vector, recur over each element of the vector.
  if (length(k) > 1) {
    r <- double(length(k))
    for (i in 1:length(k)) {
      r[[i]] <- dbinom_continuous(k[[i]], n, p, log)
    }
    return(r)
  }

  # When n is a vector, recur over each element of the vector.
  if (length(n) > 1) {
    r <- double(length(n))
    for (i in 1:length(n)) {
      r[[i]] <- dbinom_continuous(k, n[[i]], p, log)
    }
    return(r)
  }

  # When p is a vector, recur over each element of the vector.
  if (length(p) > 1) {
    r <- double(length(p))
    for (i in 1:length(p)) {
      r[[i]] <- dbinom_continuous(k, n, p[[i]], log)
    }
    return(r)
  }

  # Check input values.
  stopifnot(length(k) == 1)
  stopifnot(length(n) == 1)
  stopifnot(length(p) == 1)

  stopifnot(0 <= k, k <= n)
  stopifnot(0 <= n)
  stopifnot(0 <= p, p <= 1)

  # We catch the situation where p is 0, or 1,
  # as below we might want to be able to use log(p) and log(1-p),
  # and log(p) == -Inf, for p is 0, and log(1-p) == -Inf for p is 1.
  if (p == 0 && k == 0) {
    return(1)
  }
  if (p == 0 && k > 0) {
    return(0)
  }
  if (p == 1 && k == n) {
    return(1)
  }
  if (p == 1 && k < n) {
    return(0)
  }

  # Use dbeta().
  # I cite from
  # https://en.wikipedia.org/wiki/Binomial_distribution#Beta_distribution:
  # "
  # Beta distribution
  #
  # The binomial distribution and beta distribution are different views of
  # the same model of repeated Bernoulli trials.
  # The binomial distribution is the PMF of k successes given n
  # independent events each with a probability p of success.
  # Mathematically, when α = k + 1 and β = n − k + 1,
  # the beta distribution and the binomial distribution are related
  # by a factor of n + 1:
  # Beta(p; α; β) = (n + 1) B(k; n; p)
  # "
  # Here B(k; n; p) is the binomial distribution.
  # So B(k; n; p) = Beta(p; α; β) / (n + 1).
  # Or B(k; n; p) = dbeta(p, k + 1, n - k + 1) / (n + 1).
  if (!log) {
    r <- dbeta(p, k + 1, n - k + 1) / (n + 1)
  } else {
    r <- log(dbeta(p, k + 1, n - k + 1)) - log(n + 1)
    # Or use lgamma():
    # beta_part <- lgamma(n + 1) - lgamma(k + 1) - lgamma(n - k + 1)
    # prob_part <- k*log(p) + (n - k)*log(1-p)
    # r <- beta_part + prob_part
  }
  stopifnot(!is.nan(r)) # is.nan(r) should not happen.
  r
}

