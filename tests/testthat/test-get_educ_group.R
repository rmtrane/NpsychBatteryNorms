test_that("get_educ_group", {
  expected <- data.frame(
    educ_group = factor(
      c("<13", "13-15", "16", ">16"),
      levels = c("<13", "13-15", "16", ">16")
    ),
    min = c(0, 13, 16, 17),
    max = c(12, 15, 16, 30)
  )

  actual <- data.frame(
    all_educs = 0:30,
    educ_group = get_educ_group(0:30)
  )

  actual <- aggregate(
    data = actual,
    all_educs ~ educ_group,
    \(x) {
      c(
        min = min(x),
        max = max(x)
      )
    }
  )
  actual$min <- actual$all_educs[, "min"]
  actual$max <- actual$all_educs[, "max"]
  actual$all_educs <- NULL

  expect_equal(
    actual,
    expected
  )
})
