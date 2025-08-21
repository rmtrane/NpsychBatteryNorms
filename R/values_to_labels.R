#' Replace codes with labels
#'
#'
#' @param raw_score numeric vector of raw scores.
#' @param var_name character specifying what test the raw scores are from. Must
#'   be one of the names of the entries in `rdd`
#'
#' @export
values_to_labels <- function(
  raw_score,
  var_name = "SEX"
) {
  stopifnot("'raw_score' must be numeric" = is.numeric(raw_score))
  stopifnot(
    "'var_name' must be one of the named entries of 'rdd'" = var_name %in%
      names(rdd)
  )

  av <- rdd[[var_name]]

  codes <- av$codes

  factor(
    names(codes)[match(as.character(raw_score), codes)],
    levels = names(codes)
  )
}


if (FALSE) {
  testthat::expect_equal(
    stringr::str_replace_all(
      as.character(raw_score),
      setNames(names(codes), paste0("^", codes, "$"))
    ),
    names(codes)[match(as.character(raw_score), codes)]
  )

  new_codes <- setNames(names(codes), paste0("^", codes, "$"))

  microbenchmark::microbenchmark(
    str_replace = stringr::str_replace_all(as.character(raw_score), new_codes),
    match = names(codes)[match(as.character(raw_score), codes)]
  )
}
