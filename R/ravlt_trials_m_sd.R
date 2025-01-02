#' Means and SDs for calculating z-scores (per 2020)
#'
#' @format A list of tibbles.
#'   Each list entry correspond to a variable that we can standardize to z-scores.
#'   Each list entry holds a tibble organized as follows:
#' \describe{
#'   \item{ravlt_trials_age_group}{the age group as follows: <20, 20-29, 30-39, ..., 70-79, >79.}
#'   \item{m}{mean for variable in group given by age group (and possible sex and education group)}
#'   \item{sd}{standard deviation}
#' }
#'
#' @source Unknown; numbers from old spreadsheet.
"ravlt_trials_m_sd"
