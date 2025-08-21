#' Standardize Raw Cognitive Scores using Regression Models
#'
#' @description
#' Get normative scores by standardizing using regression models adjusting for
#' one or all of age, sex and education.
#'
#' # Normative Scores from Regression Model
#'
#' In general, we standardize scores by subtracting an estimate of the (possibly
#' conditional) expected value of the variable considered, and divide the
#' difference by an estimate of the (possibly conditional) standard deviation.
#'
#' When we aim to do this using a regression model that adjusts for age, sex,
#' and years of education, we find the conditional expected value as
#'
#' \deqn{
#' \mu = \beta_0 + \beta_{age} \cdot \verb|age| +
#' \beta_{education} \cdot \verb|education| +
#' \beta_{sex} \cdot \verb|sex|
#' }
#'
#' where \eqn{\verb|sex|} is \eqn{1} if the patient is female, and \eqn{0}
#' otherwise. `std_scores_using_regression` takes the coefficients in a named
#' vector \eqn{\verb|c(intercept = |\beta_0\verb|, age = |\beta_{age}\verb|, education = |\beta_{education}\verb|, sex = |\beta_{sex}\verb|)|}.
#'
#' The normative score is then given as \eqn{\verb|(raw_scores - |\mu\verb|)/sd|},
#' where `sd` is the estimated standard deviation passed to the `sd` argument.
#' This will typically be the root mean squared error (RMSE) from the linear
#' regression model.
#'
#' One final caveat: for consistency, we "flip the sign" for normative scores
#' where higher raw score values correspond to worse performance. This is the
#' case for the trail making scores (both written and oral) related to time and
#' number of errors.
#'
#' @inheritParams std_scores
#' @param reg_coefs named vector with coefficients to be used for calculating
#'   expected score. Can include the following named entries:
#'   - `intercept`
#'   - `age`
#'   - `education`
#'   - `sex`
#'   - `race`
#'   - `delay`
#' @param sd estimated standard deviation
#'
#' @export
std_scores_using_regression <- function(
  raw_scores,
  var_name,
  reg_coefs,
  age,
  education,
  sex,
  race,
  delay,
  sd
) {
  stopifnot("'reg_coefs' must be numeric" = is.numeric(reg_coefs))
  stopifnot(
    "'reg_coefs' must be of length between 1 and 6" = length(reg_coefs) %in% 1:6
  )

  if ("educ" %in% names(reg_coefs)) {
    names(reg_coefs)[names(reg_coefs) == "educ"] <- "education"
  }

  stopifnot(
    "'reg_coefs' must be named with allowed names being 'intercept', 'age', 'education', 'sex', 'race', and 'delay'" = all(
      names(reg_coefs) %in%
        c('intercept', 'age', 'education', 'sex', 'race', 'delay')
    )
  )

  stopifnot("'raw_scores' must be numeric" = is.numeric(raw_scores))
  stopifnot("'age' must be numeric" = is.numeric(age))

  stopifnot(
    "'raw_scores', 'sex', 'education', 'age', 'race', and 'delay' must all have the same length" = length(unique(c(
      length(raw_scores),
      length(age),
      length(education),
      length(sex),
      length(race),
      length(delay)
    ))) ==
      1
  )

  coefs <- c(
    "intercept" = 0,
    "age" = 0,
    "education" = 0,
    "sex" = 0,
    "race" = 0,
    "delay" = 0
  )
  coefs[names(reg_coefs)] <- reg_coefs

  stopifnot(
    "'sex' must either be a character vector of 'f' and 'm', or a numeric
            vector of 1 (female) and 0 (male)" = (is.numeric(sex) &
      all(unique(sex) %in% c(0, 1, NA))) |
      (is.character(sex) & all(unique(sex) %in% c("f", "m", NA)))
  )

  if (is.character(sex)) {
    sex <- as.numeric(sex == "f")
  }

  est_mean <- c(cbind(1, age, education, sex, race, delay) %*% coefs)

  # Get standardized scores. If either time or error, return negative value so
  # that higher is always better.
  if (
    var_name %in%
      c("TRAILA", "TRAILB", "OTRAILA", "OTRAILB", "OTRLARR", "OTRLBRR")
  ) {
    return(-(raw_scores - est_mean) / sd)
  }

  (raw_scores - est_mean) / sd
}
