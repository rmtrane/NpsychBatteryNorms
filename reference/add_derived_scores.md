# Add Scores Calculated from Raw NACC Scores

Add calculated scores to a data set with NACC variables.

## Usage

``` r
add_derived_scores(dat)
```

## Arguments

- dat:

  `data.frame` or `tibble` or `data.table`

## Value

Copy of the input data with the additional variables

- `REYTOTAL` if `REY1REC`, `REY2REC`, `REY3REC`, `REY4REC`, `REY5REC`
  are all columns in input

- `REYAREC` if `REYTCOR` and `REYFPOS` are both columns in the input (if
  `REYTNEG` is present instead of `REYFPOS`, then the latter is added
  first before `REYAREC`)

- `FAS` if `BILLS`, `TAXES`, `SHOPPING`, `GAMES`, `STOVE`, `MEALPREP`,
  `EVENTS`, `PAYATTN`, `REMDATES`, `TRAVEL` are all columns in the input

- `MOCACLOCK` if `MOCACLON`, `MOCACLOC`, `MOCACLOH` are all columns in
  the input

## Examples

``` r
add_derived_scores(demo_data)
#>          NACCID NACCAGE   SEX  EDUC BIRTHYR BIRTHMO VISITYR VISITMO VISITDAY
#>          <char>   <num> <num> <num>   <num>   <num>   <num>   <num>    <num>
#>   1: NACC074283      84     2    18    1927       3    2011      10        5
#>   2: NACC005366      65     2    16    1957       7    2023       5       10
#>   3: NACC005366      51     2    16    1957       7    2009       5       15
#>   4: NACC005366      56     2    16    1957       7    2013       9        4
#>   5: NACC005366      58     2    16    1957       7    2015      10       27
#>  ---                                                                        
#> 340: NACC005149      91     2    18    1924       8    2016       3       21
#> 341: NACC005149      89     2    18    1924       8    2013      10       11
#> 342: NACC005149      92     2    18    1924       8    2016      10       22
#> 343: NACC005149      83     2    18    1924       8    2008       2       28
#> 344: NACC005149      91     2    18    1924       8    2016       6       11
#>       RACE HANDED CDRGLOB MOCATOTS MOCBTOTS TRAILA TRAILARR TRAILALI OTRAILA
#>      <num>  <num>   <num>    <num>    <num>  <num>    <num>    <num>   <num>
#>   1:     1      2     1.0       -4       -4     27       -4       -4      -4
#>   2:     1      2     0.5       -4       -4     31        0       24      -4
#>   3:     1      2     0.5       -4       -4     27        0       24      -4
#>   4:     1      2     2.0       -4       -4    100        0       24      -4
#>   5:     1      2     0.0       -4       -4     30        0       24      -4
#>  ---                                                                        
#> 340:     1      2     2.0       -4       -4     73        0       24      -4
#> 341:     1      2     0.5       -4       -4    997        0       24      -4
#> 342:     1      2     0.0       -4       -4     73        0       96      -4
#> 343:     1      2     0.0       -4       -4     40        0       24      -4
#> 344:     1      2     0.0       -4       -4     23        0       24      -4
#>      OTRLARR DIGFORCT DIGFORSL DIGBACCT DIGBACLS  WAIS MINTTOTS ANIMALS   VEG
#>        <num>    <num>    <num>    <num>    <num> <num>    <num>   <num> <num>
#>   1:      -4       -4       -4       -4       -4     0       -4      26     3
#>   2:      -4       -4       -4       -4       -4    49       -4      27    18
#>   3:      -4       -4       -4       -4       -4    43       -4      23    21
#>   4:      -4       -4       -4       -4       -4    51       -4      12    11
#>   5:      -4       -4       -4       -4       -4    43       -4      22    17
#>  ---                                                                         
#> 340:      -4       -4       -4       -4       -4    59       -4      15     6
#> 341:      -4       -4       -4       -4       -4    59       -4      22    12
#> 342:      -4       -4       -4       -4       -4    -4       -4      19     5
#> 343:      -4       -4       -4       -4       -4    -4       -4      31     6
#> 344:      -4       -4       -4       -4       -4    -4       -4      18    15
#>      UDSVERTN UDSVERFC UDSVERLC UDSBENTC UDSBENTD CRAFTVRS CRAFTURS CRAFTDVR
#>         <num>    <num>    <num>    <num>    <num>    <num>    <num>    <num>
#>   1:       -4       -4       -4       -4       -4       -4       -4       -4
#>   2:       -4       -4       -4       -4       -4       -4       -4       -4
#>   3:       -4       -4       -4       -4       -4       -4       -4       -4
#>   4:       -4       -4       -4       -4       -4       -4       -4       -4
#>   5:       -4       -4       -4       -4       -4       -4       -4       -4
#>  ---                                                                        
#> 340:       -4       -4       -4       -4       -4       -4       -4       -4
#> 341:       -4       -4       -4       -4       -4       -4       -4       -4
#> 342:       31       22       18       13        9       -4       -4       -4
#> 343:       15       23       22       14       13       -4       -4       -4
#> 344:       16       16        7       17        7       -4       -4       -4
#>      CRAFTDRE REY1REC REY2REC REY3REC REY4REC REY5REC REY6REC REYDREC REYTCOR
#>         <num>   <num>   <num>   <num>   <num>   <num>   <num>   <num>   <num>
#>   1:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>   2:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>   3:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>   4:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>   5:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>  ---                                                                         
#> 340:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 341:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 342:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 343:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#> 344:       -4      -4      -4      -4      -4      -4      -4      -4      -4
#>      TRAILB TRAILBLI TRAILBRR MOCACLOC MOCACLOH MOCACLON OTRAILB OTRLBRR
#>       <num>    <num>    <num>    <num>    <num>    <num>   <num>   <num>
#>   1:    150       -4       -4       -4       -4       -4      -4      -4
#>   2:     98       96        0       -4       -4       -4      -4      -4
#>   3:    996        6        1       -4       -4       -4      -4      -4
#>   4:    997       24        0       -4       -4       -4      -4      -4
#>   5:     39       24        0       -4       -4       -4      -4      -4
#>  ---                                                                    
#> 340:     97       24        1       -4       -4       -4      -4      -4
#> 341:     77       24        6       -4       -4       -4      -4      -4
#> 342:     50       24        0       -4       -4       -4      -4      -4
#> 343:     51       24        1       -4       -4       -4      -4      -4
#> 344:    300       24        5       -4       -4       -4      -4      -4
#>      OTRLBLI NACCGDS CDRSUM UDSBENRS BILLS TAXES SHOPPING GAMES STOVE MEALPREP
#>        <num>   <num>  <num>    <num> <num> <num>    <num> <num> <num>    <num>
#>   1:      -4       1    2.0       -4     0     0        0     0     0        0
#>   2:      -4       0    8.0       -4     0     0        0     0     0        1
#>   3:      -4       1   13.0       -4     0     0        0     0     0        8
#>   4:      -4      88    2.5       -4     0     0        0     0     0        0
#>   5:      -4       5    0.0       -4     0     0        0     0     0        8
#>  ---                                                                          
#> 340:      -4       1    0.0       -4     1     0        0     0     0        0
#> 341:      -4      10    0.0       -4     8     8        0     8     0        0
#> 342:      -4       5    6.0        1     0     3        0     0     1        0
#> 343:      -4       0    3.5        1     1     0        0     0     0        1
#> 344:      -4       3    0.0        1     0     0        0     3     0        3
#>      EVENTS PAYATTN REMDATES TRAVEL REYFPOS NACCUDSD NACCMMSE BOSTON LOGIMEM
#>       <num>   <num>    <num>  <num>   <num>    <num>    <num>  <num>   <num>
#>   1:      0       0        2      0      -4        1       30     29      17
#>   2:      0       0        0      0      -4        1       30     26      17
#>   3:      0       0        0      0      -4        1       30     24      16
#>   4:      2       0        3      0      -4        4       29      3      17
#>   5:      3       2        0      0      -4        4       28     27       3
#>  ---                                                                        
#> 340:      0       0        0      3      -4        1       29     95      15
#> 341:      0       0        2      3      -4        4       30     29       6
#> 342:      0       0        0      3      -4        1       30     14      13
#> 343:      0       0        0      3      -4        4       25     30       6
#> 344:      0       0        0      2      -4        3       28      8      15
#>      MEMUNITS MEMTIME DIGIF DIGIFLEN DIGIB DIGIBLEN OTHCOG OTHCOGX OTHPSY
#>         <num>   <num> <num>    <num> <num>    <num>  <num>  <char>  <num>
#>   1:        3      35     8        3     3        5     -4              0
#>   2:        2      -4    97        6     8        4     -4              0
#>   3:       13      18     6        5     8        4     -4              0
#>   4:        5       8    10        6     4        7     -4              0
#>   5:        0      10    10       96     3        5     -4              1
#>  ---                                                                     
#> 340:       12      21     8        8    96        3     -4              0
#> 341:       15      26     6        7     0        3     -4              0
#> 342:        0      30     7       97     6        5      0              0
#> 343:       12      15     7        6     7        6      0              0
#> 344:       16      18     7        6     6        5      0              0
#>       OTHPSYX COGOTH COGOTHIF         COGOTHX COGOTH2 COGOTH2F COGOTH2X COGOTH3
#>        <char>  <num>    <num>          <char>   <num>    <num>   <char>   <num>
#>   1:               0        7                      -4        8               -4
#>   2:               0        7                       0        8                0
#>   3:               1        7       delusions       0        8                0
#>   4:               0        8                       0        8                0
#>   5: DYSTHMIA      0        7                       0        7                0
#>  ---                                                                           
#> 340:               0        8                       0        8                0
#> 341:               1        8 B 12 Deficiency       0        8                0
#> 342:               0        8                       0        7                0
#> 343:               0        7                       0        7                0
#> 344:               0        7                       0        8                0
#>      COGOTH3X ALCDEM ALCDEMIF ANXIET ANXIETIF BIPOLDX BIPOLDIF BRNINJ BRNINJIF
#>        <char>  <num>    <num>  <num>    <num>   <num>    <num>  <num>    <num>
#>   1:               0        7     -4       -4      -4       -4      0        7
#>   2:               0        8     -4       -4      -4       -4      0        7
#>   3:               0        7     -4       -4      -4       -4      0        8
#>   4:               0        8     -4       -4      -4       -4      0        7
#>   5:               0        8     -4       -4      -4       -4      0        7
#>  ---                                                                          
#> 340:               8        7     -4       -4      -4       -4      0        8
#> 341:               0        8     -4       -4      -4       -4      0        7
#> 342:               8        8      0        7       0        7      0        7
#> 343:               0        7      0        7       0        8      0        7
#> 344:               0        8      0        8       0        8      0        8
#>       CORT CORTIF   CVD CVDIF DELIR DELIRIF DEMUN DEMUNIF   DEP DEPIF DOWNS
#>      <num>  <num> <num> <num> <num>   <num> <num>   <num> <num> <num> <num>
#>   1:     0      8    -4    -4    -4      -4     8       7     0     8     0
#>   2:     0      8    -4    -4    -4      -4     8       8     0     7     0
#>   3:     0      7    -4    -4    -4      -4     0       8     0     8     0
#>   4:     0      7    -4    -4    -4      -4     0       7     0     8     0
#>   5:     0      7    -4    -4    -4      -4     8       8     1     7     0
#>  ---                                                                       
#> 340:     0      7    -4    -4    -4      -4     0       8     0     3     0
#> 341:     0      8    -4    -4    -4      -4     0       8     0     8     0
#> 342:     0      7     0     7     0       7    -4      -4     0     7     0
#> 343:     0      7     0     7     0       8    -4      -4     0     8     0
#> 344:     0      8     0     8     0       7    -4      -4     0     8     0
#>      DOWNSIF DYSILL DYSILLIF EPILEP EPILEPIF ESSTREM ESSTREIF FTLDMO FTLDMOIF
#>        <num>  <num>    <num>  <num>    <num>   <num>    <num>  <num>    <num>
#>   1:       8      0        8     -4       -4      -4       -4     -4       -4
#>   2:       8      0        7     -4       -4      -4       -4     -4       -4
#>   3:       7      0        7     -4       -4      -4       -4     -4       -4
#>   4:       8      0        8     -4       -4      -4       -4     -4       -4
#>   5:       7      0        8     -4       -4      -4       -4     -4       -4
#>  ---                                                                         
#> 340:       7      0        8     -4       -4      -4       -4     -4       -4
#> 341:       8      0        7     -4       -4      -4       -4     -4       -4
#> 342:       7      0        7      0        7       0        8      0        7
#> 343:       8      0        8      0        8       0        8      0        7
#> 344:       8      0        7      0        7       0        7      0        8
#>      FTLDNOS FTLDNOIF   HIV HIVIF  HUNT HUNTIF HYCEPH HYCEPHIF IMPSUB IMPSUBIF
#>        <num>    <num> <num> <num> <num>  <num>  <num>    <num>  <num>    <num>
#>   1:      -4       -4    -4    -4     0      8      0        7     -4       -4
#>   2:      -4       -4    -4    -4     0      8      0        7     -4       -4
#>   3:      -4       -4    -4    -4     0      8      0        7     -4       -4
#>   4:      -4       -4    -4    -4     0      8      0        8     -4       -4
#>   5:      -4       -4    -4    -4     0      8      0        7     -4       -4
#>  ---                                                                          
#> 340:      -4       -4    -4    -4     0      7      0        7     -4       -4
#> 341:      -4       -4    -4    -4     0      7      0        8     -4       -4
#> 342:       0        8     0     8     0      8      0        7      0        8
#> 343:       0        8     0     7     0      8      0        8      0        7
#> 344:       0        7     0     8     0      7      0        7      0        7
#>       MEDS MEDSIF   MSA MSAIF NACCALZD NACCALZP NACCLBDE NACCLBDP  NEOP NEOPIF
#>      <num>  <num> <num> <num>    <num>    <num>    <num>    <num> <num>  <num>
#>   1:     0      7    -4    -4        1        1        0        7     0      8
#>   2:     0      8    -4    -4        8        7        0        7     0      8
#>   3:     0      8    -4    -4        8        7        0        7     0      7
#>   4:     0      8    -4    -4        1        7        8        7     0      7
#>   5:     0      8    -4    -4        8        1        0        7     0      8
#>  ---                                                                          
#> 340:     0      8    -4    -4        1        1        8        8     0      8
#> 341:     0      8    -4    -4        8        1        8        7     0      7
#> 342:     0      8     0     8        0        8        8        8     0      8
#> 343:     0      7     0     7        8        8        0        8     0      8
#> 344:     0      8     0     7        0        7        0        3     0      8
#>      OTHCOGIF OTHPSYIF POSSAD POSSADIF PPAPH PPAPHIF PRION PRIONIF PROBAD
#>         <num>    <num>  <num>    <num> <num>   <num> <num>   <num>  <num>
#>   1:       -4        8      0        7     1       7     0       8      0
#>   2:       -4        8      0        8     1       7     0       7      0
#>   3:       -4        7      8        7     0       8     0       8      8
#>   4:       -4        7      1        7     0       8     0       7      1
#>   5:       -4        8      0        1     0       8     0       7      1
#>  ---                                                                     
#> 340:       -4        7      0        7     0       8     0       7      1
#> 341:       -4        8      8        8     0       7     0       7      8
#> 342:        8        7     -4       -4    -4      -4     0       7     -4
#> 343:        8        7     -4       -4    -4      -4     0       8     -4
#> 344:        7        8     -4       -4    -4      -4     0       7     -4
#>      PROBADIF   PSP PSPIF PTSDDX PTSDDXIF SCHIZOP SCHIZOIF STROKE STROKIF  VASC
#>         <num> <num> <num>  <num>    <num>   <num>    <num>  <num>   <num> <num>
#>   1:        7     0     7     -4       -4      -4       -4      0       7     0
#>   2:        1     0     7     -4       -4      -4       -4      0       7     0
#>   3:        7     0     8     -4       -4      -4       -4      0       2     8
#>   4:        8     0     8     -4       -4      -4       -4      0       8     0
#>   5:        8     0     8     -4       -4      -4       -4      0       7     8
#>  ---                                                                           
#> 340:        8     0     7     -4       -4      -4       -4      0       8     0
#> 341:        1     0     8     -4       -4      -4       -4      0       8     0
#> 342:       -4     0     8      0        8       0        8     -4      -4    -4
#> 343:       -4     0     8      0        7       0        8     -4      -4    -4
#> 344:       -4     0     8      0        8       0        8     -4      -4    -4
#>      VASCIF VASCPS VASCPSIF REYTOTAL REYAREC   FAS MOCACLOCK
#>       <num>  <num>    <num>    <num>   <num> <num>     <num>
#>   1:      7     -4       -4       NA      NA     2        NA
#>   2:      1      8        7       NA      NA     1        NA
#>   3:      8      8        8       NA      NA     0        NA
#>   4:      8      8        8       NA      NA     2        NA
#>   5:      7      0        7       NA      NA     2        NA
#>  ---                                                        
#> 340:      7      8        8       NA      NA     1        NA
#> 341:      7      8        8       NA      NA     2        NA
#> 342:     -4     -4       -4       NA      NA     1        NA
#> 343:     -4     -4       -4       NA      NA     2        NA
#> 344:     -4     -4       -4       NA      NA     2        NA
```
