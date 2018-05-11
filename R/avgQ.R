#' A function to average CT values by groups
#'
#' @param df A data frame.
#' @param  ... Variables to group by.
#' @param name Text to append to N and mean arguments
#' @return Data frame of average CT values by groups and number of values averaged.
#' @example
#'   df %>% avgQ(sheet, Mouse, State, Gene,
#'               name = "Tech_rep",
#"               param_var = CT)
#'
#' @keywords summarize, mean, average
#' @import tidyverse
#'
#' @export

avgQ <- function(df, ..., name = "CT", param_var, na.rm = TRUE) {

  group_var <- quos(...)
  param_var <- enquo(param_var)
  N <- paste("N", name, sep = "_")
  mean <- paste0("mean",name)
  sd <- paste0("sd", name)
  se <- paste0("se", name)


  df %>%
    group_by(!!! group_var) %>%
    summarise(   !! N := length(CT),
                 !! mean := mean(!! param_var, na.rm = na.rm),
                 !! sd := sd(!! param_var, na.rm = na.rm),
                 !! se := sd(!! param_var, na.rm = na.rm) /
                   sqrt(length(na.omit(!!param_var)))

    )

}
