testthat::test_that("std_scores_using_regression", {

  cfs <- c(intercept = 1, age = 1, sex = 1, education = 1)

  expect_equal(
    std_scores_using_regression(
      c(21, 21),
      "MOCATOTS",
      reg_coefs = cfs,
      age = c(50, 50),
      education = c(15, 15),
      sex = c("m", "f"),
      sd = 1,
      delay = c(0,0)
    ),
    (21 - (1 + 50 + 15 + c(0,1)))/1
  )

  ## Test UDS 2 scores using excel template
  # Setup test tibble
  test_tibble <- data.frame(
    NACCID = "NACC929325",
    NACCAGE = 80,
    EDUC = 12,
    SEX = "f",
    NACCMMSE = 27,
    BOSTON = 25,
    LOGIMEM = 7,
    MEMUNITS = 6,
    MEMTIME = 35,
    DIGIF = 6,
    DIGIFLEN = 5,
    DIGIB = 4,
    DIGIBLEN = 3
  )

  exp_res_tibble <- data.frame(
    NACCMMSE = -0.837,
    BOSTON = -0.346,
    LOGIMEM = -1.242,
    MEMUNITS = -0.922,
    DIGIF = -0.980,
    DIGIFLEN = -1.341,
    DIGIB = -0.910,
    DIGIBLEN = -1.207
  )

  for (var in colnames(exp_res_tibble)) {
    expect_equal(
      std_scores_using_regression(
        test_tibble[[var]],
        var_name = var,
        reg_coefs = unlist(reg_coefs$nacc[reg_coefs$nacc$var_name == var, c("intercept", "sex", "age", "education", "delay")]),
        age = test_tibble$NACCAGE,
        education = test_tibble$EDUC,
        sex = test_tibble$SEX,
        delay = test_tibble$MEMTIME,
        sd = unname(unlist(reg_coefs$nacc[reg_coefs$nacc$var_name == var, "rmse"]))
      ) |> round(digits = 3),
      exp_res_tibble[[var]]
    )
  }


})
