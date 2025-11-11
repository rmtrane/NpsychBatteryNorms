# Standardize Raw Cognitive Scores to Z-Scores

Calculate z-scores as `(raw score - average) / sd`. Available for a wide
array of cognitive scores both using normative data, and regression
based models. A wrapper around
[`std_scores_using_norms()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_norms.md),
[`std_scores_using_regression()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_regression.md)
and
[`std_scores_using_T()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_T.md).

## Usage

``` r
std_scores(
  raw_scores,
  var_name,
  education,
  age,
  sex = c("m", "f"),
  delay = NULL,
  race = NULL,
  method = c("norms", "regression", "T-score"),
  version = c("nacc", "updated"),
  print_messages = T
)
```

## Arguments

- raw_scores:

  Numeric vector of raw scores

- var_name:

  String with name of the variable. Used to get correct means and
  standard deviations, or regression coefficients.

- education:

  Numeric vector with years of education. Used for subset of variables
  only.

- age:

  Numeric vector with ages in years

- sex:

  Character vector with sex of participants. Must be either "m" (for
  male) or "f" (for female). Used for subset of variables only

- delay:

  Only for standardizing `MEMUNITS` ("Logical Memory, Delayed") in which
  case it is the time of delay in minutes

- race:

  Character vector with race of participants. Must be either "White" or
  "Other". Used only for updated regression models.

- method:

  String specifying method to use for standardization.

- version:

  String specifying version to use. "nacc" = 2020 numbers published by
  NACC. "updated" = numbers calculated using data freeze from June of
  2024.

- print_messages:

  Logical (default: TRUE); should messages be printed?

## Examples

``` r
std_scores(
  raw_scores = c(21, 15),
  var_name = "MOCATOTS",
  sex = c("m", "f"),
  age = c(57, 70),
  education = c(15, 13),
  method = "regression",
  version = "nacc"
)
#> [1] -2.324629 -4.209920
```
