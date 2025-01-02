#' Regression Coefficients for T-score Based Standardization
#'
#' Regression coefficients used to obtain standardized scores using T-scores.
#'
#' @format A named list with one entry for each NACC variable for which T-scores
#'   have been implemented. Each entry contains the coefficients needed for the
#'   corresponding model. This is a subset of `intercept`, `age`, `age^2`, `sex`,
#'   `education`, `intercept2`, `sd`, `intercept3`, `education^0.5`, `age^2_2`.
#' @references The coefficients implemented here are published in the following two
#'   articles:
#'   - \insertRef{strickerMayoNormativeStudies2021}{NpsychBatteryNorms}
#'   - \insertRef{karstensMayoNormativeStudies2023}{NpsychBatteryNorms}
"t_score_coefs"
