#' Explore Implemented Methods and Combination with Variables
#' 
#' Helper function to find implemented methods for specific variable, or find variables that can be standardized using specific method/version combo.
#' 
#' @param var_name NACC variable name for which to return available method/version combos (much be omitted if method/version specified)
#' @param method method to look up. Must be one of `norms`, `regression`, or `T-score`
#' @param version version of method to look up. Either `nacc` (indicating the use of published methods) or `updated` (indicating the use of updated versions of the published methods, using data available as of June 2024). Ignored if method is `T-score`.
#' 
#' @export
std_methods <- function(var_name, method, version) {
  if (!missingArg(var_name)) {
    stopifnot("Both method and version must be omitted when var_name provided" =
      missingArg(method) & missingArg(version)
    )
  
  out <- data.frame(
    method = c("norms", "norms", "regression", "regression", "T-score"),
    version = c("nacc", "updated", "nacc", "updated", NA),
    available = 0
  )
  
  out$available <- as.numeric(c(
    var_name %in% names(normative_summaries$nacc),
    var_name %in% names(normative_summaries$updated),
    var_name %in% reg_coefs$nacc$var_name,
    var_name %in% reg_coefs$updated_2024$var_name,
    var_name %in% names(t_score_coefs)
  ))
  
  return(out)
  
  } else {
    stopifnot("Must provide both method and version when var_name is not provided" = 
      !missingArg(method) & !missingArg(version)
    )
    
    stopifnot("'method' must be one of 'norms', 'regression', or 'T-score'." = method %in% c("norms", "regression", "T-score"))

    if (method == "T-score" & !(missingArg(version) | is.na(version)))
      message("'version' ignored for method 'T-score")

    if (method != "T-score")
      stopifnot("'version' must be one of 'nacc', or 'updated'." = version %in% c("nacc", "updated"))

    # if (method == "norms" & version == "nacc")
    #   return(names(normative_scores_2020))

    # if (method == "norms" & version == "updated")
    #   return(names(normative_scores_2024))

    if (method == "norms")
      return(names(normative_summaries[[version]]))

    if (method == "regression" & version == "nacc")
      return(reg_coefs$nacc$var_name)

    if (method == "regression" & version == "updated")
      return(reg_coefs$updated_2024$var_name)

    if (method == "T-score")
      return(names(t_score_coefs))
  }
}
