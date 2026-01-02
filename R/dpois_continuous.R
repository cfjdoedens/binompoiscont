#' @title
#'   Poisson density function, version continuous in both arguments
#'
#' @description
#' This is a continuous version of dpois(x, lambda).
#' In dpois(x, lambda) x is restricted to be a non negative _integer_;
#' lambda can be any non negative real number.
#' In dpois_continuous(x, lambda) both x and lambda can be any non negative
#' _real_ number. So for dpois_continuous(x, lambda) x does not need to be an
#' integer, but can be 0 or any positive real number.
#'
#' dpois(x, lambda) is the probability of x events occurring in the interval
#' or space given that lambda events occur on average in that interval or space.
#' How to interpret this when x is not a whole number?
#' So, how to interpret dpois_continuous(x, lambda) for non integer values of
#' x?
#'
#' The problem I want to tackle with this continuous Poisson distribution is
#' to assess the probability of the result of n monetary unit samples drawn from
#' a monetary mass, given we know p, the total fraction of
#' errors of the monetary mass. We then take x to be the sum of the
#' fractions of monetary errors in the n samples.
#' So this explains a non integer x.
#'
#' Lambda is given as n*p. Lambda is the average expected number of errors in the
#' n samples. So lambda is the expected value of x.
#'
#' Mathematically we know that dpois(x, lambda) is the same as
#' lambda^x * exp(-lambda) / factorial(x).
#' When x is not an integer we can use the gamma function to calculate the
#' factorial(x) part of the formula. So we can use gamma(x + 1) instead of
#' factorial(x). This is because gamma(x + 1) = x!.
#' So, dpois(x, lambda) is the same as
#' lambda^x * exp(-lambda) / gamma(x + 1).
#' This we use below in the code for dpois_continuous().
#'
#' @param x the number of events that actually occur in a given interval of
#'   time or space; x >= 0
#' @param lambda the number of events that on average occur in that given
#'   interval; lambda >= 0
#' @returns The probability of x events occurring in the interval or space given
#'   that lambda events occur on average
#' @export
#'
#' @examples
#'   dpois_continuous(3, 3)
dpois_continuous <- function(x, lambda) {
  # For x is integer we would have
  #   dpois(x, lambda) = lambda^x * exp(-lambda) / factorial(x).
  # But to cater for possibly non integer values of x we use gamma(x + 1) instead
  # of factorial(x).
  lambda^x * exp(-lambda) / gamma(x + 1)
}

#' @title
#'   Poisson density function, version continuous in both arguments
#'
#' @details
#' dpois3(k, n, p)
#'   = dpois_continuous(k, n * p)
#'   = lambda^x * exp(-lambda) / gamma(x + 1)
#' Here x = k and lambda = n*p.
#' So
#' dpois3(k, n, p)
#'   = (n*p)^k * exp(-n*p) / gamma(k + 1)
#'
#' We can compare this to dgamma(x, shape, rate).
#' Here shape = k + 1 and rate = n. And rate = 1/scale.
#'
#' dgamma(x, shape, rate)
#'   = ((scale^shape) * gamma(shape))^-1 * x^(shape-1) * exp(-(x/scale))
#'   divide instead of ^-1
#'   = x^(shape-1) * exp(-(x/scale)) / ((scale^shape) * gamma(shape))
#'   fill in shape
#'   = x^(k + 1 -1) * exp(-(x/scale)) / ((scale^(k + 1)) * gamma(k + 1))
#'   k + 1 -1  = k
#'   = x^k * exp(-(x/scale)) / ((scale^(k + 1)) * gamma(k + 1))
#'   scale = 1/n
#'   = x^k * exp(-(x*n)) / (((1/n)^(k + 1)) * gamma(k + 1))
#'   (1/n)^(k + 1) = (n^(k+1))^-1 = 1/(n^(k+1))
#'   = x^k * exp(-(x*n)) * (n^(k + 1)) / gamma(k + 1)
#'   x = p
#'   = p^k * exp(-(p*n)) * (n^(k + 1)) / gamma(k + 1)
#'   exp(-(p*n)) = exp(-n*p)
#'   = p^k * exp(-n*p) * (n^(k + 1)) / gamma(k + 1)
#'   remove some ()
#'   = p^k * exp(-n*p) * n^(k + 1) / gamma(k + 1)
#'   p^k * n^(k + 1) = n * (n*p)^k
#'   = n * (n*p)^k * exp(-(n*p)) / gamma(k + 1)
#' @param k Number of successes
#' @param n Number of trials
#' @param p Probability of success
#'
#' @returns
#'   The probability of k successes in n trials with probability p
#'   based on the Poisson model.
#' @export
#'
#' @examples
#'   dpois3_continuous(3, 10, 0.3)
#'   dpois3_continuous(0, 300, 0.01)
dpois3_continuous <- function(k, n, p) {
  dpois_continuous(k, n * p)
}
