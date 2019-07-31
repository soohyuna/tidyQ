#' A function to clean a xls imported data frame
#'
#' @param df A data frame.
#' @param sep_samp Separate sample column into individual columns.
#' @param  sep_var Variables of variables to be separated.
#' @return Data frame suitable for downstream tidyQ analysis.
#' @keywords clean, tidy, import
#' @export

cleanQ <- function(df, sep_samp = FALSE,  sep_var) {

rawCT <- paste0("C","\u0442")

clean_df <- df %>%
  dplyr::rename("Sample" = `Sample Name`,
                "Gene" = `Target Name`,
                "CT" = rawCT) %>%
  dplyr::select(-(Task:`RQ Max`)) %>%
  dplyr::filter(!CT %in% c("NA","Undetermined")) %>%
  dplyr::mutate_at(vars(1:Gene), as.factor) %>%
  dplyr::mutate_at(vars(CT), as.numeric)

  if(sep_samp == FALSE){

    return(clean_df)

  } else if(sep_samp == TRUE){

  clean_df %>%
      tidyr::separate(Sample,
                      into = sep_var,
                      sep = "_")

  }

}

