test_that("remove_errorcodes", {
  expect_equal(
    valid_values_only(
      raw_score = c(15, 80, 95),
      var_name = "ANIMALS",
      remove_errorcodes = FALSE
    ),
    c(15, NA, 95)
  )

  expect_equal(
    valid_values_only(
      raw_score = c(15, 80, 95),
      var_name = "ANIMALS",
      remove_errorcodes = T
    ),
    c(15, NA, NA)
  )

  expect_equal(
    valid_values_only(
      raw_score = c(15, 80, 95, 96),
      var_name = "ANIMALS",
      remove_errorcodes = T
    ),
    c(15, NA, NA, NA)
  )

  expect_equal(
    valid_values_only(
      raw_score = c(15, 80, 95, 96),
      var_name = "ANIMALS",
      remove_errorcodes = 95
    ),
    c(15, NA, NA, 96)
  )
})
