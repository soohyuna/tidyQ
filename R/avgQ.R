#' A function to average CT values by groups
#'
#' @param df A data frame.
#' @param  ... Variables to group by.
#' @param name Text to append to N and mean arguments
#' @param param_var Parameter or gene to be summarize
#' @param ignoreNAs Remove NAs, defaults to TRUE
#' @return Data frame of average CT values by groups and number of values averaged.
#' @keywords summarize, mean, average
#' @export

avgQ <- function(df, ..., name = "CT", param_var, ignoreNAs = TRUE) {

  group_var <- quos(...)
  param_var <- enquo(param_var)
  N <- paste("N", name, sep = "_")
  mean <- paste0("mean",name)
  sd <- paste0("sd", name)
  se <- paste0("se", name)


  df %>%
    dplyr::group_by(!!! group_var) %>%
    dplyr::summarise(!! N := length(CT),
                 !! mean := mean(!! param_var, na.rm = ignoreNAs),
                 !! sd := sd(!! param_var, na.rm = ignoreNAs),
                 !! se := sd(!! param_var, na.rm = ignoreNAs) /
                   sqrt(length(na.omit(!!param_var)))

    )

}
