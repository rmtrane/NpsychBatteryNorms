# Package index

## Standardizing Scores

Functions to standardize scores.

- [`std_scores()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores.md)
  : Standardize Raw Cognitive Scores to Z-Scores
- [`std_scores_using_T()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_T.md)
  : Standardized Scores using T-scores
- [`std_scores_using_norms()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_norms.md)
  : Standardized Scores using Norms
- [`std_scores_using_regression()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_scores_using_regression.md)
  : Standardize Raw Cognitive Scores using Regression Models
- [`add_standardized_scores()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/add_standardized_scores.md)
  [`add_standardized_scores_dt()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/add_standardized_scores.md)
  : Add Standardized Scores to Data

## Data and Code Objects

Data sets and code objects used for standardizing scores, to help
translate variable names from/to Mayo Normative Studies to/from NACC,
and other helper objects.

- [`demo_data`](https://rmtrane.github.io/NpsychBatteryNorms/reference/demo_data.md)
  : Demo Data
- [`normative_summaries`](https://rmtrane.github.io/NpsychBatteryNorms/reference/normative_summaries.md)
  : Means and SDs for calculating z-scores
- [`rdd`](https://rmtrane.github.io/NpsychBatteryNorms/reference/rdd.md)
  : Researchers Data Dictionary in List Form
- [`reg_coefs`](https://rmtrane.github.io/NpsychBatteryNorms/reference/reg_coefs.md)
  : Regression Coefficients for Regression Based Standardization
- [`ss`](https://rmtrane.github.io/NpsychBatteryNorms/reference/ss.md) :
  Scaled Scores lookup tables from Mayo Normative Studies
- [`t_score_coefs`](https://rmtrane.github.io/NpsychBatteryNorms/reference/t_score_coefs.md)
  : Regression Coefficients for T-score Based Standardization
- [`default_methods`](https://rmtrane.github.io/NpsychBatteryNorms/reference/default_methods.md)
  : Default Standardization Methods
- [`mns_to_nacc`](https://rmtrane.github.io/NpsychBatteryNorms/reference/mns_to_nacc.md)
  : Translate NACC variable names to Mayo Normative Study variable names
- [`nacc_to_mns`](https://rmtrane.github.io/NpsychBatteryNorms/reference/nacc_to_mns.md)
  : Translate Mayo Normative Study variable names to NACC variable names

## Helper Functions

Various functions to be used for intermediate steps, such as calculate
summary scores (FAS, MOCA clock, REY AVLT Accuracy/Total), find the age
group needed for standardizing, look up scaled scores for T-score
calculations, remove invalid scores using the Researchers Data
Dictionary (RDD) published by NACC, replace raw score values with labels
using the RDD published by NACC.

- [`add_derived_scores()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/add_derived_scores.md)
  : Add Scores Calculated from Raw NACC Scores
- [`calculate_fas()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/calculate_fas.md)
  : Calcaulate Functional Assessment Score summary
- [`calculate_mocaclock()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/calculate_mocaclock.md)
  : Calculate MoCA clock drawing test total
- [`calculate_reyarec()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/calculate_reyarec.md)
  : Calculate the Rey AVLT Accuracy
- [`calculate_reytotal()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/calculate_reytotal.md)
  : Calculate Rey AVLT Total score
- [`get_age_group()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/get_age_group.md)
  : Get Age Group for Standardized Scores
- [`get_educ_group()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/get_educ_group.md)
  : Get education group
- [`get_race_group()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/get_race_group.md)
  : Get Race Group for Standardized Scores
- [`get_ss_score()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/get_ss_score.md)
  : Get Scaled Scores for use in T-score cacluations
- [`valid_values_only()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/valid_values_only.md)
  : Replace values with labels
- [`values_to_labels()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/values_to_labels.md)
  : Replace codes with labels
- [`std_methods()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/std_methods.md)
  : Explore Implemented Methods and Combination with Variables
- [`methods_from_std_data()`](https://rmtrane.github.io/NpsychBatteryNorms/reference/methods_from_std_data.md)
  : Helper to extract methods from standardized columns
