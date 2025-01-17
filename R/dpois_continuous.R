#' @title Poisson distribution, version continuous in both arguments
#'
#' @description
#' This is a continuous version of dpois(x, lambda).
#' In dpois(x, lambda) x is restricted to be a non negative integer;
#' lambda can be any non negative real number.
#' In dpois_continuous(x, lambda) both x and lambda can be any non negative
#' real number. So for dpois_continuous(x, lambda) x does not need to be an
#' integer, but can be 0 or any positive real number.
#'
#' dpois(x, lambda) is the probability of x events occurring in the interval
#' or space given that lambda events occur on average in that interval or space.
#' How to interpret this when x is not a whole number?
#' So, how to interpret dpois_continuous(x, lambda) for non integer values of
#' x?
#'
#' The problem I want to tackle with this continuous Poisson distribution is
#' when we draw a monetary unit sample to estimate p, the total fraction of
#' errors of the monetary mass. We draw n samples. We sum the
#' fractions of monetary errors in the n samples. This sum is x.
#' So this explains a non integer x.
#'
#' Lambda is given as n*p. Lambda is the expected number of errors in the n
#' samples. So lambda is the expected value of x.
#'
#' Mathematically we know that dpois(x, lambda) is the same as
#' lambda^x * exp(-lambda) / factorial(x).
#' When x is not an integer we can use the gamma function to calculate the
#' factorial(x) part of the formula. So we can use gamma(x + 1) instead of
#' factorial(x). This is because gamma(x + 1) = x!.
#' So, dpois_continuous(x, lambda) is the same as
#' lambda^x * exp(-lambda) / gamma(x + 1).
#' This we use below in the code for dpois_continuous().
#'
#' @param x the number of events that actually occur in a given interval of
#'   time or space; x >= 0
#'
#' @param lambda the number of events that on average occur in that given
#'   interval; lambda >= 0
#'
#' @returns The probability of x events occurring in the interval or space given
#'   that lambda events occur on average
#' @export
#'
#' @examples
#'   dpois_continuous(3, 3)
dpois_continuous <- function(x, lambda) {
  # For x is integer we would have
  #   dpois(x, lambda) = lambda^x * exp(-lambda) / factorial(x).
  # But to cater for possibly non integer values of x we use gamma(x +1) instead
  # of factorial(x).
  lambda^x * exp(-lambda) / gamma(x + 1)
}

#' @title continuous binomial distribution approximated by continuous Poisson distribution
#'
#' @param k Number of successes
#' @param n Number of trials
#' @param p Probability of success
#'
#' @returns The probability of k successes in n trials with probability p
#' @export
#'
#' @examples
#'   dpois3_continuous(3, 10, 0.3)
#'   dpois3_continuous(0, 300, 0.01)
dpois3_continuous <- function(k, n, p) {
  dpois_continuous(k, n * p)
}
