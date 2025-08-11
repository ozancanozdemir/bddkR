# tests/testthat/test-fetch_data.R
library(testthat)
library(bddkR)

test_that("package returns a tibble file", {
  data <- fetch_data(
       start_year = 2023,
       start_month = 1,
       end_year = 2023,
      end_month = 2,
       table_no = 1,
       currency = "TL",
       group = 10001,
       lang = "tr",
       save_excel = FALSE
     )
})
