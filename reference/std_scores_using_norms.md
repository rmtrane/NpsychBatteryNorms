# Standardized Scores using Norms

Returns standardized scores by calculating `(raw_score - mean) / sd`.
Means and standard deviations are given in the `m_sd` argument, and must
be dependent on age, with the option to also depend on sex, and
education.

## Usage

``` r
std_scores_using_norms(raw_scores, var_name, education, age, sex, m_sd)
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

- m_sd:

  data.frame or tibble with means and standard deviations to use for
  standardizing the raw scores. Should also include columns for age
  group, education group, and sex (if desired). For examples, see
  entries in
  [normative_summaries](https://rmtrane.github.io/NpsychBatteryNorms/reference/normative_summaries.md).
