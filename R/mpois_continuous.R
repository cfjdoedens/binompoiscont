#' @title
#' Under construction: Bayesian upper, i.e. Maximum, credible bound for defect rate for Poisson model
#'
#' @description
#' This function calculates the maximum estimated defect rate (p) given
#' minimal certainty of `certainty`, for a population,
#' which was sampled with `n` samples of which
#' the sum of defects rates is `k`.
#' The calculation is based on the Poisson model.
#'
#' In other words, the function finds the value of `p` that solves the equation:
#' `P(X <= k | n, p) = 1 - certainty`
#' where `X` follows a Poisson distribution.
#'
#' @param k A numeric value representing the number of observed defects.
#'   Need not be an integer. Must be non-negative.
#' @param n A numeric value representing the sample size. Need not be an integer.
#'   Must be greater than 0.
#' @param certainty A numeric value between 0 and 1 representing the desired
#'   level of confidence (e.g., 0.95 for 95% certainty).
#'
#' @return A numeric value representing the maximum estimated defect rate (p).
#'
#' @importFrom ewgraph posint
#' @importFrom stats pgamma
#' @importFrom stats uniroot
# examples
# # If we test 20 items and find 0 defects, what is the maximum defect
# # rate we can state with 95% certainty?
# mpois_continuous(k = 0, n = 20, certainty = 0.95)
#
# # With 5 defects in a sample of 100, what's the upper bound of the
# # defect rate with 95% certainty?
# mpois_continuous(k = 5, n = 100, certainty = 0.95)
mpois_continuous <- function(k, n, certainty) {
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
      shape <- k + 1
      rate <- n
      pgamma(p, shape, rate) - certainty
    }

    # ad 2.
    # We use uniroot() from stats.

    # ad 3.
    return(uniroot(f, lower = 0, upper = 1)$root)
  }
}
