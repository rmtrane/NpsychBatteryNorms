#' Standardized Scores using Norms
#'
#' Returns standardized scores by calculating `(raw_score - mean) / sd`. Means
#' and standard deviations are given in the `m_sd` argument, and must be dependent
#' on age, with the option to also depend on sex, and education.
#'
#' @inheritParams std_scores
#' @param m_sd data.frame or tibble with means and standard deviations to use for
#'   standardizing the raw scores. Should also include columns for age group,
#'   education group, and sex (if desired). For examples, see entries in
#'   [normative_summaries].
#'
#' @export
std_scores_using_norms <- function(
  raw_scores,
  var_name,
  education,
  age,
  sex,
  m_sd
) {
  stopifnot("'raw_scores' must be a numeric vector" = is.numeric(raw_scores))
  stopifnot(
    "'var_name' must be a string" = is.character(var_name) &
      length(var_name) == 1
  )

  # Age: always needed, but different group types
  if (substr(var_name, start = 1, stop = 3) == "REY") {
    age_group_type_needed <- "ravlt_trials"
  } else {
    age_group_type_needed <- "nacc"
  }

  # Create match_to data.frame with two columns: raw_scores and age groups. (We
  # will later add means and SDs to this data.frame for standardizing raw scores.)
  match_to <- data.frame(
    raw_scores,
    age_group = get_age_group(
      age,
      group_type = age_group_type_needed
    )
  )

  # Vector to hold columns that should be matches by later
  merge_by_vars <- "age_group"

  # Sex: not used for REY variables
  if (any(grepl("sex", colnames(m_sd)))) {
    # Some checks.
    stopifnot(
      "'sex' is missing, but needed to standardize this variable" = !missingArg(
        sex
      )
    )
    stopifnot(
      "'sex' must be same length as 'raw_scores'" = length(sex) ==
        length(raw_scores)
    )
    stopifnot(
      "'sex' must be vector of 'm' and 'f'" = all(
        unique(sex) %in% c("f", "m", NA)
      )
    )

    # Add sex to match_to data.frame
    match_to$sex <- sex

    # Add "sex" to variables to join by later
    merge_by_vars <- c(merge_by_vars, "sex")
  }

  # Education:
  if (any("edu_group" == colnames(m_sd))) {
    # Some checks
    stopifnot(
      "'eduction' is missing, but needed to standardize this variable" = !missingArg(
        education
      )
    )
    stopifnot(
      "'eduction' must be same length as 'raw_scores'" = length(education) ==
        length(raw_scores)
    )
    stopifnot(
      "'education' must be numeric vector" = is.numeric(education) |
        is.na(education)
    )

    # Add education groups to match_to data.frame. These are from "male" and "female"
    # sheets of Excel spreadsheet.
    # edu_group <- .bincode(education, c(0, 13, 16, 17, Inf), right = FALSE) # c("<13", "13-15", "16", ">16")[findInterval(education, c(13, 16, 17)) + 1]
    # attr(edu_group, "levels") <- c("<13", "13-15", "16", ">16")
    # class(edu_group) <- "factor"

    match_to$edu_group <- get_educ_group(education)

    # Add "edu_group" to variables to join by
    merge_by_vars <- c(merge_by_vars, "edu_group")
  }

  # Add an id column for bookkeeping
  match_to$id <- 1:nrow(match_to)

  # Add means and standard deviations to data.frame so we can standardize raw scores
  match_to$for_merge <- do.call(
    paste,
    c(as.list(match_to[, merge_by_vars, drop = F]), sep = "__")
  )
  m_sd$for_merge <- do.call(
    paste,
    c(as.list(m_sd[, merge_by_vars, drop = F]), sep = "__")
  )

  match_to[, intersect(c("n", "m", "sd"), colnames(m_sd))] <- m_sd[
    match(match_to$for_merge, m_sd$for_merge),
    # c("n", "m", "sd")
    intersect(c("n", "m", "sd"), colnames(m_sd))
  ]

  for_standardizing <- match_to[order(match_to$id), c("raw_scores", "m", "sd")]

  # Get standardized scores. If either time or error, return negative value so
  # that higher is always better.
  if (
    var_name %in%
      c(
        "TRAILA",
        "TRAILB",
        "TRAILARR",
        "TRAILBRR",
        "OTRAILA",
        "OTRAILB",
        "OTRLARR",
        "OTRLBRR"
      )
  ) {
    standardized_scores <- -with(for_standardizing, (raw_scores - m) / sd)
  } else {
    standardized_scores <- with(for_standardizing, (raw_scores - m) / sd)
  }

  standardized_scores
}
