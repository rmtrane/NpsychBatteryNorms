# Regression Coefficients for T-score Based Standardization

Regression coefficients used to obtain standardized scores using
T-scores.

## Usage

``` r
t_score_coefs
```

## Format

A named list with one entry for each NACC variable for which T-scores
have been implemented. Each entry contains the coefficients needed for
the corresponding model. This is a subset of `intercept`, `age`,
`age^2`, `sex`, `education`, `intercept2`, `sd`, `intercept3`,
`education^0.5`, `age^2_2`.

## References

The coefficients implemented here are published in the following two
articles:

- Stricker NH, Christianson TJ, Lundt ES, Alden EC, Machulda MM, Fields
  JA, Kremers WK, Jr CRJ, Knopman DS, Mielke MM, Petersen RC (2021).
  “Mayo Normative Studies: Regression-Based Normative Data for the
  Auditory Verbal Learning Test for Ages 30–91 Years and the Importance
  of Adjusting for Sex.” *Journal of the International
  Neuropsychological Society*, **27**(3), 211–226. ISSN 1355-6177,
  1469-7661,
  [doi:10.1017/S1355617720000752](https://doi.org/10.1017/S1355617720000752)
  ,
  [2024-11-19](https://rmtrane.github.io/NpsychBatteryNorms/reference/2024-11-19).

- Karstens AJ, Christianson TJ, Lundt ES, Machulda MM, Mielke MM, Fields
  JA, Kremers WK, Graff-Radford J, Vemuri P, Jack Jr. CR, Knopman DS,
  Petersen RC, Stricker NH (2023). “Mayo Normative Studies:
  Regression-Based Normative Data for Ages 30–91 Years with a Focus on
  the Boston Naming Test, Trail Making Test and Category Fluency.”
  *Journal of the International Neuropsychological Society : JINS*,
  **30**(4), 389.
  [doi:10.1017/S1355617723000760](https://doi.org/10.1017/S1355617723000760)
  , <http://www.ncbi.nlm.nih.gov/pubmed/38014536>.
