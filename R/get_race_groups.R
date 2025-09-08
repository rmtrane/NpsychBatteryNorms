#' Get Race Groups for Standardized Scores
#'
#' Get race groups for finding standardized scores.
#'
#' @param race numeric vector with race (according to NACC; see `rdd$RACE` for details) to be converted to groups
#'
#' @export
get_race_groups <- function(
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
