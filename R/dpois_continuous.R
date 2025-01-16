#' @title Poisson distribution, version continuous in both arguments
#'
#' @description
#' This is a continuous version of dpois(x, lambda).
#' In dpois(x, lambda) x is restricted to be a non negative integer;
#' lambda can be any non negative real number.
#' In dpois_continuous(x, lambda) both x and lambda can be any non negative
#' real number.
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
  # lambda^x * exp(-lambda) / factorial(x)
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
