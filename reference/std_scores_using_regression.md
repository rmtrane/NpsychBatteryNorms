# Standardize Raw Cognitive Scores using Regression Models

Get normative scores by standardizing using regression models adjusting
for one or all of age, sex and education.

## Usage

``` r
std_scores_using_regression(
  raw_scores,
  var_name,
  reg_coefs,
  age,
  education,
  sex,
  race,
  delay,
  sd
)
```

## Arguments

- raw_scores:

  Numeric vector of raw scores

- var_name:

  String with name of the variable. Used to get correct means and
  standard deviations, or regression coefficients.

- reg_coefs:

  named vector with coefficients to be used for calculating expected
  score. Can include the following named entries:

  - `intercept`

  - `age`

  - `education`

  - `sex`

  - `race`

  - `delay`

- age:

  Numeric vector with ages in years

- education:

  Numeric vector with years of education. Used for subset of variables
  only.

- sex:

  Character vector with sex of participants. Must be either "m" (for
  male) or "f" (for female). Used for subset of variables only

- race:

  Character vector with race of participants. Must be either "White" or
  "Other". Used only for updated regression models.

- delay:

  Only for standardizing `MEMUNITS` ("Logical Memory, Delayed") in which
  case it is the time of delay in minutes

- sd:

  estimated standard deviation

## Normative Scores from Regression Model

In general, we standardize scores by subtracting an estimate of the
(possibly conditional) expected value of the variable considered, and
divide the difference by an estimate of the (possibly conditional)
standard deviation.

When we aim to do this using a regression model that adjusts for age,
sex, and years of education, we find the conditional expected value as

\$\$ \mu = \beta_0 + \beta\_{age} \cdot \verb\|age\| +
\beta\_{education} \cdot \verb\|education\| + \beta\_{sex} \cdot
\verb\|sex\| \$\$

where \\\verb\|sex\|\\ is \\1\\ if the patient is female, and \\0\\
otherwise. `std_scores_using_regression` takes the coefficients in a
named vector \\\verb\|c(intercept = \|\beta_0\verb\|, age =
\|\beta\_{age}\verb\|, education = \|\beta\_{education}\verb\|, sex =
\|\beta\_{sex}\verb\|)\|\\.

The normative score is then given as \\\verb\|(raw_scores -
\|\mu\verb\|)/sd\|\\, where `sd` is the estimated standard deviation
passed to the `sd` argument. This will typically be the root mean
squared error (RMSE) from the linear regression model.

One final caveat: for consistency, we "flip the sign" for normative
scores where higher raw score values correspond to worse performance.
This is the case for the trail making scores (both written and oral)
related to time and number of errors.
