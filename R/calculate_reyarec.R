#' Calculate the Rey AVLT Accuracy
#'
#' Calculates accuracy from true positives and false positives, but applies `valid_values_only()`
#' first. As percentage, i.e. a value of 55 means 55%.
#'
#' @param REYTCOR true positives
#' @param REYFPOS false positives
#'
#' @export
calculate_reyarec <- function(
    REYTCOR,
    REYFPOS
) {
  (valid_values_only(REYTCOR, "REYTCOR", T) + 15 - valid_values_only(REYFPOS, "REYFPOS", T)) * 100 / 30
}
