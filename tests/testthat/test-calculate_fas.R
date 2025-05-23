test_that("calculate FAS", {
  expect_equal(calculate_fas(1, 1, 1, 1, 1, 1, 1, 1, 1, 1), 10)

  expect_equal(
    calculate_fas(
      c(1, 0),
      c(1, 2),
      c(1, 0),
      c(1, 2),
      c(1, 0),
      c(1, 2),
      c(1, 0),
      c(1, 2),
      c(1, 0),
      c(1, 2)
    ),
    c(10, 10)
  )
})
