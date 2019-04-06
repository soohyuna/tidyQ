#' A function to import the 'Results' sheet from .xls/x files into R.
#'
#' @param dir The specific folder path containing all .xls files, defaults to working directory.
#' @return Combined dataframe containing data from all of the ranges from 'Results' sheets.
#' @keywords import raw qPCR file, import
#' @export

importQ <- function(dir = ""){

  # Get filenames
  if(dir == ""){

    files <- here::here(list.files(path = here::here(),
                                   pattern = "*.xls|*.xlsx")) %>%
      as.list()
  } else {

    files <- here::here(dir,list.files(path = here::here(dir),
                                       pattern = "*.xls|*.xlsx")) %>%
      as.list()
  }

  # Determine number of samples
  get_samples <- function(path){

    rows <- path %>%
      readxl::read_excel(sheet = "Results",
                         skip = 7) %>%
      dplyr::select(Well) %>%
      base::nrow()

    rows - 5
  }

  # Create list of sample numbers
  num_samples <- files %>%
    purrr::map(~get_samples(path = .x)) %>%
    base::as.list()

  message(paste("\nDetected",num_samples, "samples in", files))
  message(paste("\ntidyQ will now combine", base::Reduce(`+`, num_samples),
                "samples from ",base::length(num_samples),
                "plates into a single data frame."))

  # Determine range for each plate
  plate_range <- num_samples %>%
<<<<<<< HEAD
    map(~paste0("A8:X", (.x +8 )))
=======
    map(~paste0("A8:X", (.x + 8)))
>>>>>>> 8a8e958d27e8dda424c5c94494ae1d5715b283b8



  # Read in files
  purrr::map2_df(files, plate_range,
                 ~ readxl::read_excel(path = .x,
                                      sheet = "Results",
                                      range = .y,
                                      col_types = "text"))


}


# nms <- files %>%
#   map(~read_excel(.x, sheet = "Results", skip = 7) %>%
#         select(1:24) %>%
#         colnames())
#
# coltypes <- nms %>%
#   map(~ifelse(grepl("^Cт", .x),"text","guess"))

