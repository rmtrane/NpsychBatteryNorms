test_that("age groups work", {
  ## NACC age groups
  expected <- data.frame(
    group = factor(
      c("<60", "60-69", "70-79", "80-89", ">89"),
      levels = c("<60", "60-69", "70-79", "80-89", ">89")
    ),
    min_age = c(0, 60, 70, 80, 90),
    max_age = c(59, 69, 79, 89, 100)
  )

  ages <- seq(0, 100)

  actual <- data.frame(
    ages = ages,
    group = get_age_group(ages, group_type = "nacc")
  )

  actual <- aggregate(
    ages ~ group,
    data = actual,
    \(x) {
      c(
        min_age = min(x),
        max_age = max(x)
      )
    }
  )

  actual$min_age <- actual$ages[, "min_age"]
  actual$max_age <- actual$ages[, "max_age"]
  actual$ages <- NULL

  expect_equal(
    actual,
    expected
  )

  ## RAVLT Trials age groups
  expected <- data.frame(
    group = factor(
      c(
        "<20",
        "20-29",
        "30-39",
        "40-49",
        "50-59",
        "60-69",
        "70-79",
        ">79"
      ),
      levels = c(
        "<20",
        "20-29",
        "30-39",
        "40-49",
        "50-59",
        "60-69",
        "70-79",
        ">79"
      )
    ),
    min_age = c(0, 20, 30, 40, 50, 60, 70, 80),
    max_age = c(19, 29, 39, 49, 59, 69, 79, 100)
  )

  ages <- seq(0, 100)

  actual <- data.frame(
    ages = ages,
    group = get_age_group(ages, group_type = "ravlt_trials")
  )

  actual <- aggregate(
    ages ~ group,
    data = actual,
    \(x) {
      c(
        min_age = min(x),
        max_age = max(x)
      )
    }
  )

  actual$min_age <- actual$ages[, "min_age"]
  actual$max_age <- actual$ages[, "max_age"]
  actual$ages <- NULL

  expect_equal(
    actual,
    expected
  )

  ## Updated age groups
  expected <- data.frame(
    group = factor(
      c("<60", "60-69", "70-79", ">79"),
      levels = c("<60", "60-69", "70-79", ">79")
    ),
    min_age = c(0, 60, 70, 80),
    max_age = c(59, 69, 79, 100)
  )

  ages <- seq(0, 100)

  actual <- data.frame(
    ages = ages,
    group = get_age_group(ages, group_type = "updated")
  )

  actual <- aggregate(
    ages ~ group,
    data = actual,
    \(x) {
      c(
        min_age = min(x),
        max_age = max(x)
      )
    }
  )

  actual$min_age <- actual$ages[, "min_age"]
  actual$max_age <- actual$ages[, "max_age"]
  actual$ages <- NULL

  expect_equal(
    actual,
    expected
  )
})
