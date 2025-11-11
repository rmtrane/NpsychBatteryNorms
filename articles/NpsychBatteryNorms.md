# Introduction to NpsychBatteryNorms

NpsychBatteryNorms lets you easily calculate normative scores for a wide
variety of neuropsychological tests using various methods.

## Installation

``` r
# Install remotes if not already installed
install.packages("remotes")
remotes::install_github("rmtrane/NpsychBatteryNorms")
```

> **Disclaimer**
>
> This R package started as the backbone of the visualization tool
> included in the R package `NpsychAssessmentTool`, but we quickly
> realized it might be of use as a standalone tool for other
> researchers. It was therefore decided to package the most important
> tools and methods separately, which resulted in this package. None of
> the implementations here should be used in commercial products nor as
> standalone medical advice. Also note this package is distributed under
> the [MIT
> Licence](https://rmtrane.github.io/NpsychBatteryNorms/articles/LICENSE.md),
> meaning the software is provided “asis” and the authors are not liable
> for any claim, damages or other liabaility arising from this software.
> Also, note that the authors behind the T-scores implemented for some
> test scores request that the scores are not edited, modified,
> translated or otherwise part of derivative work without the prior
> written permission of Mayo Clinic. For more on the use of the
> T-scores, contact [Nikki Stricker](mailto:Stricker.Nikki@mayo.edu)
> and/or see the [Mayo Clinic Study of Aging website for more on data
> sharing](https://www.mayo.edu/research/centers-programs/alzheimers-disease-research-center/research-activities/mayo-clinic-study-aging/for-researchers/data-sharing-resources).

## Simple Usage

The main function in this package is `std_scores` which lets us
standardize raw scores. As an example, we can standardize a raw score
for the MoCA of 21 for a 57 year old male patient with 15 years of
education using normative data published by NACC:

``` r
library(NpsychBatteryNorms)

std_scores(
  raw_scores = 21,
  var_name = "MOCATOTS",
  sex = "m",
  age = 57,
  education = 15,
  method = "norms",
  version = "nacc"
)
#> [1] -2.192308
```

We can standardize this score using various methods. For a table showing
the methods implemented, use `implemented_std_methods`. This shows which
method/ version combos are available (1) and which are not (0):

``` r
std_methods(var_name = "MOCATOTS")
#>       method         version available
#> 1      norms            nacc         1
#> 2      norms         updated         1
#> 3      norms    ravlt_trials         0
#> 4 regression            nacc         1
#> 5 regression     nacc_legacy         0
#> 6 regression updated_2024.06         1
#> 7 regression updated_2025.06         1
#> 8    T-score            <NA>         0
```

We can also do the reverse lookup: the variables that can be
standardized using regression models published by NACC:

``` r
std_methods(method = "regression", version = "nacc")
#>  [1] "MOCATOTS"  "CRAFTVRS"  "CRAFTURS"  "UDSBENTC"  "DIGFORCT"  "DIGFORSL" 
#>  [7] "DIGBACCT"  "DIGBACLS"  "ANIMALS"   "VEG"       "TRAILA"    "TRAILB"   
#> [13] "CRAFTDVR"  "CRAFTDRE"  "CRAFTCUE"  "UDSBENTD"  "UDSBENRS"  "MINTTOTS" 
#> [19] "MINTTOTW"  "MINTSCNG"  "MINTPCNG"  "UDSVERFC"  "UDSVERLC"  "UDSVERTN" 
#> [25] "UDSVERTE"  "UDSVERTI"  "trailaadj" "trailbadj"
```

Standardizing using the NACC published regression model, we get a
slightly different normative score.

``` r
std_scores(
  raw_scores = 21,
  var_name = "MOCATOTS",
  sex = "m",
  age = 57,
  education = 15,
  method = "regression",
  version = "nacc"
)
#> [1] -2.324629
```

## For Analysis

In a more realistic use case, we have data on a number of patients in a
data set. One such example is the NACC data that is obtainable from [the
NACC data website](https://www.naccdata.org). We include a demo data set
for you to explore (see
[`?demo_data`](https://rmtrane.github.io/NpsychBatteryNorms/reference/demo_data.md)
for more).

``` r
head(demo_data)
#>        NACCID NACCAGE   SEX  EDUC BIRTHYR BIRTHMO VISITYR VISITMO VISITDAY
#>        <char>   <num> <num> <num>   <num>   <num>   <num>   <num>    <num>
#> 1: NACC074283      84     2    18    1927       3    2011      10        5
#> 2: NACC005366      65     2    16    1957       7    2023       5       10
#> 3: NACC005366      51     2    16    1957       7    2009       5       15
#> 4: NACC005366      56     2    16    1957       7    2013       9        4
#> 5: NACC005366      58     2    16    1957       7    2015      10       27
#> 6: NACC005366      62     2    16    1957       7    2020       1        5
#>     RACE HANDED CDRGLOB MOCATOTS MOCBTOTS TRAILA TRAILARR TRAILALI OTRAILA
#>    <num>  <num>   <num>    <num>    <num>  <num>    <num>    <num>   <num>
#> 1:     1      2     1.0       -4       -4     27       -4       -4      -4
#> 2:     1      2     0.5       -4       -4     31        0       24      -4
#> 3:     1      2     0.5       -4       -4     27        0       24      -4
#> 4:     1      2     2.0       -4       -4    100        0       24      -4
#> 5:     1      2     0.0       -4       -4     30        0       24      -4
#> 6:     1      2     0.0       -4       -4    996        0       24      -4
#>    OTRLARR DIGFORCT DIGFORSL DIGBACCT DIGBACLS  WAIS MINTTOTS ANIMALS   VEG
#>      <num>    <num>    <num>    <num>    <num> <num>    <num>   <num> <num>
#> 1:      -4       -4       -4       -4       -4     0       -4      26     3
#> 2:      -4       -4       -4       -4       -4    49       -4      27    18
#> 3:      -4       -4       -4       -4       -4    43       -4      23    21
#> 4:      -4       -4       -4       -4       -4    51       -4      12    11
#> 5:      -4       -4       -4       -4       -4    43       -4      22    17
#> 6:      -4       -4       -4       -4       -4    38       -4      18     6
#>    UDSVERTN UDSVERFC UDSVERLC UDSBENTC UDSBENTD CRAFTVRS CRAFTURS CRAFTDVR
#>       <num>    <num>    <num>    <num>    <num>    <num>    <num>    <num>
#> 1:       -4       -4       -4       -4       -4       -4       -4       -4
#> 2:       -4       -4       -4       -4       -4       -4       -4       -4
#> 3:       -4       -4       -4       -4       -4       -4       -4       -4
#> 4:       -4       -4       -4       -4       -4       -4       -4       -4
#> 5:       -4       -4       -4       -4       -4       -4       -4       -4
#> 6:       -4       -4       -4       -4       -4       -4       -4       -4
#>    CRAFTDRE REY1REC REY2REC REY3REC REY4REC REY5REC REY6REC REYDREC REYTCOR
#>       <num>   <num>   <num>   <num>   <num>   <num>   <num>   <num>   <num>
#> 1:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 2:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 3:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 4:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 5:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 6:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>    TRAILB TRAILBLI TRAILBRR MOCACLOC MOCACLOH MOCACLON OTRAILB OTRLBRR OTRLBLI
#>     <num>    <num>    <num>    <num>    <num>    <num>   <num>   <num>   <num>
#> 1:    150       -4       -4       -4       -4       -4      -4      -4      -4
#> 2:     98       96        0       -4       -4       -4      -4      -4      -4
#> 3:    996        6        1       -4       -4       -4      -4      -4      -4
#> 4:    997       24        0       -4       -4       -4      -4      -4      -4
#> 5:     39       24        0       -4       -4       -4      -4      -4      -4
#> 6:    996       24        3       -4       -4       -4      -4      -4      -4
#>    NACCGDS CDRSUM UDSBENRS BILLS TAXES SHOPPING GAMES STOVE MEALPREP EVENTS
#>      <num>  <num>    <num> <num> <num>    <num> <num> <num>    <num>  <num>
#> 1:       1    2.0       -4     0     0        0     0     0        0      0
#> 2:       0    8.0       -4     0     0        0     0     0        1      0
#> 3:       1   13.0       -4     0     0        0     0     0        8      0
#> 4:      88    2.5       -4     0     0        0     0     0        0      2
#> 5:       5    0.0       -4     0     0        0     0     0        8      3
#> 6:       7    0.0       -4     0     3        0     0     0        1      0
#>    PAYATTN REMDATES TRAVEL REYFPOS NACCUDSD NACCMMSE BOSTON LOGIMEM MEMUNITS
#>      <num>    <num>  <num>   <num>    <num>    <num>  <num>   <num>    <num>
#> 1:       0        2      0      -4        1       30     29      17        3
#> 2:       0        0      0      -4        1       30     26      17        2
#> 3:       0        0      0      -4        1       30     24      16       13
#> 4:       0        3      0      -4        4       29      3      17        5
#> 5:       2        0      0      -4        4       28     27       3        0
#> 6:       0        3      2      -4        1       20     28       9        0
#>    MEMTIME DIGIF DIGIFLEN DIGIB DIGIBLEN OTHCOG OTHCOGX OTHPSY  OTHPSYX COGOTH
#>      <num> <num>    <num> <num>    <num>  <num>  <char>  <num>   <char>  <num>
#> 1:      35     8        3     3        5     -4              0               0
#> 2:      -4    97        6     8        4     -4              0               0
#> 3:      18     6        5     8        4     -4              0               1
#> 4:       8    10        6     4        7     -4              0               0
#> 5:      10    10       96     3        5     -4              1 DYSTHMIA      0
#> 6:      21    11        4     6        6     -4              0               0
#>    COGOTHIF   COGOTHX COGOTH2 COGOTH2F COGOTH2X COGOTH3 COGOTH3X ALCDEM
#>       <num>    <char>   <num>    <num>   <char>   <num>   <char>  <num>
#> 1:        7                -4        8               -4               0
#> 2:        7                 0        8                0               0
#> 3:        7 delusions       0        8                0               0
#> 4:        8                 0        8                0               0
#> 5:        7                 0        7                0               0
#> 6:        7                 0        8                0               0
#>    ALCDEMIF ANXIET ANXIETIF BIPOLDX BIPOLDIF BRNINJ BRNINJIF  CORT CORTIF   CVD
#>       <num>  <num>    <num>   <num>    <num>  <num>    <num> <num>  <num> <num>
#> 1:        7     -4       -4      -4       -4      0        7     0      8    -4
#> 2:        8     -4       -4      -4       -4      0        7     0      8    -4
#> 3:        7     -4       -4      -4       -4      0        8     0      7    -4
#> 4:        8     -4       -4      -4       -4      0        7     0      7    -4
#> 5:        8     -4       -4      -4       -4      0        7     0      7    -4
#> 6:        7     -4       -4      -4       -4      0        8     0      7    -4
#>    CVDIF DELIR DELIRIF DEMUN DEMUNIF   DEP DEPIF DOWNS DOWNSIF DYSILL DYSILLIF
#>    <num> <num>   <num> <num>   <num> <num> <num> <num>   <num>  <num>    <num>
#> 1:    -4    -4      -4     8       7     0     8     0       8      0        8
#> 2:    -4    -4      -4     8       8     0     7     0       8      0        7
#> 3:    -4    -4      -4     0       8     0     8     0       7      0        7
#> 4:    -4    -4      -4     0       7     0     8     0       8      0        8
#> 5:    -4    -4      -4     8       8     1     7     0       7      0        8
#> 6:    -4    -4      -4     8       8     0     7     0       8      0        2
#>    EPILEP EPILEPIF ESSTREM ESSTREIF FTLDMO FTLDMOIF FTLDNOS FTLDNOIF   HIV
#>     <num>    <num>   <num>    <num>  <num>    <num>   <num>    <num> <num>
#> 1:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#> 2:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#> 3:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#> 4:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#> 5:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#> 6:     -4       -4      -4       -4     -4       -4      -4       -4    -4
#>    HIVIF  HUNT HUNTIF HYCEPH HYCEPHIF IMPSUB IMPSUBIF  MEDS MEDSIF   MSA MSAIF
#>    <num> <num>  <num>  <num>    <num>  <num>    <num> <num>  <num> <num> <num>
#> 1:    -4     0      8      0        7     -4       -4     0      7    -4    -4
#> 2:    -4     0      8      0        7     -4       -4     0      8    -4    -4
#> 3:    -4     0      8      0        7     -4       -4     0      8    -4    -4
#> 4:    -4     0      8      0        8     -4       -4     0      8    -4    -4
#> 5:    -4     0      8      0        7     -4       -4     0      8    -4    -4
#> 6:    -4     0      8      0        7     -4       -4     0      8    -4    -4
#>    NACCALZD NACCALZP NACCLBDE NACCLBDP  NEOP NEOPIF OTHCOGIF OTHPSYIF POSSAD
#>       <num>    <num>    <num>    <num> <num>  <num>    <num>    <num>  <num>
#> 1:        1        1        0        7     0      8       -4        8      0
#> 2:        8        7        0        7     0      8       -4        8      0
#> 3:        8        7        0        7     0      7       -4        7      8
#> 4:        1        7        8        7     0      7       -4        7      1
#> 5:        8        1        0        7     0      8       -4        8      0
#> 6:        8        1        8        7     0      8       -4        8      8
#>    POSSADIF PPAPH PPAPHIF PRION PRIONIF PROBAD PROBADIF   PSP PSPIF PTSDDX
#>       <num> <num>   <num> <num>   <num>  <num>    <num> <num> <num>  <num>
#> 1:        7     1       7     0       8      0        7     0     7     -4
#> 2:        8     1       7     0       7      0        1     0     7     -4
#> 3:        7     0       8     0       8      8        7     0     8     -4
#> 4:        7     0       8     0       7      1        8     0     8     -4
#> 5:        1     0       8     0       7      1        8     0     8     -4
#> 6:        7     0       7     0       8      0        1     0     7     -4
#>    PTSDDXIF SCHIZOP SCHIZOIF STROKE STROKIF  VASC VASCIF VASCPS VASCPSIF
#>       <num>   <num>    <num>  <num>   <num> <num>  <num>  <num>    <num>
#> 1:       -4      -4       -4      0       7     0      7     -4       -4
#> 2:       -4      -4       -4      0       7     0      1      8        7
#> 3:       -4      -4       -4      0       2     8      8      8        8
#> 4:       -4      -4       -4      0       8     0      8      8        8
#> 5:       -4      -4       -4      0       7     8      7      0        7
#> 6:       -4      -4       -4      0       7     0      8      8        7
```

We can calculate all standardized scores in one go and have them added
to the data as `std_{var_name}`:

``` r
demo_data_w_std <- add_standardized_scores(
  demo_data,
  sex = "SEX",
  education = "EDUC",
  age = "NACCAGE",
  race = "RACE",
  delay = "MEMTIME"
)
#> 'methods' not specified. Will use the following defaults:
#> MOCATOTS: regression (updated_2025.06 version)
#> OTRAILA: regression (updated_2025.06 version)
#> OTRAILB: regression (updated_2025.06 version)
#> OTRLARR: regression (updated_2025.06 version)
#> OTRLBRR: regression (updated_2025.06 version)
#> DIGFORCT: regression (updated_2025.06 version)
#> DIGFORSL: regression (updated_2025.06 version)
#> DIGBACCT: regression (updated_2025.06 version)
#> DIGBACLS: regression (updated_2025.06 version)
#> TRAILA: regression (updated_2025.06 version)
#> TRAILB: regression (updated_2025.06 version)
#> WAIS: T-score
#> MINTTOTS: regression (updated_2025.06 version)
#> ANIMALS: regression (updated_2025.06 version)
#> VEG: regression (updated_2025.06 version)
#> UDSVERFC: regression (updated_2025.06 version)
#> UDSVERLC: regression (updated_2025.06 version)
#> UDSVERTN: regression (updated_2025.06 version)
#> UDSBENTC: regression (updated_2025.06 version)
#> UDSBENTD: regression (updated_2025.06 version)
#> CRAFTVRS: regression (updated_2025.06 version)
#> CRAFTURS: regression (updated_2025.06 version)
#> CRAFTDVR: regression (updated_2025.06 version)
#> CRAFTDRE: regression (updated_2025.06 version)
#> REY1REC: T-score
#> REY2REC: T-score
#> REY3REC: T-score
#> REY4REC: T-score
#> REY5REC: T-score
#> REY6REC: T-score
#> REYDREC: T-score
#> NACCMMSE: regression (nacc_legacy version)
#> BOSTON: regression (nacc_legacy version)
#> LOGIMEM: regression (nacc_legacy version)
#> MEMUNITS: regression (nacc_legacy version)
#> DIGIF: regression (nacc_legacy version)
#> DIGIFLEN: regression (nacc_legacy version)
#> DIGIB: regression (nacc_legacy version)
#> DIGIBLEN: regression (nacc_legacy version)
#> [1] "Using regression (updated_2025.06) for variable MOCATOTS"
#> [1] "Using regression (updated_2025.06) for variable OTRAILA"
#> [1] "Using regression (updated_2025.06) for variable OTRAILB"
#> [1] "Using regression (updated_2025.06) for variable OTRLARR"
#> [1] "Using regression (updated_2025.06) for variable OTRLBRR"
#> [1] "Using regression (updated_2025.06) for variable DIGFORCT"
#> [1] "Using regression (updated_2025.06) for variable DIGFORSL"
#> [1] "Using regression (updated_2025.06) for variable DIGBACCT"
#> [1] "Using regression (updated_2025.06) for variable DIGBACLS"
#> [1] "Using regression (updated_2025.06) for variable TRAILA"
#> [1] "Using regression (updated_2025.06) for variable TRAILB"
#> [1] "Using T-score (NA) for variable WAIS"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using regression (updated_2025.06) for variable MINTTOTS"
#> [1] "Using regression (updated_2025.06) for variable ANIMALS"
#> [1] "Using regression (updated_2025.06) for variable VEG"
#> [1] "Using regression (updated_2025.06) for variable UDSVERFC"
#> [1] "Using regression (updated_2025.06) for variable UDSVERLC"
#> [1] "Using regression (updated_2025.06) for variable UDSVERTN"
#> [1] "Using regression (updated_2025.06) for variable UDSBENTC"
#> [1] "Using regression (updated_2025.06) for variable UDSBENTD"
#> [1] "Using regression (updated_2025.06) for variable CRAFTVRS"
#> [1] "Using regression (updated_2025.06) for variable CRAFTURS"
#> [1] "Using regression (updated_2025.06) for variable CRAFTDVR"
#> [1] "Using regression (updated_2025.06) for variable CRAFTDRE"
#> [1] "Using T-score (NA) for variable REY1REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REY2REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REY3REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REY4REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REY5REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REY6REC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using T-score (NA) for variable REYDREC"
#> ! For T-scores, education must be a numeric vector of values between 8 and 20. Values outside this interval has been truncated.
#> ! For T-scores, age must be a numeric vector of values between 30 and 91. Values outside this range has been truncated.
#> [1] "Using regression (nacc_legacy) for variable NACCMMSE"
#> [1] "Using regression (nacc_legacy) for variable BOSTON"
#> [1] "Using regression (nacc_legacy) for variable LOGIMEM"
#> [1] "Using regression (nacc_legacy) for variable MEMUNITS"
#> [1] "Using regression (nacc_legacy) for variable DIGIF"
#> [1] "Using regression (nacc_legacy) for variable DIGIFLEN"
#> [1] "Using regression (nacc_legacy) for variable DIGIB"
#> [1] "Using regression (nacc_legacy) for variable DIGIBLEN"

head(demo_data_w_std)
#>       NACCID NACCAGE SEX EDUC BIRTHYR BIRTHMO VISITYR VISITMO VISITDAY RACE
#> 1 NACC074283      84   2   18    1927       3    2011      10        5    1
#> 2 NACC005366      65   2   16    1957       7    2023       5       10    1
#> 3 NACC005366      51   2   16    1957       7    2009       5       15    1
#> 4 NACC005366      56   2   16    1957       7    2013       9        4    1
#> 5 NACC005366      58   2   16    1957       7    2015      10       27    1
#> 6 NACC005366      62   2   16    1957       7    2020       1        5    1
#>   HANDED CDRGLOB MOCATOTS MOCBTOTS TRAILA TRAILARR TRAILALI OTRAILA OTRLARR
#> 1      2     1.0       -4       -4     27       -4       -4      -4      -4
#> 2      2     0.5       -4       -4     31        0       24      -4      -4
#> 3      2     0.5       -4       -4     27        0       24      -4      -4
#> 4      2     2.0       -4       -4    100        0       24      -4      -4
#> 5      2     0.0       -4       -4     30        0       24      -4      -4
#> 6      2     0.0       -4       -4    996        0       24      -4      -4
#>   DIGFORCT DIGFORSL DIGBACCT DIGBACLS WAIS MINTTOTS ANIMALS VEG UDSVERTN
#> 1       -4       -4       -4       -4    0       -4      26   3       -4
#> 2       -4       -4       -4       -4   49       -4      27  18       -4
#> 3       -4       -4       -4       -4   43       -4      23  21       -4
#> 4       -4       -4       -4       -4   51       -4      12  11       -4
#> 5       -4       -4       -4       -4   43       -4      22  17       -4
#> 6       -4       -4       -4       -4   38       -4      18   6       -4
#>   UDSVERFC UDSVERLC UDSBENTC UDSBENTD CRAFTVRS CRAFTURS CRAFTDVR CRAFTDRE
#> 1       -4       -4       -4       -4       -4       -4       -4       -4
#> 2       -4       -4       -4       -4       -4       -4       -4       -4
#> 3       -4       -4       -4       -4       -4       -4       -4       -4
#> 4       -4       -4       -4       -4       -4       -4       -4       -4
#> 5       -4       -4       -4       -4       -4       -4       -4       -4
#> 6       -4       -4       -4       -4       -4       -4       -4       -4
#>   REY1REC REY2REC REY3REC REY4REC REY5REC REY6REC REYDREC REYTCOR TRAILB
#> 1      -4      -4      -4      -4      -4      -4      -4      -4    150
#> 2      -4      -4      -4      -4      -4      -4      -4      -4     98
#> 3      -4      -4      -4      -4      -4      -4      -4      -4    996
#> 4      -4      -4      -4      -4      -4      -4      -4      -4    997
#> 5      -4      -4      -4      -4      -4      -4      -4      -4     39
#> 6      -4      -4      -4      -4      -4      -4      -4      -4    996
#>   TRAILBLI TRAILBRR MOCACLOC MOCACLOH MOCACLON OTRAILB OTRLBRR OTRLBLI NACCGDS
#> 1       -4       -4       -4       -4       -4      -4      -4      -4       1
#> 2       96        0       -4       -4       -4      -4      -4      -4       0
#> 3        6        1       -4       -4       -4      -4      -4      -4       1
#> 4       24        0       -4       -4       -4      -4      -4      -4      88
#> 5       24        0       -4       -4       -4      -4      -4      -4       5
#> 6       24        3       -4       -4       -4      -4      -4      -4       7
#>   CDRSUM UDSBENRS BILLS TAXES SHOPPING GAMES STOVE MEALPREP EVENTS PAYATTN
#> 1    2.0       -4     0     0        0     0     0        0      0       0
#> 2    8.0       -4     0     0        0     0     0        1      0       0
#> 3   13.0       -4     0     0        0     0     0        8      0       0
#> 4    2.5       -4     0     0        0     0     0        0      2       0
#> 5    0.0       -4     0     0        0     0     0        8      3       2
#> 6    0.0       -4     0     3        0     0     0        1      0       0
#>   REMDATES TRAVEL REYFPOS NACCUDSD NACCMMSE BOSTON LOGIMEM MEMUNITS MEMTIME
#> 1        2      0      -4        1       30     29      17        3      35
#> 2        0      0      -4        1       30     26      17        2      -4
#> 3        0      0      -4        1       30     24      16       13      18
#> 4        3      0      -4        4       29      3      17        5       8
#> 5        0      0      -4        4       28     27       3        0      10
#> 6        3      2      -4        1       20     28       9        0      21
#>   DIGIF DIGIFLEN DIGIB DIGIBLEN OTHCOG OTHCOGX OTHPSY  OTHPSYX COGOTH COGOTHIF
#> 1     8        3     3        5     -4              0               0        7
#> 2    97        6     8        4     -4              0               0        7
#> 3     6        5     8        4     -4              0               1        7
#> 4    10        6     4        7     -4              0               0        8
#> 5    10       96     3        5     -4              1 DYSTHMIA      0        7
#> 6    11        4     6        6     -4              0               0        7
#>     COGOTHX COGOTH2 COGOTH2F COGOTH2X COGOTH3 COGOTH3X ALCDEM ALCDEMIF ANXIET
#> 1                -4        8               -4               0        7     -4
#> 2                 0        8                0               0        8     -4
#> 3 delusions       0        8                0               0        7     -4
#> 4                 0        8                0               0        8     -4
#> 5                 0        7                0               0        8     -4
#> 6                 0        8                0               0        7     -4
#>   ANXIETIF BIPOLDX BIPOLDIF BRNINJ BRNINJIF CORT CORTIF CVD CVDIF DELIR DELIRIF
#> 1       -4      -4       -4      0        7    0      8  -4    -4    -4      -4
#> 2       -4      -4       -4      0        7    0      8  -4    -4    -4      -4
#> 3       -4      -4       -4      0        8    0      7  -4    -4    -4      -4
#> 4       -4      -4       -4      0        7    0      7  -4    -4    -4      -4
#> 5       -4      -4       -4      0        7    0      7  -4    -4    -4      -4
#> 6       -4      -4       -4      0        8    0      7  -4    -4    -4      -4
#>   DEMUN DEMUNIF DEP DEPIF DOWNS DOWNSIF DYSILL DYSILLIF EPILEP EPILEPIF ESSTREM
#> 1     8       7   0     8     0       8      0        8     -4       -4      -4
#> 2     8       8   0     7     0       8      0        7     -4       -4      -4
#> 3     0       8   0     8     0       7      0        7     -4       -4      -4
#> 4     0       7   0     8     0       8      0        8     -4       -4      -4
#> 5     8       8   1     7     0       7      0        8     -4       -4      -4
#> 6     8       8   0     7     0       8      0        2     -4       -4      -4
#>   ESSTREIF FTLDMO FTLDMOIF FTLDNOS FTLDNOIF HIV HIVIF HUNT HUNTIF HYCEPH
#> 1       -4     -4       -4      -4       -4  -4    -4    0      8      0
#> 2       -4     -4       -4      -4       -4  -4    -4    0      8      0
#> 3       -4     -4       -4      -4       -4  -4    -4    0      8      0
#> 4       -4     -4       -4      -4       -4  -4    -4    0      8      0
#> 5       -4     -4       -4      -4       -4  -4    -4    0      8      0
#> 6       -4     -4       -4      -4       -4  -4    -4    0      8      0
#>   HYCEPHIF IMPSUB IMPSUBIF MEDS MEDSIF MSA MSAIF NACCALZD NACCALZP NACCLBDE
#> 1        7     -4       -4    0      7  -4    -4        1        1        0
#> 2        7     -4       -4    0      8  -4    -4        8        7        0
#> 3        7     -4       -4    0      8  -4    -4        8        7        0
#> 4        8     -4       -4    0      8  -4    -4        1        7        8
#> 5        7     -4       -4    0      8  -4    -4        8        1        0
#> 6        7     -4       -4    0      8  -4    -4        8        1        8
#>   NACCLBDP NEOP NEOPIF OTHCOGIF OTHPSYIF POSSAD POSSADIF PPAPH PPAPHIF PRION
#> 1        7    0      8       -4        8      0        7     1       7     0
#> 2        7    0      8       -4        8      0        8     1       7     0
#> 3        7    0      7       -4        7      8        7     0       8     0
#> 4        7    0      7       -4        7      1        7     0       8     0
#> 5        7    0      8       -4        8      0        1     0       8     0
#> 6        7    0      8       -4        8      8        7     0       7     0
#>   PRIONIF PROBAD PROBADIF PSP PSPIF PTSDDX PTSDDXIF SCHIZOP SCHIZOIF STROKE
#> 1       8      0        7   0     7     -4       -4      -4       -4      0
#> 2       7      0        1   0     7     -4       -4      -4       -4      0
#> 3       8      8        7   0     8     -4       -4      -4       -4      0
#> 4       7      1        8   0     8     -4       -4      -4       -4      0
#> 5       7      1        8   0     8     -4       -4      -4       -4      0
#> 6       8      0        1   0     7     -4       -4      -4       -4      0
#>   STROKIF VASC VASCIF VASCPS VASCPSIF std_MOCATOTS std_OTRAILA std_OTRAILB
#> 1       7    0      7     -4       -4           NA          NA          NA
#> 2       7    0      1      8        7           NA          NA          NA
#> 3       2    8      8      8        8           NA          NA          NA
#> 4       8    0      8      8        8           NA          NA          NA
#> 5       7    8      7      0        7           NA          NA          NA
#> 6       7    0      8      8        7           NA          NA          NA
#>   std_OTRLARR std_OTRLBRR std_DIGFORCT std_DIGFORSL std_DIGBACCT std_DIGBACLS
#> 1          NA          NA           NA           NA           NA           NA
#> 2          NA          NA           NA           NA           NA           NA
#> 3          NA          NA           NA           NA           NA           NA
#> 4          NA          NA           NA           NA           NA           NA
#> 5          NA          NA           NA           NA           NA           NA
#> 6          NA          NA           NA           NA           NA           NA
#>   std_TRAILA  std_TRAILB  std_WAIS std_MINTTOTS std_ANIMALS    std_VEG
#> 1  0.9327959 -0.92475293  9.936317           NA   1.5198097 -2.9694400
#> 2  0.4104428  0.07781661 42.777352           NA   1.4784477  0.7508739
#> 3  0.3741602          NA 31.805875           NA   0.3697707  1.3280407
#> 4 -4.0658750          NA 42.616302           NA  -1.6828977 -1.1713856
#> 5  0.3300840  1.41022966 34.813298           NA   0.3330619  0.3973346
#> 6         NA          NA 32.437530           NA  -0.3633971 -2.3727536
#>   std_UDSVERFC std_UDSVERLC std_UDSVERTN std_UDSBENTC std_UDSBENTD std_CRAFTVRS
#> 1           NA           NA           NA           NA           NA           NA
#> 2           NA           NA           NA           NA           NA           NA
#> 3           NA           NA           NA           NA           NA           NA
#> 4           NA           NA           NA           NA           NA           NA
#> 5           NA           NA           NA           NA           NA           NA
#> 6           NA           NA           NA           NA           NA           NA
#>   std_CRAFTURS std_CRAFTDVR std_CRAFTDRE std_REY1REC std_REY2REC std_REY3REC
#> 1           NA           NA           NA          NA          NA          NA
#> 2           NA           NA           NA          NA          NA          NA
#> 3           NA           NA           NA          NA          NA          NA
#> 4           NA           NA           NA          NA          NA          NA
#> 5           NA           NA           NA          NA          NA          NA
#> 6           NA           NA           NA          NA          NA          NA
#>   std_REY4REC std_REY5REC std_REY6REC std_REYDREC std_NACCMMSE std_BOSTON
#> 1          NA          NA          NA          NA   0.95543662  0.3840990
#> 2          NA          NA          NA          NA   0.87774907 -0.7197370
#> 3          NA          NA          NA          NA   0.65008478 -1.6285342
#> 4          NA          NA          NA          NA  -0.07554362 -8.5591135
#> 5          NA          NA          NA          NA  -0.84995722 -0.5058981
#> 6          NA          NA          NA          NA  -7.24040690 -0.1030480
#>   std_LOGIMEM std_MEMUNITS  std_DIGIF std_DIGIFLEN  std_DIGIB std_DIGIBLEN
#> 1   0.8677302   -2.2377054 -0.4392518   -3.6153325 -1.9383563   -0.0234381
#> 2   0.9498944           NA         NA   -0.8234689  0.4591063   -0.8900199
#> 3   0.5953452    0.1181994 -1.6168298   -1.8600080  0.3102156   -1.0404520
#> 4   0.8944381   -1.8769464  0.4434189   -0.8922863 -1.5587380    1.5548131
#> 5  -2.8492126   -3.0847345  0.4641260           NA -2.0180001   -0.1180562
#> 6  -1.2148621   -2.9969492  1.0076606   -2.7053877 -0.5338633    0.7721042
```

Some scores are often summarized. For example, the MoCA clock is often
summed. We can use
[`add_derived_scores()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/add_derived_scores.md)
to add those of `REYTOTAL` (sum of `REY1REC`, …, `REY5REC`), `REYAREC`
(REY AVLT Accuracy), `FAS` (Functional Assessment Score summarized), and
`MOCACLOCK` (sum of `MOCACLON`, `MOCACLOC`, `MOCACLOH`) that can be
calculated based on the columns available.

``` r
demo_data_w_derived_scores <- add_derived_scores(
  demo_data
)

demo_data_w_derived_scores_w_std <- add_standardized_scores(
  demo_data_w_derived_scores, 
  sex = "SEX",
  education = "EDUC",
  age = "NACCAGE",
  race = "RACE",
  delay = "MEMTIME",
  print_messages = F
)
```

`demo_data_w_derived_scores_w_std` includes a few extra columns compared
to `demo_data_w_std` (only displaying first six rows):

``` r
exclusive_cols <- setdiff(
  colnames(demo_data_w_derived_scores_w_std),
  colnames(demo_data_w_std)
)

head(demo_data_w_derived_scores_w_std[exclusive_cols])
#>   REYTOTAL REYAREC FAS MOCACLOCK std_REYTOTAL std_REYAREC
#> 1       NA      NA   2        NA           NA          NA
#> 2       NA      NA   1        NA           NA          NA
#> 3       NA      NA   0        NA           NA          NA
#> 4       NA      NA   2        NA           NA          NA
#> 5       NA      NA   2        NA           NA          NA
#> 6       NA      NA   3        NA           NA          NA
```
