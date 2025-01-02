#' Scaled Scores lookup tables from Mayo Normative Studies
#'
#' Scaled scores from Mayo Normative Studies for a variety of variables. To get
#' a list of all variables, run `names(ss)`. Note, these names refer to variable
#' names in the Mayo Normative Study.
#'
#' # Scaled Scores
#'
#' Scaled scores are used in the calculation of T-scores. In short, the T-scores
#' are based on a regression model that fits the scaled scores as a function of
#' sex, age, and years of education (with some second order terms). The purpose
#' of the scaled scores is to force the data to be more normal looking. For more
#' details, see \insertRef{karstensMayoNormativeStudies2023}{NpsychBatteryNorms}.
#'
#' @format A named list of named vectors such that `ss$var_name[["raw_score"]]`
#'   gives the scaled score for the variable `var_name` corresponding to a
#'   raw score of `raw_score`.
#'
#' @references \insertRef{karstensMayoNormativeStudies2023}{NpsychBatteryNorms}
"ss"
