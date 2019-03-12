#' A function to import amplification data from .xls files.
#'
#' @param file The ".xls/x" present in working directory or specific ".xls/x".
#' @param sep_var Variables to separate the 'Sample' column into.
#' @return Data frame of amplification data.
#' @keywords import, amplification, amplification curve
#' @export

amportQ <- function(file, sep_var){

# Files
file <- here::here(list.files(pattern = "*.xls|*.xlsx"))

# Number of samples
samples <- here::here(list.files(pattern = "*.xls|*.xlsx"))[[1]] %>%
  readxl::read_excel(sheet = "Results", skip = 7) %>%
  dplyr::select(Well) %>%
  dplyr::mutate(row_num = dplyr::row_number()) %>%
  dplyr::filter(Well == "Analysis Type") %>%
  dplyr::select(row_num)

num_samples <- samples$row_num - 2


amplification <- file %>%
    purrr::map( ~ read_excel(path = .x,
                             sheet = "Amplification Data",
                             skip = 7)) %>%
    dplyr::bind_rows()

results <- file %>%
    purrr::map2_df(num_samples,
                   ~ read_excel(path = .x,
                                sheet = "Results",
                                skip = 7,
                                n_max = .y)
                   ) %>%
    dplyr::bind_rows()


rawRN <- paste0("\u0394","Rn")
rawCT <- paste0("C","\u0442")

results %>%
    dplyr::inner_join(amplification) %>%
    dplyr::rename("Sample" = `Sample Name`,
                  "Gene" = `Target Name`,
                  "CT" = rawCT,
                  "deltaRN" = rawRN) %>%
    dplyr::select(Sample,Gene,CT,Cycle,deltaRN) %>%
    tidyr::separate(Sample,
                    into = sep_var,
                    sep = "_") %>%
    dplyr::mutate_at(vars(1:CT), as.factor)

}

