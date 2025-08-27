test_that("reyarec", {
  expect_equal(
    calculate_reyarec(c(14, 2, 17), c(2, 14, 3)),
    c(90, 10, NA)
  )
})

test_that("reytotal", {
  all_reys <- expand.grid(
    REY1REC = 0:15,
    REY2REC = 0:15,
    REY3REC = 0:15,
    REY4REC = 0:15,
    REY5REC = 0:15
  )

  expect_equal(
    do.call(calculate_reytotal, all_reys),
    rowSums(all_reys)
  )

  expect_equal(
    calculate_reytotal(1, 2, 3, 4, 16),
    NA_real_
  )

  expect_error(
    calculate_reytotal(1, 2, 3, 4, NA)
  )

  expect_error(
    calculate_reytotal(1, 2, 3, 4, "A")
  )
})

test_that("FAS", {
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

test_that("mocaclock", {
  expect_equal(
    with(
      expand.grid(MOCACLOC = c(0, 1), MOCACLON = c(0, 1), MOCACLOH = c(0, 1)),
      calculate_mocaclock(MOCACLOC, MOCACLON, MOCACLOH)
    ),
    c(0, 1, 1, 2, 1, 2, 2, 3)
  )

  expect_equal(
    calculate_mocaclock(0, 1, 3),
    NA_real_
  )

  expect_error(
    calculate_mocaclock(0, 1, NA)
  )
})
