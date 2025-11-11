# Scaled Scores lookup tables from Mayo Normative Studies

Scaled scores from Mayo Normative Studies for a variety of variables. To
get a list of all variables, run `names(ss)`. Note, these names refer to
variable names in the Mayo Normative Study.

## Usage

``` r
ss
```

## Format

A named list of named vectors such that `ss$var_name[["raw_score"]]`
gives the scaled score for the variable `var_name` corresponding to a
raw score of `raw_score`.

## Scaled Scores

Scaled scores are used in the calculation of T-scores. In short, the
T-scores are based on a regression model that fits the scaled scores as
a function of sex, age, and years of education (with some second order
terms). The purpose of the scaled scores is to force the data to be more
normal looking. For more details, see Karstens AJ, Christianson TJ,
Lundt ES, Machulda MM, Mielke MM, Fields JA, Kremers WK, Graff-Radford
J, Vemuri P, Jack Jr. CR, Knopman DS, Petersen RC, Stricker NH (2023).
“Mayo Normative Studies: Regression-Based Normative Data for Ages 30–91
Years with a Focus on the Boston Naming Test, Trail Making Test and
Category Fluency.” *Journal of the International Neuropsychological
Society : JINS*, **30**(4), 389.
[doi:10.1017/S1355617723000760](https://doi.org/10.1017/S1355617723000760)
, <http://www.ncbi.nlm.nih.gov/pubmed/38014536>. .

## References

Karstens AJ, Christianson TJ, Lundt ES, Machulda MM, Mielke MM, Fields
JA, Kremers WK, Graff-Radford J, Vemuri P, Jack Jr. CR, Knopman DS,
Petersen RC, Stricker NH (2023). “Mayo Normative Studies:
Regression-Based Normative Data for Ages 30–91 Years with a Focus on the
Boston Naming Test, Trail Making Test and Category Fluency.” *Journal of
the International Neuropsychological Society : JINS*, **30**(4), 389.
[doi:10.1017/S1355617723000760](https://doi.org/10.1017/S1355617723000760)
, <http://www.ncbi.nlm.nih.gov/pubmed/38014536>.
