#' Continuous version of dbinom(k, n, p, log = FALSE)
#'
#' @description
#' dbinom_continuous(k, n, p, log = FALSE) is a continuous version of
#' dbinom(k, n, p, log = FALSE).
#' In dbinom(k, n, p, log = FALSE), k and n are restricted to be non
#' negative whole numbers, with k <= n.
#' In dbinom_continuous(k, n, p, log = FALSE), both k and n can be any non
#' negative real number. The restriction k <= n still holds.
#'
#' dbinom(k, n, p) is the probability of k successes in n trials, each with
#' probability p.
#' How to interpret this when k and n are not whole numbers?
#' So, how to interpret dbinom_continuous(k, n, p) for non integer values of
#' n and k?
#'
#' The problem I want to tackle with this continuous binomial distribution is
#' when we draw a monetary unit sample to estimate p, the total fraction of
#' errors of the monetary mass. We draw n samples. We sum the
#' fractions of errors in the n samples. This sum is k. So this explains
#' a non integer k. The non integer n can be used for the case where the
#' monetary interval used is not a whole integer multiple of the total
#' monetary mass.
#'
#' Mathematically we know that dbinom_continuous(k, n, p) is the same as
#' dbeta(p, k + 1, n - k + 1) / (n + 1). This we use below to implement
#' dbinom_continuous().
#'
#' The behaviour of dbinom_continuous is also different from dbinom
#' in the way vector arguments of length > 1 are treated.
#' dbinom() allows for a mix of lengths for k, n and p; but this makes
#' the semantics of the function less clear.
#' So, for dbinom_continuous, only one of k and n and p can have a length > 1.
#'
#' @param k a vector of 1 or more non negative real numbers;
#' so k can be a non integer number >= 0; k <= n
#' @param n a vector of 1 or more positive real numbers;
#' so n can be a non integer number >= 0; k <= n
#' @param p a vector of 1 or more real numbers in \[0, 1\]
#' @param log TRUE or FALSE
#'
#' @returns
#' A real number in \[0, 1\], which represents the chance of observing k
#' successes in n trials, each with probability p.
#' @export
#'
#' @examples
#' y <- dbinom_continuous(0, 300, 0.01)
#' print(y)
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

