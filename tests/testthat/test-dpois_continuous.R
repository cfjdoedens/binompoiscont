test_that("dpois3_continuous(k, n, p) should equal dpois(k, n*p) for k nonnegint and n posint", {
  for (k in 0:10) {
    for (n in 1:10) {
      for (p in seq(0.1, 0.9, by = 0.1)) {
        expect_equal(dpois3_continuous(k, n, p), dpois(k, n*p))
      }
    }
  }
})

test_that("dpois_continuous(x, lambda) should equal dpois(x, lambda) for k nonnegint and n posint", {
  for (k in 0:10) {
    for (n in 1:10) {
      for (p in seq(0.1, 0.9, by = 0.1)) {
        expect_equal(dpois3_continuous(k, n, p), dpois(k, n*p))
      }
    }
  }
})
