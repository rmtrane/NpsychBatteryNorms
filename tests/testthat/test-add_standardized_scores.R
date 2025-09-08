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

  mthds_to_test <- head(default_methods)

  expected <- colnames(demo_data)
  expected[grepl(
    pattern = paste(names(mthds_to_test), collapse = "|"),
    x = expected
  )] <- paste0(
    "raw_",
    expected[grepl(
      pattern = paste(names(mthds_to_test), collapse = "|"),
      x = expected
    )]
  )

  expected <- c(
    expected,
    paste0("std_", names(mthds_to_test))
  )

  expect_equal(
    colnames(add_standardized_scores(
      demo_data,
      rename_raw_scores = T,
      methods = mthds_to_test,
      print_messages = F
    )),
    expected
  )
})
