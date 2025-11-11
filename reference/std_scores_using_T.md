# Standardized Scores using T-scores

Standardized Scores using T-scores

## Usage

``` r
std_scores_using_T(raw_scores, var_name, age, education, sex)
```

## Arguments

- raw_scores:

  Numeric vector of raw scores

- var_name:

  String with name of the variable. Used to get correct means and
  standard deviations, or regression coefficients.

- age:

  Numeric vector with ages in years

- education:

  Numeric vector with years of education. Used for subset of variables
  only.

- sex:

  Character vector with sex of participants. Must be either "m" (for
  male) or "f" (for female). Used for subset of variables only
