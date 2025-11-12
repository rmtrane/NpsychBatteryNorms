test_that("methods_from_std_data", {
  std_data <- add_standardized_scores(head(demo_data))

  actual_methods <- methods_from_std_data(std_data)

  expected_def_meths <- default_methods[
    names(default_methods) %in% colnames(demo_data)
  ]

  expected_def_meths <- lapply(
    expected_def_meths,
    \(x) c(na.omit(x))
  )

  expect_equal(
    actual_methods,
    expected_def_meths
  )

  expect_equal(
    methods_from_std_data(
      std_data,
      std_cols = "std_ANIMALS"
    ),
    list(
      ANIMALS = c(method = "regression", version = "updated_2025.06")
    )
  )
})
