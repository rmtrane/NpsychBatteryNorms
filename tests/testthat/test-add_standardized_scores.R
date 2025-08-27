test_that("add_standardized_scores", {
  expect_error(
    add_standardized_scores(
      dat = demo_data,
      methods = "test"
    ),
    regexp = "'methods' must be a list"
  )

  expect_error(
    add_standardized_scores(
      dat = demo_data,
      methods = list("test" = "test")
    ),
    regexp = "'methods' must be named with names corresponding to variables to standardize"
  )

  expect_error(
    add_standardized_scores(
      dat = demo_data,
      methods = list("TRAILA" = c("method" = "wrong"))
    ),
    regexp = 'must be one of "norm", "regression", or "T-score"'
  )

  expect_error(
    add_standardized_scores(
      dat = demo_data,
      methods = list("TRAILA" = c(method = "regression", version = "wrong"))
    ),
    regexp = 'must be one of '
  )

  expect_error(
    add_standardized_scores(
      dat = demo_data,
      methods = list(
        "TRAILA" = c(method = "regression", version = "nacc_legacy")
      )
    ),
    regexp = "The methods specified for the following are invalid"
  )
})
