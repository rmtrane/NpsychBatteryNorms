#' Regression Coefficients for Regression Based Standardization
#'
#' Regression coefficients used to obtain standardized scores using regression
#' based models adjusting for sex, age, and years of education.
#'
#' @format A named list with two entries: `nacc` including the regression
#'   coefficients published by NACC and implemented in the norms-calculator
#'   spreadsheet available at https://naccdata.org/data-collection/forms-documentation/uds-3,
#'   and `updated` including coefficients from fitting similar models using
#'   the June 2024 data freeze. Each list contains a `tibble` with six columns:
#' \describe{
#'    \item{var_name}{The NACC variable name}
#'    \item{intercept}{The intercept of the model}
#'    \item{sex}{The coefficient corresponding to an indicator indicating female}
#'    \item{age}{The coefficient for age in years}
#'    \item{education}{The coefficient for years of eduation}
#'    \item{rmse}{The estimated standard deviation}
#' }
#'
"reg_coefs"
