# Helper to extract methods from standardized columns

Helper to extract methods from standardized columns

## Usage

``` r
methods_from_std_data(std_data, std_cols)
```

## Arguments

- std_data:

  `data.frame`/`tibble` with some standardized columns

- std_cols:

  optional; specify columns to get methods for. If omitted, will return
  method attribute from all columns that have said attribute
