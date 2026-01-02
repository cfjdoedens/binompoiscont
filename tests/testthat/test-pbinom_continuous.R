test_that("pbinom_continuous basically works", {
  r1 <- pbinom_continuous(k = 0, n = 300, p = 0.01)
  r2 <- pbinom(0, 300, 0.01)
  expect_equal(r1, r2)
})

test_that(
  "for integer values of k and n, pbinom and pbinom_continuous
   should produce the same results",
  {
    skip_on_cran()
    for (n in 1:43) {
      for (k in 0:n) {
        for (p in seq(0.00, 1, by = 1/7)) {
          expect_equal(pbinom(k, n, p), pbinom_continuous(k, n, p))
        }
      }
    }
  }
)

test_that("pbinom_continuous should be able to handle length(k) > 1", {
  k <- 0:3
  n <- 4
  p <- 0.5
  expect_equal(length(k), length(pbinom_continuous(k, n, p)))
})

test_that("pbinom_continuous should be able to handle length(n) > 1", {
  k <- 0
  n <- 4:7
  p <- 0.5
  expect_equal(length(n), length(pbinom_continuous(k, n, p)))
})

test_that("pbinom_continuous should be able to handle length(p) > 1", {
  k <- 0
  n <- 4
  p <- c(0.1, 0.2, 0.3, 0.4, 0.5)
  expect_equal(length(p), length(pbinom_continuous(k, n, p)))
})

test_that("pbinom_continuous should abort when more than one of k,n,p has length > 1",
          {
            k1 <- 0
            km <- 0:3
            n1 <- 4
            nm <- 4:7
            p1 <- 0.5
            pm <- c(0.1, 0.2, 0.3, 0.4, 0.5)
            expect_error(pbinom_continuous(km, nm, p1))
            expect_error(pbinom_continuous(km, n1, pm))
            expect_error(pbinom_continuous(k1, nm, pm))
            expect_error(pbinom_continuous(km, nm, pm))
          })
