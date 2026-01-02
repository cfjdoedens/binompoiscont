# Bayesian upper, i.e. Maximum, credible bound for defect rate
#
#   UNDER CONSTRUCTION !!!!!!
#   Still to do:
#   - add recursion over k, n, certainty
#   - add parameter to say to use which prior (freq, Bayes):
#       0, 1 or 1, 1 or otherwise (?)
#   - add parameter for lower tail
# Calculate the Maximum Estimated Defect Rate (Continuous Case)
#
# This function calculates the maximum estimated defect rate (p) for a population,
# given a number of observed defects (k) in a sample of size (n). It is
# equivalent to finding the upper bound of a one-sided confidence interval for a
# binomial proportion.
#
# The function finds the value of `p` that solves the equation:
# P(X <= k | n, p) = 1 - certainty
# where X follows a binomial distribution.
#
# @param k a vector of 1 or more non negative real numbers;
#   so k can be a non integer number >= 0; k <= n
# @param n a vector of 1 or more positive real numbers;
#   so n can be a non integer number >= 0; k <= n
# @param certainty a vector of 1 or more real numbers in \[0, 1\]
#
# @returns A real number in \[0, 1\], which represents the upper credible bound
# @export
# @importFrom stats qbeta
# examples
#   qbinom_continuous()
#
# qbinom_continuous <- function(k = 0,
#                               n = 300,
#                               certainty = 0.95) {
#   # Prior parameters (e.g., for a Uniform(0,1) prior, which is Beta(1,1))
#   alpha_prior <- 0 # Frequentist.
#   # alpha_prior <- 1 # Bayesian
#   beta_prior <- 1
#
#   # Calculate posterior parameters
#   alpha_posterior <- alpha_prior + k
#   beta_posterior <- beta_prior + (n - k)
#
#   # Calculate the upper credible bound using qbeta()
#   # qbeta(certainty, shape1, shape2) where certainty is the quantile
#   r <- qbeta(p = certainty, shape1 = alpha_posterior, shape2 = beta_posterior)
#
#   return(r)
# }

#' Calculate the Maximum Estimated Defect Rate (Continuous Case)
#'
#' This function calculates the maximum estimated defect rate (p) for a population,
#' given a number of observed defects (k) in a sample of size (n). It is
#' equivalent to finding the upper bound of a one-sided confidence interval for a
#' binomial proportion.
#'
#' The function finds the value of `p` that solves the equation:
#' P(X <= k | n, p) = 1 - certainty
#' where X follows a binomial distribution.
#'
#' @param k A numeric value representing the number of observed defects.
#'   Need not be an integer. Must be non-negative.
#' @param n A numeric value representing the sample size. Need not be an integer.
#'   Must be greater than 0.
#' @param certainty A numeric value between 0 and 1 representing the desired
#'   level of confidence (e.g., 0.95 for 95% certainty).
#'
#' @return A numeric value representing the maximum estimated defect rate (p).
#' @importFrom ewgraph posint
#' @examples
#' # If we test 20 items and find 0 defects, what is the maximum defect
#' # rate we can state with 95% certainty?
#' qbinom_continuous(k = 0, n = 20, certainty = 0.95)
#' # Expected output: ~0.139
#'
#' # With 5 defects in a sample of 100, what's the upper bound of the
#' # defect rate with 95% certainty?
#' qbinom_continuous(k = 5, n = 100, certainty = 0.95)
#' # Expected output: ~0.107

qbinom_continuous <- function(k, n, certainty) {
  # Still to handle: when length k, n, certainty > 1.

  # Check input.
  stopifnot(is.numeric(k))
  stopifnot(posint(n))
  stopifnot(k <= n)
  stopifnot(is.numeric(certainty))
  stopifnot(0 <= certainty)
  stopifnot(certainty <= 1)

  # Edge cases.
  if (certainty == 1) {
    return(1)
  }
  if (certainty == 0) {
    return(0)
  }

  # We formulate this as a root-finding problem: f(p) = 0.
  # For this we need three things:
  # 1. A function f(), that becomes 0 for the sought for value.
  # 2. A root-finding (meta) function.
  # 3. Application of the root-finding function to f()
  {
    # ad 1.
    # The function f(p) becomes 0 when the cumulative probability
    # of observing k or fewer defects is certainty.
    f <- function(p) {
      pbinom_continuous(k = k, n = n, p = p) - certainty
    }

    # ad 2.
    # We use uniroot() from stats.

    # ad 3.
    return(uniroot(f, lower = 0, upper = 1)$root)
  }
}
