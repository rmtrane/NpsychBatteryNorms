#' Explore Implemented Methods and Combination with Variables
#'
#' Helper function to find implemented methods for specific variable, or find variables that can be standardized using specific method/version combo.
#'
#' @param var_name NACC variable name for which to return available method/version combos (much be omitted if method/version specified)
#' @param method method to look up. Must be one of `norms`, `regression`, or `T-score`
#' @param version version of method to look up. Either `nacc` (indicating the use of published methods), `updated` (indicating the use of updated versions of the published methods, using data available as of June 2024), or `nacc_legacy` (only for variables included in UDS-2, but dropped for UDS-3). Ignored if method is `T-score`.
#'
#' @export
std_methods <- function(var_name, method, version) {
  if (!missingArg(var_name)) {
    if (!missingArg(method) | !missingArg(version)) {
      cli::cli_abort(
        'Both {.arg method} and {.arg version} must be omitted when {.arg var_name} provided.'
      )
    }

    out <- data.frame(
      method = c(
        rep("norms", length(normative_summaries)),
        rep("regression", length(reg_coefs)),
        "T-score"
      ),
      version = c(
        names(normative_summaries),
        names(reg_coefs),
        NA
      ),
      available = NA
    )

    for (i in 1:nrow(out)) {
      if (out$method[i] == "norms") {
        out$available[i] <- as.numeric(
          var_name %in% names(normative_summaries[[out$version[i]]])
        )
      } else if (out$method[i] == "regression") {
        out$available[i] <- as.numeric(
          var_name %in% reg_coefs[[out$version[i]]]$var_name
        )
      } else if (out$method[i] == "T-score") {
        out$available[i] <- as.numeric(var_name %in% names(t_score_coefs))
      }
    }

    return(out)
  } else {
    if (missingArg(method)) {
      cli::cli_abort(
        "{.arg method} must be provided when {.arg var_name} is not."
      )
    } else if (!method %in% c("norms", "regression", "T-score")) {
      cli::cli_abort(
        "{.arg method} must be one of \"norm\", \"regression\", or \"T-score\", not {method}"
      )
    } else if (method != "T-score" && missingArg(version)) {
      cli::cli_abort(
        "{.arg version} must be provided when {.arg method} is not \"T-score\" (in this call, {.arg method = \"{method}\"})."
      )
    } else if (method == "T-score" & !(missingArg(version) | is.na(version))) {
      cli::cli_alert_info("'version' ignored for method T-score")
    } else if (
      method != "T-score" & !version %in% c("nacc", "nacc_legacy", "updated")
    ) {
      cli::cli_abort(
        message = "'version' must be one of 'nacc', 'nacc_legacy' or 'updated', not {version}"
      )
    }

    if (method == "norms") {
      return(names(normative_summaries[[version]]))
    }

    if (method == "regression") {
      return(reg_coefs[[version]]$var_name)
    }

    if (method == "T-score") return(names(t_score_coefs))
  }
}
