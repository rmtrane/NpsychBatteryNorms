test_that("values_to_labels", {
  expect_identical(
    values_to_labels(raw_score = c(1, 2), var_name = "SEX"),
    factor(c("Male", "Female"), levels = c("Male", "Female"))
  )

  expect_identical(
    values_to_labels(raw_score = c(1, 2, 1), var_name = "SEX"),
    factor(c("Male", "Female", "Male"), levels = c("Male", "Female"))
  )

  expect_error(
    values_to_labels(raw_score = c("m"), var_name = "SEX")
  )

  expect_error(
    values_to_labels(raw_score = c(1), var_name = "sex")
  )
})
