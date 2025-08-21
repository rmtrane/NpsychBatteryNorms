#' Get education group
#'
#' @param education A numeric vector representing years of education.
#'
#' @returns
#' A factor representing education groups, with levels `"<13"`, `"13-15"`, `"16"`, and `">16"`.
#'
#' @export
get_educ_group <- function(education) {
  edu_group <- .bincode(education, c(0, 13, 16, 17, Inf), right = FALSE) # c("<13", "13-15", "16", ">16")[findInterval(education, c(13, 16, 17)) + 1]
  attr(edu_group, "levels") <- c("<13", "13-15", "16", ">16")
  class(edu_group) <- "factor"

  edu_group
}
