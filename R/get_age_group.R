#' Get Age Group for Standardized Scores
#'
#' Get various versions of age groups for finding standardized scores.
#'
#' @param age numeric vector with ages to be converted to groups
#' @param group_type string indicator which age group to return. Must be one of
#'   "ravlt_trials", "nacc", "updated"
#'
#' @export
get_age_group <- function(
  age,
  group_type = c(
    "ravlt_trials",
    "nacc",
    "updated"
  )
) {
  stopifnot("'age' must be numeric vector" = is.numeric(age))
  stopifnot(
    "'group_type' must be one of 'ravlt_trials' or 'nacc'" = any(
      group_type == c("ravlt_trials", "nacc", "updated")
    )
  )
  stopifnot("'group_type' not of length 1" = length(group_type) == 1)

  # From Excel sheet "Summary", cell BI25. Cutoffs in array in formula.
  if (group_type == "ravlt_trials") {
    out <- .bincode(
      age,
      c(0, 20, 30, 40, 50, 60, 70, 80, Inf),
      # c(0, 16, 20, 30, 40, 50, 60, 70, 80, Inf),
      right = FALSE
    )

    attr(out, "levels") <- c(
      # "<16",
      # "16-19",
      "<20",
      "20-29",
      "30-39",
      "40-49",
      "50-59",
      "60-69",
      "70-79",
      ">79"
    )
    class(out) <- "factor"

    return(out)
  }

  if (group_type == "nacc") {
    out <- .bincode(age, c(0, 60, 70, 80, 90, Inf), right = FALSE)

    attr(out, "levels") <- c("<60", "60-69", "70-79", "80-89", ">89")
    class(out) <- "factor"

    return(out)
  }

  if (group_type == "updated") {
    out <- .bincode(age, c(0, 60, 70, 80, Inf), right = FALSE)

    attr(out, "levels") <- c("<60", "60-69", "70-79", ">79")
    class(out) <- "factor"

    return(out)
  }
}
