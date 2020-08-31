#' A function to import the 'Results' sheet from .xls/x files into R.
#'
#' @param dir The specific folder path containing all .xls files, defaults to working directory.
#' @return Combined dataframe containing data from all of the ranges from 'Results' sheets.
#' @keywords import raw qPCR file, import
#' @export


# Get filenames

importQ <- function(dir = "") {
if(dir == "") {

  files <- here::here(list.files(path = here::here(),
                                 pattern = "*.xls|*.xlsx")) %>%
    base::as.list()
} else {

  files <- here::here(dir,list.files(path = here::here(dir),
                                     pattern = "*.xls|*.xlsx")) %>%
    base::as.list()
}

# Determine number of samples
get_sample_range <- function(path){

  stepone <- path %>%
    readxl::read_excel(sheet = "Results", range = "B1:B40") %>%
    tibble::as_tibble() %>%
    stringr::str_detect("steponeplus")

  quantstudio <- path  %>%
    readxl::read_excel(sheet = "Results", range = "B1:B40") %>%
    tibble::as_tibble() %>%
    stringr::str_detect("QuantStudio")

  if (stepone == TRUE) {

    rows_to_skip <- 7
    bottom_row <- 5
    print("Detected: steponeplus")

  } else if(quantstudio == TRUE) {

    rows_to_skip <- 47
    bottom_row <- 5
    print("Detected: QuantStudio")

  } else {
    print("Error: file type not supported")
  }

  total_rows <- path %>%
    readxl::read_excel(sheet = "Results",
                       skip = rows_to_skip) %>%
    dplyr::select(Well) %>%
    base::nrow()

  no_samples <- total_rows - bottom_row

  paste0("A",rows_to_skip + 1,":X", (no_samples + rows_to_skip  + 1))
}

# Create a list of ranges
plate_ranges <- files %>%
  purrr::map(~get_sample_range(path = .x)) %>%
  base::as.list()

plate_ranges

# Read in files
purrr::map2_df(files, plate_ranges,
               ~ readxl::read_excel(path = .x,
                                    sheet = "Results",
                                    range = .y,
                                    col_types = "text"))


}
