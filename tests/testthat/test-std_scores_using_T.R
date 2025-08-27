test_that("std_scores_using_T", {
  expect_equal(
    std_scores_using_T(
      raw_scores = 52,
      var_name = "VEG",
      age = 62,
      education = 14,
      sex = "m"
    ),
    50 +
      (c(
        get_ss_score(52, "VEG") -
          c(1, 62, 62^2, 1, 14) %*%
            t_score_coefs$VEG[c(
              "intercept",
              "age",
              "age^2",
              "sex",
              "education"
            )]
      ) /
        c(
          c(1, 62^2, sqrt(14)) %*%
            t_score_coefs$VEG[c("intercept3", "age^2_2", "education^0.5")]
        ) -
        t_score_coefs$VEG[["intercept2"]]) /
        t_score_coefs$VEG[["sd"]]
  )
})
