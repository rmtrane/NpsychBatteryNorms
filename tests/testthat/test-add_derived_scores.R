test_that("add reytotal", {
  all_reys <- expand.grid(
    REY1REC = 1:15,
    REY2REC = 1:15,
    REY3REC = 1:15,
    REY4REC = 1:15,
    REY5REC = 1:15
  )

  expect_equal(
    add_derived_scores(all_reys)$REYTOTAL,
    rowSums(all_reys)
  )

  vars_for_fas <- c(
    "BILLS",
    "TAXES",
    "SHOPPING",
    "GAMES",
    "STOVE",
    "MEALPREP",
    "EVENTS",
    "PAYATTN",
    "REMDATES",
    "TRAVEL"
  )

  all_fas <- do.call(expand.grid, rep(list(0:3), length(vars_for_fas)))

  all_fas <- setNames(all_fas, vars_for_fas)

  expect_equal(
    add_derived_scores(all_fas)$FAS,
    do.call(calculate_fas, all_fas)
  )

  expect_equal(
    add_derived_scores(data.frame(REYTNEG = 0:15))$REYFPOS,
    15:0
  )

  for_reyarec <- expand.grid(
    REYFPOS = 0:15,
    REYTCOR = 0:15
  )

  expect_equal(
    add_derived_scores(for_reyarec)$REYAREC,
    do.call(calculate_reyarec, for_reyarec)
  )

  for_mocaclock <- expand.grid(
    MOCACLOC = c(0, 1),
    MOCACLON = c(0, 1),
    MOCACLOH = c(0, 1)
  )

  expect_equal(
    add_derived_scores(for_mocaclock)$MOCACLOCK,
    c(0, 1, 1, 2, 1, 2, 2, 3)
  )
})
