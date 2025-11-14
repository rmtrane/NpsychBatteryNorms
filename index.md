# NpsychBatteryNorms

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
> Licence](https://rmtrane.github.io/NpsychBatteryNorms/LICENSE.md),
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
```

``` R
[1] -2.192308
```

# Supported Cognitive Scores and Methods

See
[here](https://rmtrane.github.io/NpsychBatteryNorms/articles/supported_cog_scores_and_methods.md)
for a complete table of supported cognitive scores and methods
implemented for standardizing.

For more details, see the [Get started
page](https://rmtrane.github.io/NpsychBatteryNorms/articles/NpsychBatteryNorms.md)
