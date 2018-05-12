#' A function to import the 'Results' sheet from .xls/x files into R.
#'
#' @param file The `.xls/x` present in working directory or specific `.xls/x`.
#' @param  num_samples The specific range of cells within each sheet in your `.xls/x` file.
#' @return Combined dataframe containing data from all of the ranges from 'Results' sheets.
#' @example importQ(path = "myfile.xls", num_samples = list(72))
#' @keywords import raw qPCR file, import
#' @import tidyverse, readxl, purrr, here
#'
#' @export

importQ <- function(file = here(list.files(pattern = "*.xls|*.xlsx")),
                       num_samples){

  file %>%
    map2_df(num_samples, ~ read_excel(path = .x, sheet = "Results", skip = 7, n_max = .y)) %>%
    bind_rows()

}

# Old  --------------------------------


# importQ <- function(file, ranges) {
#
#   sheets <- file %>%
#     excel_sheets() #locate the sheets on xls file
#
#   rawdata <- map2_df(sheets,
#                      ranges,
#                      ~read_excel(file,
#                                  sheet = .x,
#                                  range = .y),
#                      .id = "sheet")
#   rawdata
# }
