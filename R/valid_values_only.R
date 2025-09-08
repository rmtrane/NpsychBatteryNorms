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

  if (all(is.na(raw_score))) {
    return(raw_score)
  }

  av <- rdd[[var_name]]
  error_codes <- av$codes

  # raw_score %in% error_codes
  raw_in_codes <- !data.table::between(
    raw_score,
    -1,
    min(c(error_codes[error_codes > 0], Inf)),
    incbounds = F
  )

  if (is.null(av$range)) {
    if (all(raw_in_codes, na.rm = T) & !remove_errorcodes) {
      return(raw_score)
    }

    if (is.numeric(remove_errorcodes)) {
      raw_score[raw_score %in% remove_errorcodes] <- NA
    } else {
      raw_score[!raw_in_codes] <- NA
    }

    return(raw_score)
  }

  min_val <- av$range[1]
  max_val <- av$range[2]

  raw_between <- data.table::between(raw_score, min_val, max_val)

  if (
    !is.null(av$range) &
      # all((min_val <= raw_score & raw_score <= max_val), na.rm = T)
      all(raw_between, na.rm = T)
  ) {
    return(raw_score)
  }

  if (is.numeric(remove_errorcodes)) {
    raw_score[
      !(
        # (raw_score >= min_val & raw_score <= max_val)
        # data.table::between(raw_score, min_val, max_val) |
        raw_between |
          raw_score %in% setdiff(error_codes, remove_errorcodes)
      )
    ] <- NA

    return(raw_score)
  }

  if (remove_errorcodes) {
    raw_score[
      # !(raw_score >= min_val & raw_score <= max_val) |
      # !data.table::between(raw_score, min_val, max_val) |
      !raw_between |
        # raw_score %in% error_codes
        raw_in_codes
    ] <- NA
  } else {
    raw_score[
      # !((raw_score >= min_val & raw_score <= max_val) |
      !(#data.table::between(raw_score, min_val, max_val) |
      raw_between |
        # raw_score %in% error_codes
        raw_in_codes)
    ] <- NA
  }

  return(raw_score)
}
