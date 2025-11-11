# Calculate MoCA clock drawing test total

Sum of MOCACLOC, MOCACLON, and MOCACLOH, but applies
[`valid_values_only()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/valid_values_only.md)
before adding values. This removes any values not 0 or 1.

## Usage

``` r
calculate_mocaclock(MOCACLOC, MOCACLON, MOCACLOH)
```

## Arguments

- MOCACLOC:

  values for clock contour

- MOCACLON:

  values for clock numbers

- MOCACLOH:

  values for clock hands
