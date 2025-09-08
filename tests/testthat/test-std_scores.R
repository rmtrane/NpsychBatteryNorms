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

  expect_message(
    std_scores(
      raw_scores = 16,
      var_name = "BOSTON",
      education = 14,
      age = 62,
      sex = "f",
      method = "regression",
      version = "nacc"
    ),
    regexp = "BOSTON is a legacy score."
  )

  expect_error(
    std_scores(
      raw_scores = 16,
      var_name = "MEMUNITS",
      education = 14,
      age = 62,
      sex = "f",
      method = "regression",
      version = "nacc"
    ),
    regexp = "'delay' must be a numeric vector"
  )

  expect_message(
    std_scores(
      raw_scores = 16,
      var_name = "ANIMALS",
      education = 35,
      age = 62,
      sex = "f",
      method = "regression",
      version = "nacc"
    ),
    regexp = "Values outside this range have been truncated."
  )

  expect_error(
    std_scores(
      raw_scores = 16,
      var_name = "ANIMALS",
      education = 14,
      age = 62,
      sex = "f",
      method = "regression",
      version = "nacc_legacy"
    ),
    regexp = "cannot be standardized using regression \\(nacc_legacy\\)"
  )

  expect_equal(
    std_scores(
      raw_scores = rep(NA, 100)
    ),
    rep(NA, 100)
  )

  expect_error(
    std_scores(
      raw_scores = c(1, 2, 6),
      var_name = 1
    )
  )

  expect_error(
    std_scores(
      raw_scores = c(1, 2, 6),
      var_name = c("ANIMALS", "VEG")
    )
  )

  expect_error(
    std_scores(
      raw_scores = c(1, 2, 6),
      var_name = "ANIMALS",
      method = c("regression", "norms")
    )
  )

  expect_error(
    std_scores(
      raw_scores = c(1, 2, 6),
      var_name = "ANIMALS",
      method = "test"
    )
  )

  expect_error(
    std_scores(
      raw_scores = "A",
      var_name = "ANIMALS",
      method = "regression"
    )
  )

  expect_message(
    std_scores(
      raw_scores = "2",
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      version = "nacc"
    ),
    regexp = "it was successfully converted"
  )

  expect_error(
    std_scores(
      raw_scores = "2a",
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      version = "nacc"
    ),
    regexp = "could not be converted"
  )

  expect_error(
    std_scores(
      raw_scores = "",
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      version = "nacc"
    ),
    regexp = "failed"
  )

  expect_message(
    std_scores(
      raw_scores = 2,
      var_name = "ANIMALS",
      method = "T-score",
      education = 14,
      age = 52,
      sex = "f",
      version = "nacc"
    ),
    regexp = "'version' is ignored for T-score"
  )

  expect_message(
    std_scores(
      raw_scores = 2,
      var_name = "ANIMALS",
      method = "T-score",
      education = 6,
      age = 52,
      sex = "f",
      version = NA
    ),
    regexp = "For T-scores, education must be"
  )

  expect_message(
    std_scores(
      raw_scores = 2,
      var_name = "ANIMALS",
      method = "T-score",
      education = 8,
      age = 28,
      sex = "f",
      version = NA
    ),
    regexp = "For T-scores, age must be"
  )

  expect_equal(
    std_scores(
      raw_scores = c(2, 5),
      var_name = "ANIMALS",
      method = "T-score",
      education = c(6, 8),
      age = c(52, 29),
      sex = c("f", "f"),
      version = NA
    ),
    std_scores(
      raw_scores = c(2, 5),
      var_name = "ANIMALS",
      method = "T-score",
      education = c(8, 8),
      age = c(52, 30),
      sex = c("f", "f"),
      version = NA
    )
  )

  expect_error(
    std_scores(
      raw_scores = 2,
      var_name = "ANIMALS",
      education = 14,
      age = 52,
      sex = "f",
      method = "norms",
      version = "ravlt_trials"
    ),
    regexp = "ANIMALS is not a valid variable for norms \\(ravlt_trials\\)"
  )

  expect_equal(
    std_scores(
      raw_scores = 2,
      var_name = "ANIMALS",
      education = 14,
      age = 52,
      sex = "f",
      method = "norms",
      version = "nacc"
    ),
    std_scores_using_norms(
      raw_scores = 2,
      var_name = "ANIMALS",
      education = 14,
      age = 52,
      sex = "f",
      m_sd = normative_summaries$nacc$ANIMALS
    )
  )

  expect_equal(
    std_scores(
      raw_scores = 25,
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      race = NA,
      delay = NA,
      version = "updated_2025.06"
    ),
    std_scores(
      raw_scores = 25,
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      version = "updated_2025.06"
    )
  )

  expect_equal(
    std_scores(
      raw_scores = 25,
      var_name = "ANIMALS",
      method = "regression",
      education = 14,
      age = 52,
      sex = "f",
      race = NA,
      delay = NA,
      version = "updated_2025.06"
    ),
    std_scores_using_regression(
      raw_scores = 25,
      var_name = "ANIMALS",
      reg_coefs = unlist(subset(
        reg_coefs$updated_2025.06,
        var_name == "ANIMALS" &
          is.na(race) &
          is.na(delay) &
          !is.na(age) &
          !is.na(education) &
          !is.na(sex)
      )[, c(
        "intercept",
        "sex",
        "age",
        "education"
      )]),
      age = 52,
      education = 14,
      sex = "f",
      race = 0,
      delay = 0,
      sd = subset(
        reg_coefs$updated_2025.06,
        var_name == "ANIMALS" &
          is.na(race) &
          is.na(delay) &
          !is.na(age) &
          !is.na(education) &
          !is.na(sex)
      )$rmse
    )
  )
})
