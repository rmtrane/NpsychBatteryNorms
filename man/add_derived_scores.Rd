% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_derived_scores.R
\name{add_derived_scores}
\alias{add_derived_scores}
\title{Add Scores Calculated from Raw NACC Scores}
\usage{
add_derived_scores(dat)
}
\arguments{
\item{dat}{\code{data.frame} or \code{tibble} or \code{data.table}}
}
\value{
Copy of the input data with the additional variables
\itemize{
\item \code{REYTOTAL} if \code{REY1REC}, \code{REY2REC}, \code{REY3REC}, \code{REY4REC}, \code{REY5REC} are all columns in input
\item \code{REYAREC} if \code{REYTCOR} and \code{REYFPOS} are both columns in the input (if \code{REYTNEG} is present instead of \code{REYFPOS}, then the latter is added first before \code{REYAREC})
\item \code{FAS} if \code{BILLS}, \code{TAXES}, \code{SHOPPING}, \code{GAMES}, \code{STOVE}, \code{MEALPREP}, \code{EVENTS}, \code{PAYATTN}, \code{REMDATES}, \code{TRAVEL}
are all columns in the input
\item \code{MOCACLOCK} if \code{MOCACLON}, \code{MOCACLOC}, \code{MOCACLOH} are all columns in the input
}
}
\description{
Add calculated scores to a data set with NACC variables.
}
\examples{
add_derived_scores(demo_data)

}
