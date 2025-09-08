#' Add Standardized Scores to Data
#'
#' This functions adds a plethora of standardized scores to a dataset containing
#' raw scores. This function uses the `data.table` package to modify the input
#' data without creating a copy. As such, the input is modified in place. If
#' you require a copy of the input, make sure to create this first.
#'
#' @param dat `data.table` holding the data
#' @param sex string specifying column with sex. Column should be a character
#'   vector with entries "m" (for male) or "f" (for female)
#' @param education string specifying column with years of education. Column
#'   should be a numeric vector.
#' @param age string specifying column with age (in years). Column should be
#'   a numeric vector.
#' @param race string specifying column with race. Column should be numeric vector with values following the NACC RDD (see `?rdd` for details, and `rdd$RACE` for specifics to the race variable.)
#' @param delay string specifying column with delay (in minutes). Column should
#'   be a numeric vector. Used when standardizing `MEMUNITS` ("Logical Memory, Delayed")
#' @param methods NULL (default) or list of named entries specifying which model to use
#'   for standardizing cognitive scores. If NULL, defaults are applied for all
#'   variables in the dataset for which methods have been implemented (see `NpsychBatteryNorms::default_methods`)
#' @param rename_raw_scores logical; if TRUE, columns with raw scores are renamed
#'   by adding the prefix "raw_" to the column name.
#' @param print_messages logical; should messages be printed? If TRUE (default), a message will
#'   be print with the methods used if methods is omitted (or NULL)
#'
#' @returns Returns the input data with additional columns of the form `std_varname`
#'   with the standardized values for variable `varname`
#'
#' @rdname add_standardized_scores
#'
#' @examples
#'
#' ## Create copy to compare to modify
#' new_demo_data <- data.table::copy(demo_data)
#'
#' ## Add std_ cols
#' add_standardized_scores_dt(new_demo_data)
#'
#' ## Check number of columns of data w/ standardized scores
#' ncol(new_demo_data)
#' ## Check number of columns of original demo_data
#' ncol(demo_data)
#'
#' @export

add_standardized_scores_dt <- function(
  dat,
  sex = "SEX",
  education = "EDUC",
  age = "NACCAGE",
  race = "RACE",
  delay = "MEMTIME",
  methods = NULL,
  rename_raw_scores = F,
  print_messages = T
) {
  ## For debugging...
  if (FALSE) {
    sex <- "SEX"
    education <- "EDUC"
    age <- "NACCAGE"
    delay <- "MEMTIME"
    race <- "RACE"
  }

  if (!data.table::is.data.table(dat)) {
    cli::cli_abort(
      "{.arg dat} must be of class {.cls data.table}, but is {.cls {class(dat)}}."
    )
  }

  ## If nothing is passed to methods...
  if (is.null(methods)) {
    # ... retrieve the default methods
    methods <- NpsychBatteryNorms::default_methods

    # Remove methods for things not present in supplied data
    methods <- methods[names(methods) %in% colnames(dat)]

    # Stop
    stopifnot("No known variables found in the data" = length(methods) > 0)

    if (print_messages) {
      message("'methods' not specified. Will use the following defaults:")

      message(
        sapply(X = 1:length(methods), \(i) {
          # print(i)
          cur_entry <- methods[[i]]

          if (sum(!is.na(cur_entry)) == 2) {
            paste0(
              names(methods)[i],
              ": ",
              cur_entry[["method"]],
              " (",
              cur_entry[["version"]],
              " version)\n"
            )
          } else {
            paste0(names(methods)[i], ": ", cur_entry[["method"]], "\n")
          }
        })
      )
    }
  } else {
    stopifnot("'methods' must be a list" = is.list(methods))

    stopifnot(
      "'methods' must be named with names corresponding to variables to standardize" = !is.null(names(
        methods
      )) &
        all(names(methods) %in% colnames(dat))
    )

    ## Valid methods?
    invalid_methods <- unlist(lapply(names(methods), \(var) {
      !var %in%
        std_methods(
          method = methods[[var]][["method"]],
          version = methods[[var]][["version"]]
        )
    }))

    if (any(invalid_methods)) {
      invals <- methods[which(invalid_methods)]

      cli::cli_abort(
        message = c(
          "x" = "The methods specified for the following are invalid:",
          setNames(
            paste0(
              names(invals),
              " (",
              lapply(invals, paste, collapse = ", "),
              ")"
            ),
            rep("i", length(invals))
          )
        )
      )
    }
  }

  # dat <- data.frame(dat)
  # s <- dat[[sex]]

  # data.table::setnames(
  #   dat,
  #   c(sex, education, age, race, delay),
  #   c("SEX", "EDUC", "AGE", "RACE", "DELAY"),
  #   skip_absent = TRUE
  # )

  data.table::set(
    dat,
    j = "new_SEX",
    value = tolower(substr(
      values_to_labels(valid_values_only(dat[[sex]], "SEX", T), "SEX"),
      1,
      1
    ))
  )
  data.table::set(
    dat,
    j = "new_AGE",
    value = valid_values_only(dat[[age]], "NACCAGE", T)
  )
  data.table::set(
    dat,
    j = "new_EDUC",
    value = valid_values_only(dat[[education]], "EDUC", T)
  )
  data.table::set(dat, j = "new_RACE", value = get_race_group(dat[[race]]))
  data.table::set(
    dat,
    j = "new_DELAY",
    value = if (is.null(delay)) {
      0
    } else {
      valid_values_only(dat[[delay]], "MEMTIME", T)
    }
  )

  for (i in seq_along(methods)) {
    var <- names(methods)[i]
    specs <- methods[[i]]

    if (print_messages) {
      print(paste0(
        "Using ",
        specs["method"],
        " (",
        specs["version"],
        ") for variable ",
        var
      ))
    }

    data.table::set(
      dat,
      j = paste0("std_", var),
      value = std_scores(
        raw_scores = dat[[var]],
        var_name = var,
        education = dat$new_EDUC,
        age = dat$new_AGE,
        sex = dat$new_SEX,
        race = dat$new_RACE,
        delay = dat$new_DELAY,
        method = methods[[var]][["method"]],
        version = methods[[var]][["version"]],
        print_messages = print_messages
      )
    )

    ## Add attribute to std_{var} specifying the method used.
    data.table::setattr(
      dat[[paste("std", var, sep = "_")]],
      "method",
      specs[["method"]]
    )

    ## Add attribute to std_{var} specifying the version used (if)
    if (!is.na(specs[["version"]])) {
      data.table::setattr(
        dat[[paste("std", var, sep = "_")]],
        "version",
        specs[["version"]]
      )
    }
  }

  for (var in names(dat)[grepl("^new_", names(dat))]) {
    data.table::set(dat, j = var, value = NULL)
  }

  ## Rename column with raw scores to raw_var, if specified to do so
  if (rename_raw_scores) {
    data.table::setnames(
      dat,
      old = names(methods),
      new = paste("raw", names(methods), sep = "_")
    )
  }

  return(dat)
}
