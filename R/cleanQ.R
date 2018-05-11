#' A function to clean a xls imported data frame
#'
#' @param df A data frame.
#' @param  sep_var Variables of variables to be separated.
#' @return Data frame suitable for downstream tidyQ analysis.
#' @example
#' cleanQ(sep_var = c("Mouse","State","Rep"))
#'
#' @keywords clean, tidy, import
#' @import tidyverse
#'
#' @export

cleanQ <- function(df, sep_var) {

  df %>%
    rename("Sample" = `Sample Name`, "Gene" = `Target Name`, "CT" = Cт) %>%
    select(-(Task:`RQ Max`)) %>%
    separate(Sample, into = sep_var, sep = "_") %>%
    filter(!CT %in% c("NA","Undetermined")) %>%
    mutate_at(vars(1:Gene),as.factor) %>%
    mutate_at(vars(CT),as.numeric)

}

