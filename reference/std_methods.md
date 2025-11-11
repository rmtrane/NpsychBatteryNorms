# Explore Implemented Methods and Combination with Variables

Helper function to find implemented methods for specific variable, or
find variables that can be standardized using specific method/version
combo.

## Usage

``` r
std_methods(var_name, method, version)
```

## Arguments

- var_name:

  NACC variable name for which to return available method/version combos
  (much be omitted if method/version specified)

- method:

  method to look up. Must be one of `norms`, `regression`, or `T-score`

- version:

  version of method to look up. Either `nacc` (indicating the use of
  published methods), `updated_*` (indicating the use of updated
  versions of the published methods), or `nacc_legacy` (only for
  variables included in UDS-2, but dropped for UDS-3). Ignored if method
  is `T-score`.
