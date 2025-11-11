# Calculate Rey AVLT Total score

Sum of REY1REC, ..., REY5REC, but applies
[`valid_values_only()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/valid_values_only.md)
before adding values. This removes any values not between 0 and 15.

## Usage

``` r
calculate_reytotal(REY1REC, REY2REC, REY3REC, REY4REC, REY5REC)
```

## Arguments

- REY1REC:

  values for RAVLT Trial 1 total recall

- REY2REC:

  values for RAVLT Trial 2 total recall

- REY3REC:

  values for RAVLT Trial 3 total recall

- REY4REC:

  values for RAVLT Trial 4 total recall

- REY5REC:

  values for RAVLT Trial 5 total recall
