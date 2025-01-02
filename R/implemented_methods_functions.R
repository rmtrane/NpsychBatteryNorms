#' Implemented Methods for Specific Variable
#'
#' `implemented_std_methods` gives a table that specifies which method/version
#' is implemented for `var_name`
#'
#' @param var_name a NACC variable to look up implemented methods for.
#'
#' @rdname implemented_methods_functions
#' @export

implemented_std_methods <- function(var_name) {
  out <- data.frame(
    method = c("norms", "norms", "regression", "regression", "T-score"),
    version = c("nacc", "updated", "nacc", "updated", NA),
    available = 0
  )

  for (i in 1:nrow(out)) {
    out$available[i] <- var_name %in% std_methods_implemented_for(out$method[i], out$version[i])
  }

  out
}

#' Variables for which Specific Method is Implemented
#'
#' `std_methods_implemented_for` gives the variables that can be standardized
#' using `method`/`version`.
#'
#' @param method method to look up. One of `norms`, `regression`, or `T-score`
#' @param version version of method to look up. Either `nacc` (indicating the use
#'   of published methods) or `updated` (indicating the use of updated versions
#'   of the published methods, using data available as of June 2024). Ignored if
#'   `method` is `T-score`.
#'
#' @rdname implemented_methods_functions
#'
#' @export
std_methods_implemented_for <- function(method, version) {

  stopifnot("'method' must be one of 'norms', 'regression', or 'T-score'." = method %in% c("norms", "regression", "T-score"))

  if (method == "T-score" & !(missingArg(version) | is.na(version)))
    message("'version' ignored for method 'T-score")

  if (method != "T-score")
    stopifnot("'version' must be one of 'nacc', or 'updated'." = version %in% c("nacc", "updated"))

  if (method == "norms" & version == "nacc")
    return(names(normative_scores_2020))

  if (method == "norms" & version == "updated")
    return(names(normative_scores_2024))

  if (method == "regression" & version == "nacc")
    return(reg_coefs$nacc$var_name)

  if (method == "regression" & version == "updated")
    return(reg_coefs$updated_2024$var_name)

  if (method == "T-score")
    return(names(t_score_coefs))
}
