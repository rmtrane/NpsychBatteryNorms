#' Get Scaled Scores for use in T-score cacluations
#'
#' Helper function to look up unadjusted scaled scores in the [`ss`] list
#' for use in the fully adjusted T-scores.
#'
#' @param raw_score numeric vector with raw scores
#' @param var_name string indicating what variable
#'
#' @export
get_ss_score <- function(
  raw_score,
  var_name
) {
  stopifnot("'var_name' must be one of the entries of 'nacc_to_mns'. See 'names(nacc_to_mns)' for values allowed." = sum(var_name == names(nacc_to_mns)) == 1)
  stopifnot("'raw_score' must be numeric" = is.numeric(raw_score))

  out <- valid_values_only(raw_score, var_name, remove_errorcodes = T)

  ## Only change non-NA values to speed up things
  out[!is.na(out)] <- ss[[nacc_to_mns[[var_name]]]][as.character(out[!is.na(out)])]

  unname(out)
}
