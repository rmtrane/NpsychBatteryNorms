library(shiny)
library(plotly)


all_vars <- c(
  "Animal Fluency" = "ANIMALS",
  "Boston Naming Test" = "BOSTON",
  "Craft Delay - Paraphrase" = "CRAFTDRE",
  "Craft Delay - Verbatim" = "CRAFTDVR",
  "Craft Immediate - Paraphrase" = "CRAFTURS",
  "Craft Immediate - Verbatim" = "CRAFTVRS",
  "Number Span Backward - Total" = "DIGBACCT",
  "Number Span Backward - Span Length" = "DIGBACLS",
  "Number Span Forward - Total" = "DIGFORCT",
  "Number Span Forward - Span Length" = "DIGFORSL",
  "Digit Span Backward - Total" = "DIGIB",
  "Digit Span Backward - Span Length" = "DIGIBLEN",
  "Digit Span Forward - Total" = "DIGIF",
  "Digit Span Forward - Span Length" = "DIGIFLEN",
  "Logical Memory, Immediate" = "LOGIMEM",
  "Logical Memory, Delayed" = "MEMUNITS",
  "MINT" = "MINTTOTS",
  "MoCA" = "MOCATOTS",
  "MMSE" = "NACCMMSE",
  'REY1REC',
  'REY2REC',
  'REY3REC',
  'REY4REC',
  'REY5REC',
  "RAVLT Short Delay" = "REY6REC",
  "RAVLT Recognition" = "REYAREC",
  "RAVLT Distractor List" = "REYDLIST",
  "RAVLT Long Delay" = "REYDREC",
  "RAVLT Total Learning" = "REYTOTAL",
  "Trailmaking Part A" = "TRAILA",
  "Trailmaking Part B" = "TRAILB",
  "Benson Figure Copy" = "UDSBENTC",
  "Benson Delay" = "UDSBENTD",
  "F Words" = "UDSVERFC",
  "L Words" = "UDSVERLC",
  'UDSVERTE',
  'UDSVERTI',
  "F+L Words" = "UDSVERTN",
  "Vegetable Fluency" = "VEG",
  "WAIS-R Digit Symbol" = "WAIS"
)

ui <- bslib::page_fluid(
  bslib::card(
    bslib::page_sidebar(
      sidebar = bslib::sidebar(
        shiny::selectInput(
          inputId = "var_name",
          label = "Score",
          choices = all_vars,
          selected = "ANIMALS"
        ),
        shiny::radioButtons(
          inputId = "sex",
          label = "Sex",
          choices = c("Male" = "m", "Female" = "f")
        ),
        shiny::selectInput(
          inputId = "x_var",
          label = "What would you like on the x-axis?",
          choices = c(
            "Raw Scores" = "raw_scores",
            "Education (years)" = "EDUC",
            "Age (years)" = "NACCAGE"
          )
        ),
        shiny::sliderInput(
          "raw_scores",
          label = "Raw Score",
          value = floor(median(rdd$ANIMALS$range)),
          min = rdd$ANIMALS$range[1],
          max = rdd$ANIMALS$range[2],
          step = 1
        ),
        shiny::sliderInput(
          "educ",
          label = "Education (years)",
          value = 14,
          min = 0,
          max = 31,
          step = 1
        ),
        shiny::sliderInput(
          "age",
          label = "Age (years)",
          value = 58,
          min = 18,
          max = 120,
          step = 1
        ),
        shiny::conditionalPanel(
          "input.var_name == 'MEMUNITS'",
          shiny::sliderInput(
            inputId = "delay",
            label = "Length of Delay (minutes)",
            min = 25,
            value = 25,
            max = 35
          )
        ),
        # uiOutput("other_selections")
      ),
      plotlyOutput("plot") #, height = "500px", fill = FALSE)
    )
  )
)
