#' Add Scores Calculated from Raw NACC Scores
#'
#' Add calculated scores to a data set with NACC variables.
#'
#' @param dat `data.frame` or `tibble` or `data.table`
#'
#' @returns Copy of the input data with the additional variables `REYTOTAL`
#'   (if `REY1REC`, `REY2REC`, `REY3REC`, `REY4REC`, `REY5REC` are all columns in input)
#'   `REYAREC` (if `REYTCOR` and `REYFPOS` are both columns in the input), `FAS`
#'   (if `BILLS`, `TAXES`, `SHOPPING`, `GAMES`, `STOVE`, `MEALPREP`, `EVENTS`, `PAYATTN`, `REMDATES`, `TRAVEL`
#'   are all columns in the input), and `MOCACLOCK` (if `MOCACLON`, `MOCACLOC`, `MOCACLOH` are all columns in the input).
#'
#' @export
add_derived_scores <- function(dat) {
  if (!"REYTOTAL" %in% colnames(dat) & all(paste0("REY", 1:5, "REC") %in% colnames(dat))) {
    dat$REYTOTAL <- with(
      dat,
      valid_values_only(REY1REC, "REY1REC", T) +
        valid_values_only(REY2REC, "REY2REC", T) +
        valid_values_only(REY3REC, "REY3REC", T) +
        valid_values_only(REY4REC, "REY4REC", T) +
        valid_values_only(REY5REC, "REY5REC", T)
    )
  }

  if ("REYTNEG" %in% colnames(dat) & (!"REYFPOS" %in% colnames(dat)))
    dat$REYFPOS <- 15 - dat$REYTNEG

  if (!"REYAREC" %in% colnames(dat)) {
    if (all(c("REYTCOR", "REYFPOS") %in% colnames(dat))) {
      dat$REYAREC <- with(
        dat,
        calculate_reyarec(REYTCOR, REYFPOS)
      )
    }
  }

  vars_for_fas <- c(
    "BILLS",
    "TAXES",
    "SHOPPING",
    "GAMES",
    "STOVE",
    "MEALPREP",
    "EVENTS",
    "PAYATTN",
    "REMDATES",
    "TRAVEL"
  )

  if (!"FAS" %in% colnames(dat) &
      all(vars_for_fas %in% colnames(dat))) {

    dat$FAS <- with(
      dat,
      calculate_fas(
        BILLS,
        TAXES,
        SHOPPING,
        GAMES,
        STOVE,
        MEALPREP,
        EVENTS,
        PAYATTN,
        REMDATES,
        TRAVEL
      )
    )
  }

  if (!"MOCACLOCK" %in% colnames(dat) &
      all(c("MOCACLON", "MOCACLOH", "MOCACLOC") %in% colnames(dat))) {

    dat$MOCACLOCK <- with(
      dat,
      calculate_mocaclock(MOCACLOC, MOCACLON, MOCACLOH)
    )

  }

  return(dat)
}
