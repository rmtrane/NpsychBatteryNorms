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
  ## If all raw_scores are NA, return a vector of NAs
  if (all(is.na(raw_scores))) {
    return(rep(NA, length(raw_scores)))
  }

  ## Check 'var_name' argument.
  if (!is.character(var_name) || length(var_name) != 1) {
    cli::cli_abort(
      message = "'var_name' must be a single string, not a vector of class {class(var_name)}."
    )
  }

  ## Check that 'method' is valid
  if (length(method) != 1) {
    cli::cli_abort(
      message = "'method' must be a single string, not a vector of length {length(method)}."
    )
  } else if (!method %in% c("norms", "regression", "T-score")) {
    cli::cli_abort(
      message = "'method' must be one of 'norms', 'regression', or 'T-score', not {method}."
    )
  }

  ## Check that 'raw_scores' is numeric, or if not, that it can be converted to numeric.
  if (!is.numeric(raw_scores)) {
    digits_only <- grepl("^[0-9]*\\.?[0-9]*$", na.omit(raw_scores), perl = TRUE)

    ## If any entries flagged as containing non-digit characters, abort with error message.
    if (!all(digits_only)) {
      cli::cli_abort(
        message = "'raw_scores' for {var_name} must be a numeric vector. You provided a vector of class {class(raw_scores)}, which contains some non-digit characters, and therefore could not be converted."
      )
    }

    ## Convert to numeric
    raw_scores_numeric <- as.numeric(raw_scores)

    ## Check that no values were converted to NA
    if (sum(is.na(raw_scores)) == sum(is.na(raw_scores_numeric))) {
      cli::cli_alert_warning(
        text = "'raw_scores' for {var_name} must be a numeric vector. You provided a {class(raw_scores)}, but it was successfully converted to numeric."
      )

      raw_scores <- raw_scores_numeric
    } else {
      cli::cli_abort(
        message = "'raw_scores' for {var_name} must be a numeric vector. You provided a vector of class {class(raw_scores)}. No non-digit characters were found, but converting to numeric using `as.numeric` failed."
      )
    }
  }

  ## Replace anything that is not a valid score with NA
  raw_scores <- valid_values_only(raw_scores, var_name, remove_errorcodes = T)

  ## Get min and max of education, age
  min_educ <- min(education, na.rm = T)
  max_educ <- max(education, na.rm = T)

  min_age <- min(age, na.rm = T)
  max_age <- max(age, na.rm = T)

  if (method == "T-score") {
    ## Check that 'version' is valid
    if (!is.na(version) & print_messages) {
      cli::cli_alert_info("'version' is ignored for T-score")
    }

    ## If education is outside of range, truncate it
    if (min_educ < 8 | max_educ > 20) {
      if (print_messages) {
        cli::cli_alert_warning(
          "For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated."
        )
      }

      education <- pmin(pmax(education, 8), 20)
    }

    ## If age is outside of range, truncate it
    if (min_age < 30 | max_age > 91) {
      if (print_messages) {
        cli::cli_alert_warning(
          "For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated."
        )
      }

      age <- pmin(pmax(age, 30), 91)
    }

    out <- std_scores_using_T(
      raw_scores,
      var_name,
      age,
      education,
      sex
    )
  }

  if (method == "norms") {
    ## Check that 'version' is valid for 'var_name'
    if (!var_name %in% names(normative_summaries[[version]])) {
      cli::cli_abort(
        "{var_name} is not a valid variable for {method} ({version}). Use {.code std_methods(var_name = {var_name})} to get all available methods."
      )
    }

    if (min_educ < 0 | max_educ > 31) {
      education <- pmin(pmax(education, 0), 31)

      if (print_messages) {
        cli::cli_alert_warning(
          "For regression based standardization, education must be a numeric vector of values between 0 and 31. Values outside this range have been truncated."
        )
      }
    }

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
    ## Check that 'version' is valid
    if (!var_name %in% reg_coefs[[version]]$var_name) {
      if (version == "nacc" && var_name %in% reg_coefs$nacc_legacy$var_name) {
        cli::cli_alert_info(
          "{var_name} is a legacy score. Regression model published by Weintraub et. al (2009) used (links to resources can be found at {.url https://naccdata.org/data-collection/forms-documentation/uds-2})"
        )

        version <- "nacc_legacy"
      } else {
        cli::cli_abort(
          "{var_name} cannote be standardized using {method} ({version}). Use {.code std_methods(var_name = {var_name})} to get all available methods."
        )
      }
    }

    coefs_to_use <- reg_coefs[[version]][
      reg_coefs[[version]]$var_name == var_name,
      c("intercept", "sex", "age", "education", "delay", "rmse")
    ]
    coefs_to_use <- unlist(coefs_to_use)

    if (coefs_to_use["delay"] != 0) {
      stopifnot("'delay' must be a numeric vector" = is.numeric(delay))
    } else {
      delay <- rep(0, length(sex))
    }
    # }

    # if (version == "updated") {
    #   stopifnot(
    #     "'var_name' is not a valid string. See 'reg_coefs$updated$var_name' for list of allowed strings" = any(
    #       var_name == reg_coefs$updated$var_name
    #     )
    #   )

    #   coefs_to_use <- reg_coefs$updated[
    #     reg_coefs$updated$var_name == var_name,
    #     c("intercept", "sex", "age", "education", "delay", "rmse")
    #   ]
    #   coefs_to_use <- unlist(coefs_to_use)
    # }

    if (min_educ < 0 | max_educ > 31) {
      education <- pmin(pmax(education, 0), 31)

      cli::cli_alert_warning(
        "For regression based standardization, education must be a numeric vector of values between 0 and 31. Values outside this range have been truncated."
      )
    }

    out <- std_scores_using_regression(
      raw_scores,
      var_name = var_name,
      reg_coefs = coefs_to_use[c(
        "intercept",
        "sex",
        "age",
        "education",
        "delay"
      )],
      age,
      education,
      delay,
      sex = as.numeric(sex == "f"),
      sd = coefs_to_use[["rmse"]]
    )
  }

  out
}
