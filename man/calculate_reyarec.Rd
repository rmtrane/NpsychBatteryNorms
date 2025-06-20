% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_reyarec.R
\name{calculate_reyarec}
\alias{calculate_reyarec}
\title{Calculate the Rey AVLT Accuracy}
\usage{
calculate_reyarec(REYTCOR, REYFPOS)
}
\arguments{
\item{REYTCOR}{true positives}

\item{REYFPOS}{false positives}
}
\description{
Calculates accuracy from true positives and false positives, but applies \code{valid_values_only()}
first. As percentage, i.e. a value of 55 means 55\%.
}
