#' Calculate the Rey AVLT Accuracy
#'
#' Calculates accuracy from true positives and false positives, but applies `valid_values_only()`
#' first.
#'
#' @param REYTCOR true positives
#' @param REYFPOS false positives
#'
#' @export
calculate_reyarec <- function(
    REYTCOR,
    REYFPOS
) {
  (valid_values_only(REYTCOR, "REYTCOR", T) + 15 - valid_values_only(REYFPOS, "REYFPOS", T)) / 30
}
