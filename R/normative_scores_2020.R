#' Means and SDs for calculating z-scores (per 2020)
#'
#' @format A list of tibbles created from https://files.alz.washington.edu/documentation/uds3-means.pdf.
#'   Each list entry correspond to a variable that we can standardize to z-scores.
#'   Each list entry holds a tibble organized as follows:
#' \describe{
#'   \item{age_group}{the age group as follows: <60, 60-69, 70-79, 80-89, >89}
#'   \item{edu_group}{the education group based on years of education as follows: <13 years, 13-15, 16, >16}
#'   \item{SEX}{the sex group. "m" = "male", "f" = "female".}
#'   \item{n}{Number of subjects for which the means and standard deviations are based on.}
#'   \item{m}{mean for variable in group given by age group (and possible sex and education group)}
#'   \item{sd}{standard deviation}
#' }
#'
"normative_scores_2020"
