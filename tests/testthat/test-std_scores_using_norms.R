test_that("std_scores_using_norms", {
  expect_error(
    std_scores_using_norms("A")
  )

  expect_error(
    std_scores_using_norms(
      raw_scores = 12,
      var_name = 1
    )
  )

  expect_error(
    std_scores_using_norms(
      raw_scores = 12,
      var_name = c("ANIMALS", "VEG")
    )
  )

  set.seed(1010101)

  var_name <- "ANIMALS"
  educ <- 14
  age <- 63
  s <- "m"
  raw_scores <- 0:77

  expect_equal(
    std_scores_using_norms(
      raw_scores = raw_scores,
      var_name = var_name,
      education = rep(educ, length(raw_scores)),
      age = rep(age, length(raw_scores)),
      sex = rep(s, length(raw_scores)),
      m_sd = normative_summaries$nacc[[var_name]]
    ),
    with(
      subset(
        normative_summaries$nacc[[var_name]],
        age_group == get_age_group(age, group_type = "nacc") &
          edu_group == get_educ_group(educ) &
          sex == s
      ),
      (raw_scores - m) / sd
    )
  )

  var_name <- "REYTOTAL"
  raw_scores <- 0:75

  expect_equal(
    std_scores_using_norms(
      raw_scores = raw_scores,
      var_name = var_name,
      education = rep(educ, length(raw_scores)),
      age = rep(age, length(raw_scores)),
      sex = rep(s, length(raw_scores)),
      m_sd = normative_summaries$ravlt_trials[[var_name]]
    ),
    with(
      subset(
        normative_summaries$ravlt_trials[[var_name]],
        age_group == get_age_group(age, group_type = "ravlt_trials")
      ),
      (raw_scores - m) / sd
    )
  )

  var_name <- "TRAILA"
  raw_scores <- 0:150

  expect_equal(
    std_scores_using_norms(
      raw_scores = raw_scores,
      var_name = var_name,
      education = rep(educ, length(raw_scores)),
      age = rep(age, length(raw_scores)),
      sex = rep(s, length(raw_scores)),
      m_sd = normative_summaries$nacc[[var_name]]
    ),
    with(
      subset(
        normative_summaries$nacc[[var_name]],
        age_group == get_age_group(age, group_type = "nacc") &
          edu_group == get_educ_group(educ) &
          sex == s
      ),
      -(raw_scores - m) / sd
    )
  )

  expect_equal(
    std_scores_using_norms(
      raw_scores = raw_scores,
      var_name = var_name,
      education = educ,
      age = age,
      sex = s,
      m_sd = normative_summaries$nacc[[var_name]]
    ),
    std_scores_using_norms(
      raw_scores = raw_scores,
      var_name = var_name,
      education = rep(educ, length(raw_scores)),
      age = rep(age, length(raw_scores)),
      sex = rep(s, length(raw_scores)),
      m_sd = normative_summaries$nacc[[var_name]]
    )
  )
})
