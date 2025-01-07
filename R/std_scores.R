#' Standardize Raw Cognitive Scores to Z-Scores
#'
#' Calculate z-scores as `(raw score - average) / sd`. Available for a wide array
#' of cognitive scores both using normative data, and regression based models. A
#' wrapper around `std_scores_using_norms()`, `std_scores_using_regression()` and
#' `std_scores_using_T()`.
#'
#' @param raw_scores Numeric vector of raw scores
#' @param var_name String with name of the variable. Used to get correct means and standard deviations, or regression coefficients.
#' @param education Numeric vector with years of education. Used for subset of variables only.
#' @param age Numeric vector with ages in years
#' @param sex Character vector with sex of participants. Must be either "m" (for male) or "f" (for female). Used for subset of variables only
#' @param delay Only for standardizing `MEMUNITS` ("Logical Memory, Delayed") in which case it is the time of delay in minutes
#' @param method String specifying method to use for standardization.
#' @param version String specifying version to use. "nacc" = 2020 numbers
#'   published by NACC. "updated" = numbers calculated using data freeze from
#'   June of 2024.
#' @param print_messages Logical (default: TRUE); should messages be printed? 
#'
#' @examples
#' std_scores(
#'   raw_scores = c(21, 15),
#'   var_name = "MOCATOTS",
#'   sex = c("m", "f"),
#'   age = c(57, 70),
#'   education = c(15, 13),
#'   method = "regression",
#'   version = "nacc"
#' )
#'
#' @export

std_scores <- function(
    raw_scores,
    var_name,
    education,
    age,
    sex = c("m", "f"),
    delay = NULL,
    method = c("norms", "regression", "T-score"),
    version = c("nacc", "updated"),
    print_messages = T
) {

  stopifnot("'raw_scores' must be a numeric vector" = is.numeric(raw_scores))

  stopifnot("'method' must be length 1" = length(method) == 1)
  stopifnot("'method' must be one of 'norms', 'regression', or 'T-score'" = any(method == c("norms", "regression", "T-score")))

  stopifnot("'var_name' must be a string" = is.character(var_name))
  stopifnot("'var_name' must have length 1" = length(var_name) == 1)

  ## Replace anything that is not a valid score with NA
  raw_scores <- valid_values_only(raw_scores, var_name, remove_errorcodes = T)

  ## Get min and max of education, age
  min_educ <- min(education, na.rm = T)
  max_educ <- max(education, na.rm = T)

  min_age <- min(age, na.rm = T)
  max_age <- max(age, na.rm = T)

  if (method == "T-score") {
    if (!is.na(version) & print_messages)
      message("'version' is ignored for T-score")

    if (min_educ < 8 | max_educ > 20) {
      if (print_messages)
        message("For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.")

      education <- pmin(pmax(education, 8), 20)
    }

    if (min_age < 30 | max_age > 91) {
      if (print_messages)
        message("For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.")

      age <- pmin(pmax(age, 30), 91)
    }

    out <- std_scores_using_T(
      raw_scores,
      var_name,
      age,
      education,
      sex
    )

  } else {
    stopifnot("'version' must be length 1" = length(version) == 1)
    stopifnot("'version' must be one of 'nacc' or 'updated" = version %in% c("nacc", "updated"))
  }

  if (method == "norms") {
    stopifnot("Education must be a numeric vector of values between 0 and 31" =
                min_educ >= 0 & max_educ <= 31
    )

    stopifnot("'var_name' is not valid for selected normative version" = 
      any(var_name == names(normative_summaries[[version]])))

    means_and_sds <- normative_summaries[[version]][[var_name]]
    
    out <- std_scores_using_norms(
      raw_scores,
      var_name,
      education,
      age,
      sex,
      means_and_sds
    )
  }

  if (method == "regression") {
    stopifnot("Education must be a numeric vector of values between 0 and 31" =
                min_educ >= 0 & max_educ <= 31)

    if (version == "nacc") {
      stopifnot("'var_name' is not a valid string. See 'nacc_reg$nacc$var_name' for list of allowed strings" =
                  any(var_name == reg_coefs$nacc$var_name))

      coefs_to_use <- reg_coefs$nacc[reg_coefs$nacc$var_name == var_name, c("intercept", "sex", "age", "education", "delay", "rmse")]
      coefs_to_use <- unlist(coefs_to_use)

      if (coefs_to_use['delay'] != 0) {
        stopifnot("'delay' must be a numeric vector" = is.numeric(delay))
      } else {
        delay <- rep(0, length(sex))
      }
    }

    if (version == "updated") {
      stopifnot("'var_name' is not a valid string. See 'reg_coefs$updated_2024$var_name' for list of allowed strings" =
                  any(var_name == reg_coefs$updated_2024$var_name))

      coefs_to_use <- reg_coefs$updated_2024[reg_coefs$updated_2024$var_name == var_name, c("intercept", "sex", "age", "education", "delay", "rmse")]
      coefs_to_use <- unlist(coefs_to_use)
    }

    out <- std_scores_using_regression(
      raw_scores,
      var_name = var_name,
      reg_coefs = coefs_to_use[c("intercept", "sex", "age", "education", "delay")],
      age,
      education,
      delay,
      sex = as.numeric(sex == "f"),
      sd = coefs_to_use[["rmse"]]
    )

  }

  out

}



