% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_standardized_scores.R
\name{add_standardized_scores}
\alias{add_standardized_scores}
\title{Add Standardized Scores to Data}
\usage{
add_standardized_scores(
  dat,
  sex = "SEX",
  education = "EDUC",
  age = "NACCAGE",
  delay = "MEMTIME",
  methods = NULL,
  rename_raw_scores = F,
  print_messages = T
)
}
\arguments{
\item{dat}{\code{tibble} or \code{data.frame} or \code{data.table} holding the data}

\item{sex}{string specifying column with sex. Column should be a character
vector with entries "m" (for male) or "f" (for female)}

\item{education}{string specifying column with years of education. Column
should be a numeric vector.}

\item{age}{string specifying column with age (in years). Column should be
a numeric vector.}

\item{delay}{string specifying column with delay (in minutes). Column should
be a numeric vector. Used when standardizing \code{MEMUNITS} ("Logical Memory, Delayed")}

\item{methods}{NULL (default) or list of named entries specifying which model to use
for standardizing cognitive scores. If NULL, defaults are applied for all
variables in the dataset for which methods have been implemented (see \code{NpsychBatteryNorms::default_methods})}

\item{rename_raw_scores}{logical; if TRUE, columns with raw scores are renamed
by adding the prefix "raw_" to the column name.}

\item{print_messages}{logical; should messages be printed? If TRUE (default), a message will
be print with the methods used if methods is omitted (or NULL)}
}
\value{
Returns the input data with additional columns of the form \code{std_varname}
with the standardized values for variable \code{varname}
}
\description{
This functions adds a plethora of standardized scores to a dataset containing
raw scores.
}
\examples{
add_standardized_scores(demo_data)

}
