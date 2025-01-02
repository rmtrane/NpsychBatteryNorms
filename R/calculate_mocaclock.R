#' Calculate MoCA clock drawing test total
#'
#' @description
#' Sum of MOCACLOC, MOCACLON, and MOCACLOH, but applies [valid_values_only()] before
#' adding values.
#'
#' @param MOCACLOC values for clock contour
#' @param MOCACLON values for clock numbers
#' @param MOCACLOH values for clock hands
#'
#' @export
calculate_mocaclock <- function(
    MOCACLOC,
    MOCACLON,
    MOCACLOH
) {
  valid_values_only(MOCACLOC, "MOCACLOC", T) +
    valid_values_only(MOCACLON, "MOCACLON", T) +
    valid_values_only(MOCACLOH, "MOCACLOH", T)
}
