#' A function to clean a xls imported data frame
#'
#' @param df A data frame.
#' @param  sep_var Variables of variables to be separated.
#' @return Data frame suitable for downstream tidyQ analysis.
#' @keywords clean, tidy, import
#' @export

cleanQ <- function(df, sep_var) {

rawCT <- paste0("C","\u0442")

  df %>%
    rename("Sample" = `Sample Name`,
           "Gene" = `Target Name`,
           "CT" = rawCT) %>%
    dplyr::select(-(Task:`RQ Max`)) %>%
    tidyr::separate(Sample,
                    into = sep_var,
                    sep = "_") %>%
    dplyr::filter(!CT %in% c("NA","Undetermined")) %>%
    dplyr::mutate_at(vars(1:Gene), as.factor) %>%
    dplyr::mutate_at(vars(CT), as.numeric)

}

