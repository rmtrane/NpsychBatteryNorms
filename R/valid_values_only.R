#' Replace values with labels
#'
#'
#' @param raw_score numeric vector of raw scores.
#' @param var_name character specifying what test the raw scores are from. Must
#'   be one of the names of the entries in `rdd`
#' @param remove_errorcodes should values listed in the `rdd$var_name$codes`
#'   be replaced by `NA` in output? Either FALSE (default; do not remove valid
#'   codes), TRUE (remove all codes), or a numeric vector with codes to remove.
#'
#' @export
valid_values_only <- function(
  raw_score,
  var_name = "ANIMALS",
  remove_errorcodes = FALSE
) {
  stopifnot("'raw_score' must be numeric" = is.numeric(raw_score))
  stopifnot(
    "'var_name' must be one of the named entries of 'rdd'" = var_name %in%
      names(rdd)
  )
  stopifnot(
    "'remove_errorcodes' must be either logical, or numeric" = is.logical(
      remove_errorcodes
    ) |
      is.numeric(remove_errorcodes)
  )

  av <- rdd[[var_name]]
  min_val <- av$range[1]
  max_val <- av$range[2]

  error_codes <- av$codes

  if (isFALSE(remove_errorcodes)) {
    raw_score[
      !((raw_score >= av$range[1] & raw_score <= av$range[2]) |
        raw_score %in% error_codes)
    ] <- NA
  } else {
    if (is.numeric(remove_errorcodes)) {
      raw_score[
        !((raw_score >= av$range[1] & raw_score <= av$range[2]) |
          raw_score %in% setdiff(error_codes, remove_errorcodes))
      ] <- NA
    }

    if (isTRUE(remove_errorcodes)) {
      raw_score[
        !(raw_score >= av$range[1] & raw_score <= av$range[2]) |
          raw_score %in% error_codes
      ] <- NA
    }
  }

  raw_score
}
