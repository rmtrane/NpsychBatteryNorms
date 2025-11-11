# Replace values with labels

Replace values with labels

## Usage

``` r
valid_values_only(raw_score, var_name = "ANIMALS", remove_errorcodes = FALSE)
```

## Arguments

- raw_score:

  numeric vector of raw scores.

- var_name:

  character specifying what test the raw scores are from. Must be one of
  the names of the entries in `rdd`

- remove_errorcodes:

  should values listed in the `rdd$var_name$codes` be replaced by `NA`
  in output? Either FALSE (default; do not remove valid codes), TRUE
  (remove all codes), or a numeric vector with codes to remove.
