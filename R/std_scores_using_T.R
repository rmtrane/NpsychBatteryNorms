#' Standardized Scores using T-scores
#'
#' @inheritParams std_scores
#'
#' @export

std_scores_using_T <- function(
  raw_scores,
  var_name,
  age,
  education,
  sex
) {
  stopifnot(
    "T-scores not available for 'var_name'. See 'names(t_score_coefs)' for available variables" = var_name %in%
      names(t_score_coefs)
  )

  stopifnot("'raw_scores' must be numeric" = is.numeric(raw_scores))
  stopifnot(
    "'sex' must either be a character vector of 'f' and 'm', or a numeric
            vector of 1 (male) and 0 (female)" = (is.numeric(sex) &
      all(unique(sex) %in% c(0, 1, NA))) |
      (is.character(sex) & all(unique(sex) %in% c("f", "m", NA)))
  )
  stopifnot("'age' must be numeric" = is.numeric(age))
  stopifnot("'education' must be numeric" = is.numeric(education))

  if (length(raw_scores) > 1) {
    if (length(sex) == 1) {
      sex <- rep(sex, length(raw_scores))
    }
    if (length(age) == 1) {
      age <- rep(age, length(raw_scores))
    }
    if (length(education) == 1) {
      education <- rep(education, length(raw_scores))
    }
  }

  stopifnot(
    "'raw_scores', 'sex', 'education', and 'age' must all have the same length" = length(unique(c(
      length(raw_scores),
      length(age),
      length(education),
      length(sex)
    ))) ==
      1
  )

  if (is.character(sex)) {
    sex <- as.numeric(sex == "m")
  }

  coefs_to_use <- t_score_coefs[[var_name]]

  unadj_ss <- get_ss_score(round(raw_scores), var_name)

  if ("intercept3" %in% names(coefs_to_use)) {
    T_scores <- 50 +
      (((unadj_ss -
        (coefs_to_use[["intercept"]] +
          age * coefs_to_use[["age"]] +
          age^2 * coefs_to_use[["age^2"]] +
          sex * coefs_to_use[["sex"]] +
          education * coefs_to_use[["education"]])) /
        (coefs_to_use[["intercept3"]] +
          age^2 * coefs_to_use[["age^2_2"]] +
          sqrt(education) * coefs_to_use[["education^0.5"]]) -
        coefs_to_use[["intercept2"]]) /
        coefs_to_use[["sd"]])
  } else {
    T_scores <- 50 +
      (((unadj_ss -
        (coefs_to_use[["intercept"]] +
          age * coefs_to_use[["age"]] +
          age^2 * coefs_to_use[["age^2"]] +
          sex * coefs_to_use[["sex"]] +
          education * coefs_to_use[["education"]])) -
        coefs_to_use[["intercept2"]]) /
        coefs_to_use[["sd"]])
  }

  T_scores
}
