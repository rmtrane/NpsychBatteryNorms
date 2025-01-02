

# NpsychBatteryNorms

NpsychBatteryNorms lets you easily calculate normative scores for a wide
variety of neuropsychological tests using various methods.

## Installation

``` r
# Install remotes if not already installed
install.packages("remotes")
remotes::install_github("rmtrane/NpsychBatteryNorms")
```

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
```

    [1] -2.192308

We can standardize this score using various methods. For a table showing
the methods implemented, use `implemented_std_methods`. This shows which
method/ version combos are available (1) and which are not (0):

``` r
implemented_std_methods("MOCATOTS")
```

          method version available
    1      norms    nacc         1
    2      norms updated         1
    3 regression    nacc         1
    4 regression updated         1
    5    T-score    <NA>         0

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
```

    [1] -2.324629

## For Analysis

In a more realistic use case, we have data on a number of patients in a
data set. One such example is the NACC data, that is obtainable from
https://www.naccdata.org. We include a demo data set for you to explore
(see `?demo_data` for more).

``` r
head(demo_data)
```

          NACCID NACCAGE SEX EDUC BIRTHYR BIRTHMO VISITYR VISITMO VISITDAY RACE
    1 NACC092228      59   1    9    1954      11    2013       6       30    1
    2 NACC036444      81   2   20    1928       6    2009       6        2    2
    3 NACC075933      61   2   99    1962       8    2023      12       11    1
    4 NACC075933      60   2   99    1962       8    2008       3        7    1
    5 NACC054763      97   2   14    1919       1    2016       3        2    1
    6 NACC054763      75   2   14    1919       1    2009      12        5    1
      CDRGLOB MOCATOTS MOCBTOTS TRAILA TRAILARR TRAILALI OTRAILA OTRLARR DIGFORCT
    1     0.5       24       -4     31        0       24      -4      -4       97
    2     0.0       -4       -4     44        0       24      -4      -4       -4
    3     0.5       -4       -4     56       96       24      -4      -4       -4
    4     0.5       -4       -4    150        0       24      -4      -4       -4
    5     0.0       -4       -4     38        0       24      -4      -4       -4
    6     0.5       -4       -4     67       97       24      -4      -4       -4
      DIGFORSL DIGBACCT DIGBACLS WAIS MINTTOTS ANIMALS VEG UDSVERTN UDSVERFC
    1        7        8       97   -4       28      18  19       25       15
    2       -4       -4       -4    0       -4      96  10       -4       -4
    3       -4       -4       -4   42       -4      17   8       -4       -4
    4       -4       -4       -4   97       -4      13   6       -4       -4
    5       -4       -4       -4   21       -4      12  11       -4       -4
    6       -4       -4       -4   14       -4      10  15       -4       -4
      UDSVERLC UDSBENTC UDSBENTD CRAFTVRS CRAFTURS CRAFTDVR CRAFTDRE REY1REC
    1        6       97       11       97       15       12        1      -4
    2       -4       -4       -4       -4       -4       -4       -4      -4
    3       -4       -4       -4       -4       -4       -4       -4      -4
    4       -4       -4       -4       -4       -4       -4       -4      -4
    5       -4       -4       -4       -4       -4       -4       -4      -4
    6       -4       -4       -4       -4       -4       -4       -4      -4
      REY2REC REY3REC REY4REC REY5REC REY6REC REYDREC REYTCOR TRAILB TRAILBLI
    1      -4      -4      -4      -4      -4      -4      -4    997       24
    2      -4      -4      -4      -4      -4      -4      -4     65       97
    3      -4      -4      -4      -4      -4      -4      -4     63       24
    4      -4      -4      -4      -4      -4      -4      -4    170       24
    5      -4      -4      -4      -4      -4      -4      -4     73       24
    6      -4      -4      -4      -4      -4      -4      -4     65       24
      TRAILBRR MOCACLOC MOCACLOH MOCACLON OTRAILB OTRLBRR OTRLBLI NACCGDS CDRSUM
    1        4        1        0        1      -4      -4      -4       3   18.0
    2        0       -4       -4       -4      -4      -4      -4       0    0.5
    3        0       -4       -4       -4      -4      -4      -4       9   16.0
    4       96       -4       -4       -4      -4      -4      -4       0   16.0
    5        7       -4       -4       -4      -4      -4      -4       0    0.5
    6        3       -4       -4       -4      -4      -4      -4       1    0.5
      UDSBENRS BILLS TAXES SHOPPING GAMES STOVE MEALPREP EVENTS PAYATTN REMDATES
    1        1     0     0        0     2     0        0      0       1        0
    2       -4     3     8        0     3     0        0      0       0        2
    3       -4     0     0        0     0     0        0      1       0        0
    4       -4     8     3        3     0     0        0      0       0        0
    5       -4     3     0        3     2     0        0      0       1        0
    6       -4     8     0        0     0     0        0      0       2        2
      TRAVEL REYFPOS NACCUDSD NACCMMSE BOSTON LOGIMEM MEMUNITS MEMTIME DIGIF
    1      0      -4        1       -4     -4      -4       -4      -4    -4
    2      0      -4        1       28     14       2       97      -4     8
    3      0      -4        4       29     23       1       12      20     6
    4      0      -4        3       29     11      15        5      20    10
    5      0      -4        1       25     27       8       15      17    97
    6      2      -4        4       29     26       8       18      30     8
      DIGIFLEN DIGIB DIGIBLEN OTHCOG OTHCOGX OTHPSY OTHPSYX COGOTH COGOTHIF
    1       -4    -4       -4      0              0              1        7
    2        8     8       97     -4              0              1        8
    3        5     3        7      0              0              0        7
    4        4     6       98      0              0              0        8
    5        6     5        5     -4              0              0        8
    6        8     0        2     -4              0              0        7
                                                       COGOTHX COGOTH2 COGOTH2F
    1 some ? Parkinsonian signs of uncertain clin significance       0        7
    2                                          lecunar infarct       0        8
    3                                                                0        8
    4                                                                0        7
    5                                                                0        8
    6                                                                0        8
      COGOTH2X COGOTH3 COGOTH3X ALCDEM ALCDEMIF ANXIET ANXIETIF BIPOLDX BIPOLDIF
    1                0               0        8      0        7       0        7
    2                0               8        7     -4       -4      -4       -4
    3                0               0        8      0        8       0        7
    4                0               0        7      0        8       0        7
    5                0               0        8     -4       -4      -4       -4
    6                0               0        8     -4       -4      -4       -4
      BRNINJ BRNINJIF CORT CORTIF CVD CVDIF DELIR DELIRIF DEMUN DEMUNIF DEP DEPIF
    1      0        8    0      8   0     8     0       7    -4      -4   1     8
    2      0        8    0      7  -4    -4    -4      -4     0       7   0     2
    3      0        7    0      7   0     8     0       8    -4      -4   0     8
    4      0        8    0      8   0     7     0       7    -4      -4   0     7
    5      0        8    0      8  -4    -4    -4      -4     0       7   0     7
    6      0        8    0      8  -4    -4    -4      -4     8       8   0     7
      DOWNS DOWNSIF DYSILL DYSILLIF EPILEP EPILEPIF ESSTREM ESSTREIF FTLDMO
    1     0       8      0        8      0        7       0        7      0
    2     0       8      0        8     -4       -4      -4       -4     -4
    3     0       8      0        7      0        7       0        7      0
    4     0       7      0        8      0        7       0        7      0
    5     0       8      0        7     -4       -4      -4       -4     -4
    6     0       8      0        7     -4       -4      -4       -4     -4
      FTLDMOIF FTLDNOS FTLDNOIF HIV HIVIF HUNT HUNTIF HYCEPH HYCEPHIF IMPSUB
    1        8       0        8   0     7    0      7      0        8      0
    2       -4      -4       -4  -4    -4    0      7      0        8     -4
    3        7       0        8   0     7    0      7      0        8      0
    4        7       0        8   0     7    0      7      0        7      0
    5       -4      -4       -4  -4    -4    0      8      0        7     -4
    6       -4      -4       -4  -4    -4    0      7      0        7     -4
      IMPSUBIF MEDS MEDSIF MSA MSAIF NACCALZD NACCALZP NACCLBDE NACCLBDP NEOP
    1        8    0      8   0     8        8        7        8        7    0
    2       -4    0      7  -4    -4        0        8        0        7    0
    3        7    0      8   0     8        0        7        8        8    0
    4        7    0      8   0     7        8        1        8        8    0
    5       -4    0      7  -4    -4        8        8        0        8    0
    6       -4    0      7  -4    -4        8        8        8        8    0
      NEOPIF OTHCOGIF OTHPSYIF POSSAD POSSADIF PPAPH PPAPHIF PRION PRIONIF PROBAD
    1      8        8        8     -4       -4    -4      -4     0       8     -4
    2      8       -4        8      0        7     8       7     0       7      1
    3      8        8        8     -4       -4    -4      -4     0       8     -4
    4      8        8        7     -4       -4    -4      -4     0       7     -4
    5      8       -4        8      8        7     0       8     0       8      1
    6      7       -4        8      8        8     0       8     0       8      8
      PROBADIF PSP PSPIF PTSDDX PTSDDXIF SCHIZOP SCHIZOIF STROKE STROKIF VASC
    1       -4   0     7      0        8       0        8     -4      -4   -4
    2        1   0     8     -4       -4      -4       -4      0       7    8
    3       -4   0     7      0        7       0        8     -4      -4   -4
    4       -4   0     8      0        7       0        7     -4      -4   -4
    5        7   0     8     -4       -4      -4       -4      0       8    8
    6        8   0     8     -4       -4      -4       -4      0       7    8
      VASCIF VASCPS VASCPSIF
    1     -4     -4       -4
    2      7      0        8
    3     -4     -4       -4
    4     -4     -4       -4
    5      8      8        8
    6      7      0        8

We can calculate all standardized scores in one go and have them added
to the data as `std_{var_name}`:

``` r
demo_data_w_std <- add_standardized_scores(demo_data)
```

    'methods' not specified. Will use the following defaults:

    MOCATOTS: regression (nacc version)
    OTRAILA: regression (updated version)
    OTRAILB: regression (updated version)
    OTRLARR: regression (updated version)
    OTRLBRR: regression (updated version)
    DIGFORCT: regression (nacc version)
    DIGFORSL: regression (nacc version)
    DIGBACCT: regression (nacc version)
    DIGBACLS: regression (nacc version)
    TRAILA: regression (nacc version)
    TRAILB: regression (nacc version)
    WAIS: T-score
    MINTTOTS: regression (nacc version)
    ANIMALS: regression (nacc version)
    VEG: regression (nacc version)
    UDSVERFC: regression (nacc version)
    UDSVERLC: regression (nacc version)
    UDSVERTN: regression (nacc version)
    UDSBENTC: regression (nacc version)
    UDSBENTD: regression (nacc version)
    CRAFTVRS: regression (nacc version)
    CRAFTURS: regression (nacc version)
    CRAFTDVR: regression (nacc version)
    CRAFTDRE: regression (nacc version)
    REY1REC: T-score
    REY2REC: T-score
    REY3REC: T-score
    REY4REC: T-score
    REY5REC: T-score
    REY6REC: T-score
    REYDREC: T-score
    NACCMMSE: regression (nacc version)
    BOSTON: regression (nacc version)
    LOGIMEM: regression (nacc version)
    MEMUNITS: regression (nacc version)
    DIGIF: regression (nacc version)
    DIGIFLEN: regression (nacc version)
    DIGIB: regression (nacc version)
    DIGIBLEN: regression (nacc version)

    [1] "Using regression (nacc) for variable MOCATOTS"
    [1] "Using regression (updated) for variable OTRAILA"
    [1] "Using regression (updated) for variable OTRAILB"
    [1] "Using regression (updated) for variable OTRLARR"
    [1] "Using regression (updated) for variable OTRLBRR"
    [1] "Using regression (nacc) for variable DIGFORCT"
    [1] "Using regression (nacc) for variable DIGFORSL"
    [1] "Using regression (nacc) for variable DIGBACCT"
    [1] "Using regression (nacc) for variable DIGBACLS"
    [1] "Using regression (nacc) for variable TRAILA"
    [1] "Using regression (nacc) for variable TRAILB"
    [1] "Using T-score (NA) for variable WAIS"
    [1] "Using regression (nacc) for variable MINTTOTS"
    [1] "Using regression (nacc) for variable ANIMALS"
    [1] "Using regression (nacc) for variable VEG"
    [1] "Using regression (nacc) for variable UDSVERFC"
    [1] "Using regression (nacc) for variable UDSVERLC"
    [1] "Using regression (nacc) for variable UDSVERTN"
    [1] "Using regression (nacc) for variable UDSBENTC"
    [1] "Using regression (nacc) for variable UDSBENTD"
    [1] "Using regression (nacc) for variable CRAFTVRS"
    [1] "Using regression (nacc) for variable CRAFTURS"
    [1] "Using regression (nacc) for variable CRAFTDVR"
    [1] "Using regression (nacc) for variable CRAFTDRE"
    [1] "Using T-score (NA) for variable REY1REC"
    [1] "Using T-score (NA) for variable REY2REC"
    [1] "Using T-score (NA) for variable REY3REC"
    [1] "Using T-score (NA) for variable REY4REC"
    [1] "Using T-score (NA) for variable REY5REC"
    [1] "Using T-score (NA) for variable REY6REC"
    [1] "Using T-score (NA) for variable REYDREC"
    [1] "Using regression (nacc) for variable NACCMMSE"
    [1] "Using regression (nacc) for variable BOSTON"
    [1] "Using regression (nacc) for variable LOGIMEM"
    [1] "Using regression (nacc) for variable MEMUNITS"
    [1] "Using regression (nacc) for variable DIGIF"
    [1] "Using regression (nacc) for variable DIGIFLEN"
    [1] "Using regression (nacc) for variable DIGIB"
    [1] "Using regression (nacc) for variable DIGIBLEN"

``` r
head(demo_data_w_std)
```

          NACCID NACCAGE SEX EDUC BIRTHYR BIRTHMO VISITYR VISITMO VISITDAY RACE
    1 NACC092228      59   1    9    1954      11    2013       6       30    1
    2 NACC036444      81   2   20    1928       6    2009       6        2    2
    3 NACC075933      61   2   99    1962       8    2023      12       11    1
    4 NACC075933      60   2   99    1962       8    2008       3        7    1
    5 NACC054763      97   2   14    1919       1    2016       3        2    1
    6 NACC054763      75   2   14    1919       1    2009      12        5    1
      CDRGLOB MOCATOTS MOCBTOTS TRAILA TRAILARR TRAILALI OTRAILA OTRLARR DIGFORCT
    1     0.5       24       -4     31        0       24      -4      -4       97
    2     0.0       -4       -4     44        0       24      -4      -4       -4
    3     0.5       -4       -4     56       96       24      -4      -4       -4
    4     0.5       -4       -4    150        0       24      -4      -4       -4
    5     0.0       -4       -4     38        0       24      -4      -4       -4
    6     0.5       -4       -4     67       97       24      -4      -4       -4
      DIGFORSL DIGBACCT DIGBACLS WAIS MINTTOTS ANIMALS VEG UDSVERTN UDSVERFC
    1        7        8       97   -4       28      18  19       25       15
    2       -4       -4       -4    0       -4      96  10       -4       -4
    3       -4       -4       -4   42       -4      17   8       -4       -4
    4       -4       -4       -4   97       -4      13   6       -4       -4
    5       -4       -4       -4   21       -4      12  11       -4       -4
    6       -4       -4       -4   14       -4      10  15       -4       -4
      UDSVERLC UDSBENTC UDSBENTD CRAFTVRS CRAFTURS CRAFTDVR CRAFTDRE REY1REC
    1        6       97       11       97       15       12        1      -4
    2       -4       -4       -4       -4       -4       -4       -4      -4
    3       -4       -4       -4       -4       -4       -4       -4      -4
    4       -4       -4       -4       -4       -4       -4       -4      -4
    5       -4       -4       -4       -4       -4       -4       -4      -4
    6       -4       -4       -4       -4       -4       -4       -4      -4
      REY2REC REY3REC REY4REC REY5REC REY6REC REYDREC REYTCOR TRAILB TRAILBLI
    1      -4      -4      -4      -4      -4      -4      -4    997       24
    2      -4      -4      -4      -4      -4      -4      -4     65       97
    3      -4      -4      -4      -4      -4      -4      -4     63       24
    4      -4      -4      -4      -4      -4      -4      -4    170       24
    5      -4      -4      -4      -4      -4      -4      -4     73       24
    6      -4      -4      -4      -4      -4      -4      -4     65       24
      TRAILBRR MOCACLOC MOCACLOH MOCACLON OTRAILB OTRLBRR OTRLBLI NACCGDS CDRSUM
    1        4        1        0        1      -4      -4      -4       3   18.0
    2        0       -4       -4       -4      -4      -4      -4       0    0.5
    3        0       -4       -4       -4      -4      -4      -4       9   16.0
    4       96       -4       -4       -4      -4      -4      -4       0   16.0
    5        7       -4       -4       -4      -4      -4      -4       0    0.5
    6        3       -4       -4       -4      -4      -4      -4       1    0.5
      UDSBENRS BILLS TAXES SHOPPING GAMES STOVE MEALPREP EVENTS PAYATTN REMDATES
    1        1     0     0        0     2     0        0      0       1        0
    2       -4     3     8        0     3     0        0      0       0        2
    3       -4     0     0        0     0     0        0      1       0        0
    4       -4     8     3        3     0     0        0      0       0        0
    5       -4     3     0        3     2     0        0      0       1        0
    6       -4     8     0        0     0     0        0      0       2        2
      TRAVEL REYFPOS NACCUDSD NACCMMSE BOSTON LOGIMEM MEMUNITS MEMTIME DIGIF
    1      0      -4        1       -4     -4      -4       -4      -4    -4
    2      0      -4        1       28     14       2       97      -4     8
    3      0      -4        4       29     23       1       12      20     6
    4      0      -4        3       29     11      15        5      20    10
    5      0      -4        1       25     27       8       15      17    97
    6      2      -4        4       29     26       8       18      30     8
      DIGIFLEN DIGIB DIGIBLEN OTHCOG OTHCOGX OTHPSY OTHPSYX COGOTH COGOTHIF
    1       -4    -4       -4      0              0              1        7
    2        8     8       97     -4              0              1        8
    3        5     3        7      0              0              0        7
    4        4     6       98      0              0              0        8
    5        6     5        5     -4              0              0        8
    6        8     0        2     -4              0              0        7
                                                       COGOTHX COGOTH2 COGOTH2F
    1 some ? Parkinsonian signs of uncertain clin significance       0        7
    2                                          lecunar infarct       0        8
    3                                                                0        8
    4                                                                0        7
    5                                                                0        8
    6                                                                0        8
      COGOTH2X COGOTH3 COGOTH3X ALCDEM ALCDEMIF ANXIET ANXIETIF BIPOLDX BIPOLDIF
    1                0               0        8      0        7       0        7
    2                0               8        7     -4       -4      -4       -4
    3                0               0        8      0        8       0        7
    4                0               0        7      0        8       0        7
    5                0               0        8     -4       -4      -4       -4
    6                0               0        8     -4       -4      -4       -4
      BRNINJ BRNINJIF CORT CORTIF CVD CVDIF DELIR DELIRIF DEMUN DEMUNIF DEP DEPIF
    1      0        8    0      8   0     8     0       7    -4      -4   1     8
    2      0        8    0      7  -4    -4    -4      -4     0       7   0     2
    3      0        7    0      7   0     8     0       8    -4      -4   0     8
    4      0        8    0      8   0     7     0       7    -4      -4   0     7
    5      0        8    0      8  -4    -4    -4      -4     0       7   0     7
    6      0        8    0      8  -4    -4    -4      -4     8       8   0     7
      DOWNS DOWNSIF DYSILL DYSILLIF EPILEP EPILEPIF ESSTREM ESSTREIF FTLDMO
    1     0       8      0        8      0        7       0        7      0
    2     0       8      0        8     -4       -4      -4       -4     -4
    3     0       8      0        7      0        7       0        7      0
    4     0       7      0        8      0        7       0        7      0
    5     0       8      0        7     -4       -4      -4       -4     -4
    6     0       8      0        7     -4       -4      -4       -4     -4
      FTLDMOIF FTLDNOS FTLDNOIF HIV HIVIF HUNT HUNTIF HYCEPH HYCEPHIF IMPSUB
    1        8       0        8   0     7    0      7      0        8      0
    2       -4      -4       -4  -4    -4    0      7      0        8     -4
    3        7       0        8   0     7    0      7      0        8      0
    4        7       0        8   0     7    0      7      0        7      0
    5       -4      -4       -4  -4    -4    0      8      0        7     -4
    6       -4      -4       -4  -4    -4    0      7      0        7     -4
      IMPSUBIF MEDS MEDSIF MSA MSAIF NACCALZD NACCALZP NACCLBDE NACCLBDP NEOP
    1        8    0      8   0     8        8        7        8        7    0
    2       -4    0      7  -4    -4        0        8        0        7    0
    3        7    0      8   0     8        0        7        8        8    0
    4        7    0      8   0     7        8        1        8        8    0
    5       -4    0      7  -4    -4        8        8        0        8    0
    6       -4    0      7  -4    -4        8        8        8        8    0
      NEOPIF OTHCOGIF OTHPSYIF POSSAD POSSADIF PPAPH PPAPHIF PRION PRIONIF PROBAD
    1      8        8        8     -4       -4    -4      -4     0       8     -4
    2      8       -4        8      0        7     8       7     0       7      1
    3      8        8        8     -4       -4    -4      -4     0       8     -4
    4      8        8        7     -4       -4    -4      -4     0       7     -4
    5      8       -4        8      8        7     0       8     0       8      1
    6      7       -4        8      8        8     0       8     0       8      8
      PROBADIF PSP PSPIF PTSDDX PTSDDXIF SCHIZOP SCHIZOIF STROKE STROKIF VASC
    1       -4   0     7      0        8       0        8     -4      -4   -4
    2        1   0     8     -4       -4      -4       -4      0       7    8
    3       -4   0     7      0        7       0        8     -4      -4   -4
    4       -4   0     8      0        7       0        7     -4      -4   -4
    5        7   0     8     -4       -4      -4       -4      0       8    8
    6        8   0     8     -4       -4      -4       -4      0       7    8
      VASCIF VASCPS VASCPSIF std_MOCATOTS std_OTRAILA std_OTRAILB std_OTRLARR
    1     -4     -4       -4   -0.2542688          NA          NA          NA
    2      7      0        8           NA          NA          NA          NA
    3     -4     -4       -4           NA          NA          NA          NA
    4     -4     -4       -4           NA          NA          NA          NA
    5      8      8        8           NA          NA          NA          NA
    6      7      0        8           NA          NA          NA          NA
      std_OTRLBRR std_DIGFORCT std_DIGFORSL std_DIGBACCT std_DIGBACLS  std_TRAILA
    1          NA           NA    0.5338442    0.7266355           NA -0.09330274
    2          NA           NA           NA           NA           NA -1.13208564
    3          NA           NA           NA           NA           NA          NA
    4          NA           NA           NA           NA           NA          NA
    5          NA           NA           NA           NA           NA  0.49773852
    6          NA           NA           NA           NA           NA -3.11114457
      std_TRAILB  std_WAIS std_MINTTOTS std_ANIMALS     std_VEG std_UDSVERFC
    1         NA        NA    -0.590358  -0.1853085  1.65613730    0.5848894
    2  0.3666435  5.622808           NA          NA -1.60461635           NA
    3         NA        NA           NA          NA          NA           NA
    4         NA        NA           NA          NA          NA           NA
    5  1.4876229 28.481136           NA  -0.8639460 -0.55926368           NA
    6  0.8069952  7.345643           NA  -1.8670165 -0.01816922           NA
      std_UDSVERLC std_UDSVERTN std_UDSBENTC std_UDSBENTD std_CRAFTVRS std_CRAFTURS
    1    -1.236212     0.199503           NA    -0.178848           NA   0.06316819
    2           NA           NA           NA           NA           NA           NA
    3           NA           NA           NA           NA           NA           NA
    4           NA           NA           NA           NA           NA           NA
    5           NA           NA           NA           NA           NA           NA
    6           NA           NA           NA           NA           NA           NA
      std_CRAFTDVR std_CRAFTDRE std_REY1REC std_REY2REC std_REY3REC std_REY4REC
    1    -0.838189    -3.086177          NA          NA          NA          NA
    2           NA           NA          NA          NA          NA          NA
    3           NA           NA          NA          NA          NA          NA
    4           NA           NA          NA          NA          NA          NA
    5           NA           NA          NA          NA          NA          NA
    6           NA           NA          NA          NA          NA          NA
      std_REY5REC std_REY6REC std_REYDREC std_NACCMMSE std_BOSTON std_LOGIMEM
    1          NA          NA          NA           NA         NA          NA
    2          NA          NA          NA   -0.9385082 -4.9042249   -3.374252
    3          NA          NA          NA           NA         NA          NA
    4          NA          NA          NA           NA         NA          NA
    5          NA          NA          NA   -2.4052754  0.3892271   -1.068244
    6          NA          NA          NA    0.4647148 -0.3229142   -1.203804
      std_MEMUNITS  std_DIGIF std_DIGIFLEN  std_DIGIB std_DIGIBLEN
    1           NA         NA           NA         NA           NA
    2           NA -0.6386431    0.8605021  0.2355319           NA
    3           NA         NA           NA         NA           NA
    4           NA         NA           NA         NA           NA
    5     1.007911         NA   -0.4301093 -0.4453011    0.4857608
    6     1.604904 -0.1957730    1.2606500 -3.0819332   -2.2921720

Some scores are often summarized. For example, the MoCA clock is often
summed. We can use `add_derived_scores()` to add those of `REYTOTAL`
(sum of `REY1REC`, …, `REY5REC`), `REYAREC` (REY AVLT Accuracy), `FAS`
(Functional Assessment Score summarized), and `MOCACLOCK` (sum of
`MOCACLON`, `MOCACLOC`, `MOCACLOH`) that can be calculated based on the
columns available.

``` r
demo_data_w_derived_scores <- add_derived_scores(demo_data)
demo_data_w_derived_scores_w_std <- add_standardized_scores(demo_data_w_derived_scores)
```

    'methods' not specified. Will use the following defaults:

    MOCATOTS: regression (nacc version)
    OTRAILA: regression (updated version)
    OTRAILB: regression (updated version)
    OTRLARR: regression (updated version)
    OTRLBRR: regression (updated version)
    DIGFORCT: regression (nacc version)
    DIGFORSL: regression (nacc version)
    DIGBACCT: regression (nacc version)
    DIGBACLS: regression (nacc version)
    TRAILA: regression (nacc version)
    TRAILB: regression (nacc version)
    WAIS: T-score
    MINTTOTS: regression (nacc version)
    ANIMALS: regression (nacc version)
    VEG: regression (nacc version)
    UDSVERFC: regression (nacc version)
    UDSVERLC: regression (nacc version)
    UDSVERTN: regression (nacc version)
    UDSBENTC: regression (nacc version)
    UDSBENTD: regression (nacc version)
    CRAFTVRS: regression (nacc version)
    CRAFTURS: regression (nacc version)
    CRAFTDVR: regression (nacc version)
    CRAFTDRE: regression (nacc version)
    REY1REC: T-score
    REY2REC: T-score
    REY3REC: T-score
    REY4REC: T-score
    REY5REC: T-score
    REY6REC: T-score
    REYDREC: T-score
    REYTOTAL: T-score
    REYAREC: T-score
    NACCMMSE: regression (nacc version)
    BOSTON: regression (nacc version)
    LOGIMEM: regression (nacc version)
    MEMUNITS: regression (nacc version)
    DIGIF: regression (nacc version)
    DIGIFLEN: regression (nacc version)
    DIGIB: regression (nacc version)
    DIGIBLEN: regression (nacc version)

    [1] "Using regression (nacc) for variable MOCATOTS"
    [1] "Using regression (updated) for variable OTRAILA"
    [1] "Using regression (updated) for variable OTRAILB"
    [1] "Using regression (updated) for variable OTRLARR"
    [1] "Using regression (updated) for variable OTRLBRR"
    [1] "Using regression (nacc) for variable DIGFORCT"
    [1] "Using regression (nacc) for variable DIGFORSL"
    [1] "Using regression (nacc) for variable DIGBACCT"
    [1] "Using regression (nacc) for variable DIGBACLS"
    [1] "Using regression (nacc) for variable TRAILA"
    [1] "Using regression (nacc) for variable TRAILB"
    [1] "Using T-score (NA) for variable WAIS"
    [1] "Using regression (nacc) for variable MINTTOTS"
    [1] "Using regression (nacc) for variable ANIMALS"
    [1] "Using regression (nacc) for variable VEG"
    [1] "Using regression (nacc) for variable UDSVERFC"
    [1] "Using regression (nacc) for variable UDSVERLC"
    [1] "Using regression (nacc) for variable UDSVERTN"
    [1] "Using regression (nacc) for variable UDSBENTC"
    [1] "Using regression (nacc) for variable UDSBENTD"
    [1] "Using regression (nacc) for variable CRAFTVRS"
    [1] "Using regression (nacc) for variable CRAFTURS"
    [1] "Using regression (nacc) for variable CRAFTDVR"
    [1] "Using regression (nacc) for variable CRAFTDRE"
    [1] "Using T-score (NA) for variable REY1REC"
    [1] "Using T-score (NA) for variable REY2REC"
    [1] "Using T-score (NA) for variable REY3REC"
    [1] "Using T-score (NA) for variable REY4REC"
    [1] "Using T-score (NA) for variable REY5REC"
    [1] "Using T-score (NA) for variable REY6REC"
    [1] "Using T-score (NA) for variable REYDREC"
    [1] "Using T-score (NA) for variable REYTOTAL"
    [1] "Using T-score (NA) for variable REYAREC"
    [1] "Using regression (nacc) for variable NACCMMSE"
    [1] "Using regression (nacc) for variable BOSTON"
    [1] "Using regression (nacc) for variable LOGIMEM"
    [1] "Using regression (nacc) for variable MEMUNITS"
    [1] "Using regression (nacc) for variable DIGIF"
    [1] "Using regression (nacc) for variable DIGIFLEN"
    [1] "Using regression (nacc) for variable DIGIB"
    [1] "Using regression (nacc) for variable DIGIBLEN"

`demo_data_w_derived_scores_w_std` includes a few extra columns compared
to `demo_data_w_std`:

``` r
head(
  demo_data_w_derived_scores_w_std[
    colnames(demo_data_w_derived_scores_w_std)[!colnames(demo_data_w_derived_scores_w_std) %in% colnames(demo_data_w_std)]
  ]
)
```

      REYTOTAL REYAREC FAS MOCACLOCK std_REYTOTAL std_REYAREC
    1       NA      NA   3         2           NA          NA
    2       NA      NA   2        NA           NA          NA
    3       NA      NA   1        NA           NA          NA
    4       NA      NA   0        NA           NA          NA
    5       NA      NA   3        NA           NA          NA
    6       NA      NA   6        NA           NA          NA
