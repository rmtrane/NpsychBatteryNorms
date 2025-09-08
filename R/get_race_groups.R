#' Get Race Group for Standardized Scores
#'
#' Get race group for finding standardized scores.
#'
#' @param race numeric vector with race (according to NACC; see `rdd$RACE` for details) to be converted to groups
#'
#' @export
get_race_group <- function(
  race
) {
  stopifnot("'race' must be numeric vector" = is.numeric(race))

  race <- as.character(values_to_labels(
    valid_values_only(race, var_name = "RACE", remove_errorcodes = 99),
    "RACE"
  ))

  race[race != "White"] <- "Other"

  factor(race, levels = c("White", "Other"))
}
