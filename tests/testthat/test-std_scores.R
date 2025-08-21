test_that("std_scores works", {
  cur_coefs <- subset(
    reg_coefs$updated_2024.06,
    var_name == "TRAILA" &
      !is.na(age) &
      !is.na(sex) &
      !is.na(race) &
      !is.na(education) &
      is.na(delay)
  )[, c("intercept", "age", "sex", "education", "race", "rmse")]

  expected_1 <- -(17 - as.numeric(cur_coefs[-6]) %*% c(1, 65, 1, 14, 1))[[1]] /
    cur_coefs$rmse

  expect_equal(
    std_scores(
      raw_scores = 17,
      var_name = "TRAILA",
      education = 14,
      age = 65,
      sex = "f",
      delay = NULL,
      race = "Other",
      method = "regression",
      version = "updated_2024.06"
    ),
    expected_1
  )

  cur_coefs <- subset(
    reg_coefs$updated_2024.06,
    var_name == "TRAILA" &
      !is.na(age) &
      !is.na(sex) &
      is.na(race) &
      !is.na(education) &
      is.na(delay)
  )[, c("intercept", "age", "sex", "education", "rmse")]

  expected_2 <- -(17 - as.numeric(cur_coefs[-5]) %*% c(1, 65, 1, 14))[[1]] /
    cur_coefs$rmse

  expect_equal(
    std_scores(
      raw_scores = 17,
      var_name = "TRAILA",
      education = 14,
      age = 65,
      sex = "f",
      delay = NULL,
      race = NA,
      method = "regression",
      version = "updated_2024.06"
    ),
    expected_2
  )

  expect_equal(
    std_scores(
      raw_scores = c(17, 17),
      var_name = "TRAILA",
      education = c(14, 14),
      age = c(65, 65),
      sex = c("f", "f"),
      delay = NULL,
      race = c("Other", NA),
      method = "regression",
      version = "updated_2024.06"
    ),
    c(expected_1, expected_2)
  )
})
