test_that("implemented_std_methods", {
  ## Make sure output is data.frame
  expect_s3_class(
    implemented_std_methods("MOCATOTS"),
    class = "data.frame"
  )

  ## All variable names that have std methods implemented
  vars <- unique(c(
    names(normative_scores_2020),
    names(normative_scores_2024),
    reg_coefs$nacc$var_name,
    reg_coefs$updated_2024$var_name,
    names(t_score_coefs)
  ))

  ## For each var, get methods implemented, and make sure output 
  ## is as expected. That is, make sure the methods/versions
  ## combos marked as available are actually available, and that 
  ## those marked as unavailable are actually unavailable.
  all_vars_check <- lapply(
    vars,
    \(x) {
      ## Get output to double check
      fun_output <- implemented_std_methods(x)

      ## Check that methods marked as available are available.
      ## Should be 1
      mth_avail <- mean(apply(subset(fun_output, available == 1), 1, \(y) {
        if (y[1] == "norms") {
          if (y[2] == "nacc")
            return(x %in% names(normative_scores_2020))

          if (y[2] == "updated")
            return(x %in% names(normative_scores_2024))
        }

        if (y[1] == "regression") {
          if (y[2] == "nacc")
            return(x %in% reg_coefs$nacc$var_name)

          if (y[2] == "updated")
            return(x %in% reg_coefs$updated$var_name)
        }

        if (y[1] == "T-score") {
          if (!is.na(y[2]))
            return(FALSE)
          
          return(x %in% names(t_score_coefs))
        }

        FALSE
      }))

      ## Check that methods marked as unavailable are unavailable.
      ## Should be 0
      if (sum(fun_output$available == 0) == 0) {
        ## If all methods available, set to 0
        mth_unavail <- 0
      } else {
        mth_unavail <- mean(apply(subset(fun_output, available == 0), 1, \(y) {
          if (y[1] == "norms") {
            if (y[2] == "nacc")
            return(x %in% names(normative_scores_2020))
            
            if (y[2] == "updated")
            return(x %in% names(normative_scores_2024))
          }
          
          if (y[1] == "regression") {
            if (y[2] == "nacc")
            return(x %in% reg_coefs$nacc$var_name)
            
            if (y[2] == "updated")
            return(x %in% reg_coefs$updated$var_name)
          }
          
          if (y[1] == "T-score") {
            if (!is.na(y[2]))
            return(TRUE)
            
            return(x %in% names(t_score_coefs))
          }
          
          TRUE
        }))
      }
      
      c(avails = mth_avail, unavails = mth_unavail)
    }
  )

  ## Create expected matrix. That is, two columns, first of all
  ## 1's, second of all 0's. Name columns "avails" and "unavails"
  expected <- matrix(
    data = rep(c(1,0), length(vars)),
    ncol = 2,
    byrow = T,
    dimnames = list(NULL, c("avails", "unavails"))
  )
  
  expect_equal(
    do.call(rbind, all_vars_check),
    expected
  )
})

test_that("std_methods_implemented_for works for valid inputs", {
  
  all_method_version_combos <- 
    list(
      c("norms", "nacc"),
      c("norms", "updated"),
      c("regression", "nacc"),
      c("regression", "updated"),
      c("T-score", NA)
    )

  checks <- (unlist(lapply(
    all_method_version_combos,
    \(y) {
      mean(unlist(lapply(
        std_methods_implemented_for(y[1], y[2]),
        \(x, cur_y = y) {
          if (is.na(cur_y[2]))
            return(subset(
              implemented_std_methods(x),
              method == cur_y[1] & is.na(version)
            )$available)
            
          subset(
            implemented_std_methods(x),
            method == cur_y[1] & version == cur_y[2]
          )$available
        })))
    }
  )))

  expect_equal(
    checks,
    rep(1, length(all_method_version_combos))
  )

})


