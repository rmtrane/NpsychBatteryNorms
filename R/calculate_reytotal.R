#' Calculate Rey AVLT Total score
#'
#' @description
#' Sum of REY1REC, ..., REY5REC, but applies [valid_values_only()] before
#' adding values. This removes any values not between 0 and 15.
#'
#' @param REY1REC values for RAVLT Trial 1 total recall
#' @param REY2REC values for RAVLT Trial 2 total recall
#' @param REY3REC values for RAVLT Trial 3 total recall
#' @param REY4REC values for RAVLT Trial 4 total recall
#' @param REY5REC values for RAVLT Trial 5 total recall
#'
#' @export
calculate_reytotal <- function(REY1REC, REY2REC, REY3REC, REY4REC, REY5REC) {
  valid_values_only(REY1REC, "REY1REC", T) +
    valid_values_only(REY2REC, "REY2REC", T) +
    valid_values_only(REY3REC, "REY3REC", T) +
    valid_values_only(REY4REC, "REY4REC", T) +
    valid_values_only(REY5REC, "REY5REC", T)
}