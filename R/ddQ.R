#' A function to calculate delta delta CT values by groups
#'
#' @param df A data frame.
#' @param  ... Variables to group by.
#' @param col Column containing group of interest.
#' @param control String value for control group of interest.
#' @param na.rm Remove NAs from data, defaults to TRUE.
#' @return Data frame of average CT values by groups and number of values averaged.
#' @keywords summarize, mean, average
#' @export



ddQ <- function(df, ..., col, control, na.rm = TRUE) {

  group_var <- quos(...)
  col <- enquo(col)
  cont_deltaCT <- paste(control, "deltaCT", sep= "_")
  cont_deltaCT2 <- as.name(cont_deltaCT)


  cont_deltaCT_df <- df %>%
    dplyr::filter(!! col == control ) %>%
    dplyr::group_by(!!! group_var) %>%
    dplyr::summarise(!! cont_deltaCT := mean(deltaCT, na.rm = na.rm))

  df %>%
    dplyr::inner_join(cont_deltaCT_df) %>%
    dplyr::mutate(ddCT = deltaCT - UQ(cont_deltaCT2),
           FC = 2^-(ddCT))

}
