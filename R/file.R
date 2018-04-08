#' A package to analyze qPCR data from CT values
#'
#' @param object A package
#' @return An analysis output of relative FC
#' @example
#'
#' @export


file <- "qPCR_N_NP_Master.xls"

raw <- here(master)

sheets <- raw %>% excel_sheets() #locate the sheets on xls file

ranges <- list("ranges of sheets")

function(rawdata) {
  rawdata <- map2_df(sheets, ranges,
                    ~read_excep(file,sheet = .x, range = .y),
                    .id = "sheet")


}
