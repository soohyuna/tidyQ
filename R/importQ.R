#' A package to analyze qPCR data from CT values
#'
#' @param file The `.xls` sheet that you want to import (it should be in your working directory).
#' @param  ranges The specific range of cells within each sheet in your `.xls` file.
#' @return Combined dataframe containing data from all of the ranges from sheets.
#' @example
#' importQ(file = "myfile.xls", ranges = c("A4:G89", "A4:J100"))
#'
#' @keywords import raw qPCR file, import
#' @import tidyverse, readxl, purrr
#'
#' @export


importQ <- function(file, ranges) {

  sheets <- file %>%
    excel_sheets() #locate the sheets on xls file

  rawdata <- map2_df(sheets,
                     ranges,
                     ~read_excel(file,
                                 sheet = .x,
                                 range = .y),
                     .id = "sheet")
  rawdata
}









# Old  --------------------------------

importQ <- function(file, cells) {

  file <- "qPCR_N_NP_Master.xls"

  raw <- here(file)

  sheets <- raw %>% excel_sheets() #locate the sheets on xls file

  ranges <- list(cells)

  rawdata <- map2_df(sheets, ranges,
                    ~read_excel(file, sheet = .x, range = .y),
                    .id = "sheet")
  rawdata

}
