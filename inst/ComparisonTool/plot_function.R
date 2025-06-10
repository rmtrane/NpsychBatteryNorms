plot_std_scores <- function(
  x_var = "EDUC",
  var_name = "ANIMALS",
  raw_score = 25,
  education = 14,
  age = 58,
  sex = "m",
  delay = 0
) {
  methods_avail <- subset(std_methods(var_name = var_name), available == 1)
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
        from = rdd[[var_name]]$range[1],
        to = rdd[[var_name]]$range[2],
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
      print(i)
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
        showlegend = FALSE,
        hoverinfo = "skip"
      )
  }

  p |>
    plotly::layout(
      # title = paste("Standardized Scores for", var_name),
      legend = list(
        y = 1.15,
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
