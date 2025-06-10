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

plot_std_scores <- function(
  x_var = "EDUC",
  var_name = "ANIMALS",
  raw_score = 25,
  education = 14,
  age = 58,
  sex = "m",
  delay = 0
) {
  methods_avail <- subset(
    NpsychBatteryNorms::std_methods(var_name = var_name),
    available == 1
  )
  methods_avail$label <- with(methods_avail, {
    ifelse(
      is.na(version),
      method,
      paste(method, " (", version, ")", sep = "")
    )
  })

  methods_avail$colors <- c(
    "#E69F00",
    "#56B4E9",
    "#009E73",
    "#F0E442",
    "#0072B2",
    "#D55E00",
    "#CC79A7",
    "#999999"
  )[1:nrow(methods_avail)]

  if (x_var == "raw_scores") {
    dat <- data.frame(
      x_var = seq(
        from = NpsychBatteryNorms::rdd[[var_name]]$range[1],
        to = NpsychBatteryNorms::rdd[[var_name]]$range[2],
        by = 1
      )
    )

    for (i in 1:nrow(methods_avail)) {
      std_var_name <- paste(
        "std",
        methods_avail$method[i],
        methods_avail$version[i],
        sep = "_"
      )

      dat[[std_var_name]] <- std_scores(
        dat$x_var,
        var_name = var_name,
        education = rep(education, nrow(dat)),
        age = rep(age, nrow(dat)),
        sex = rep(sex, nrow(dat)),
        delay = rep(delay, nrow(dat)),
        method = methods_avail$method[i],
        version = methods_avail$version[i],
        print_messages = F
      )

      attr(dat[[std_var_name]], "label") <- methods_avail$label[i]
      attr(dat[[std_var_name]], "color") <- methods_avail$colors[i]
      attr(dat[[std_var_name]], "group") <- methods_avail$method[i]
    }
  }

  if (x_var == "EDUC") {
    dat <- data.frame(
      x_var = seq(
        from = 0,
        to = 31,
        by = 1
      )
    )

    for (i in 1:nrow(methods_avail)) {
      std_var_name <- paste(
        "std",
        methods_avail$method[i],
        methods_avail$version[i],
        sep = "_"
      )

      dat[[std_var_name]] <- std_scores(
        raw_scores = rep(raw_score, nrow(dat)),
        var_name = var_name,
        education = dat$x_var,
        age = rep(age, nrow(dat)),
        sex = rep(sex, nrow(dat)),
        delay = rep(delay, nrow(dat)),
        method = methods_avail$method[i],
        version = methods_avail$version[i],
        print_messages = F
      )

      attr(dat[[std_var_name]], "label") <- methods_avail$label[i]
      attr(dat[[std_var_name]], "color") <- methods_avail$colors[i]
      attr(dat[[std_var_name]], "group") <- methods_avail$method[i]
    }
  }

  if (x_var == "NACCAGE") {
    dat <- data.frame(
      x_var = seq(
        from = rdd[["NACCAGE"]]$range[1],
        to = rdd[["NACCAGE"]]$range[2],
        by = 1
      )
    )

    for (i in 1:nrow(methods_avail)) {
      std_var_name <- paste(
        "std",
        methods_avail$method[i],
        methods_avail$version[i],
        sep = "_"
      )

      dat[[std_var_name]] <- std_scores(
        raw_scores = rep(raw_score, nrow(dat)),
        var_name = var_name,
        education = rep(education, nrow(dat)),
        age = dat$x_var,
        sex = rep(sex, nrow(dat)),
        delay = rep(delay, nrow(dat)),
        method = methods_avail$method[i],
        version = methods_avail$version[i],
        print_messages = F
      )

      attr(dat[[std_var_name]], "label") <- methods_avail$label[i]
      attr(dat[[std_var_name]], "color") <- methods_avail$colors[i]
      attr(dat[[std_var_name]], "group") <- methods_avail$method[i]
    }
  }

  t_scores <- grep("T-score", x = colnames(dat), value = TRUE)

  for (t_score in t_scores) {
    dat[[t_score]] <- (dat[[t_score]] - 50) / 10
  }

  all_stds <- grep(
    colnames(dat),
    pattern = "^std_",
    ignore.case = TRUE,
    value = TRUE
  )

  x_var_label <- switch(
    x_var,
    "raw_scores" = "Raw score",
    "EDUC" = "Education (years)",
    "NACCAGE" = "Age (years)"
  )

  for (cur_std in all_stds) {
    if (cur_std == all_stds[1]) {
      p <- plotly::plot_ly(data = dat)
    }

    p <- p |>
      plotly::add_trace(
        x = ~x_var,
        type = "scatter",
        mode = "lines",
        y = dat[[cur_std]],
        name = attr(dat[[cur_std]], "label"),
        color = I(attr(dat[[cur_std]], "color")),
        line = list(
          shape = if (grepl("norm", cur_std) & x_var != "raw_scores") "hv"
        ),
        text = attr(dat[[cur_std]], "label"),
        legendgroup = attr(dat[[cur_std]], "label"),
        # legend = c(
        #   "norms" = "legend",
        #   "regression" = "legend2",
        #   "T-score" = "legend3"
        # )[attr(dat[[cur_std]], "group")],
        # hovertemplate = paste0(
        #   "%{text}",
        #   "<br>",
        #   x_var_label, ": %{x}<br>",
        #   "Std. score: %{y}<br>",
        #   "<extra></extra>"
        # )
        hovertemplate = "%{y}"
      ) |>
      plotly::add_trace(
        x = c("EDUC" = education, "NACCAGE" = age, "raw_scores" = raw_score)[
          x_var
        ],
        y = dat[[cur_std]][
          dat$x_var ==
            c("EDUC" = education, "NACCAGE" = age, "raw_scores" = raw_score)[
              x_var
            ]
        ],
        type = "scatter",
        mode = "markers",
        color = I(attr(dat[[cur_std]], "color")),
        legendgroup = attr(dat[[cur_std]], "label"),
        hoverinfo = "skip",
        showlegend = FALSE
      )
  }

  p |>
    plotly::layout(
      title = paste("Standardized Scores for", var_name),
      showlegend = TRUE,
      legend = list(
        y = -0.2,
        orientation = "h"
      ),
      xaxis = list(
        title = x_var_label
      ),
      yaxis = list(
        title = "Standardized Score",
        hoverformat = ".3f"
      )
    ) |>
    plotly::config(
      displayModeBar = T,
      modeBarButtonsToRemove = c(
        "sendDataToCloud",
        "toImage",
        "editInChartStudio",
        "zoom2d",
        "select2d",
        "lasso2d",
        "autoScale2d",
        "zoomIn2d",
        "zoomOut2d",
        "pan"
      ),
      modeBarButtonsToAdd = "toggleHover",
      displaylogo = FALSE
    )
}


server <- function(input, output, session) {
  ## Update the raw_scores slider based on the selected variable
  shiny::observe({
    req(input$var_name)

    all_vars_wh <- all_vars[all_vars == input$var_name]

    if (!is.null(all_vars_wh)) {
      cur_label <- names(all_vars_wh)
    } else {
      cur_label = input$var_name
    }

    shiny::updateSliderInput(
      inputId = "raw_scores",
      label = cur_label,
      value = floor(median(rdd[[input$var_name]]$range)),
      min = rdd[[input$var_name]]$range[1],
      max = rdd[[input$var_name]]$range[2]
    )
  })

  output$plot <- renderPlotly({
    plot_std_scores(
      x_var = input$x_var,
      var_name = input$var_name,
      raw_score = input$raw_scores,
      education = input$educ,
      age = input$age,
      sex = input$sex,
      delay = if (is.null(input$delay)) 0 else input$delay
    )
  })
}
