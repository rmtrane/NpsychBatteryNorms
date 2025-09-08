test_that("add_standardized_scores_dt", {
  expect_error(
    add_standardized_scores_dt(dat = data.frame()),
    regexp = "`dat` must be of class"
  )

  expect_error(
    add_standardized_scores_dt(
      dat = demo_data,
      methods = "test"
    ),
    regexp = "'methods' must be a list"
  )

  expect_error(
    add_standardized_scores_dt(
      dat = demo_data,
      methods = list("test" = "test")
    ),
    regexp = "'methods' must be named with names corresponding to variables to standardize"
  )

  expect_error(
    add_standardized_scores_dt(
      dat = demo_data,
      methods = list("TRAILA" = c("method" = "wrong"))
    ),
    regexp = 'must be one of "norm", "regression", or "T-score"'
  )

  expect_error(
    add_standardized_scores_dt(
      dat = demo_data,
      methods = list("TRAILA" = c(method = "regression", version = "wrong"))
    ),
    regexp = 'must be one of '
  )

  expect_error(
    add_standardized_scores_dt(
      dat = demo_data,
      methods = list(
        "TRAILA" = c(method = "regression", version = "nacc_legacy")
      )
    ),
    regexp = "The methods specified for the following are invalid"
  )

  actual <- add_standardized_scores_dt(
    data.table::data.table(demo_data),
    print_messages = F
  )

  for (var in intersect(names(default_methods), colnames(actual))) {
    tmp <- std_scores(
      raw_scores = valid_values_only(demo_data[[var]], var, T),
      var_name = var,
      education = valid_values_only(demo_data$EDUC, "EDUC", T),
      age = demo_data$NACCAGE,
      sex = c("m", "f")[demo_data$SEX],
      delay = valid_values_only(demo_data$MEMTIME, "MEMTIME", T),
      race = get_race_group(demo_data$RACE),
      method = default_methods[[var]][["method"]],
      version = default_methods[[var]][["version"]],
      print_messages = F
    )

    if (all(is.na(tmp))) {
      tmp <- as.double(tmp)
    }

    attr(tmp, "method") <- default_methods[[var]][["method"]]

    if (attr(tmp, "method") != "T-score") {
      attr(tmp, "version") <- default_methods[[var]][["version"]]
    }

    expect_equal(
      tmp,
      actual[[paste0("std_", var)]]
    )
  }

  expect_message(
    add_standardized_scores_dt(
      data.table::data.table(demo_data),
      print_messages = T
    )
  )

  vars_to_std <- names(default_methods[
    names(default_methods) %in% colnames(demo_data)
  ])

  expect_true(
    all(
      c(paste0("raw_", vars_to_std), paste0("std_", vars_to_std)) %in%
        colnames(
          add_standardized_scores_dt(
            data.table::data.table(demo_data),
            rename_raw_scores = T,
            print_messages = F
          )
        )
    )
  )
})
