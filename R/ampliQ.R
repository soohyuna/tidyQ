#' A function to graph (ggplot) amplification values (deltaRN vs CT)
#'
#' @param df A data frame.
#' @param  color Variable to dictate color of the graph
#' @param x Variable for x-axis of the graph
#' @param y Variable for y-axis of the graph
#' @return ggplot of Amplification plot
#' @example
#'   df %>% ampliQ(df,x = CT, y = deltaRN, color = State)
#'
#' @keywords amplification, RN, deltaRN
#' @import tidyverse, themesoo
#'
#' @export


ampliQ <- function(df, x , y ,color) {

    p <- df %>%
      ggplot(aes_string(x = x, y = y, color = color)) # ... define the variable for color

    p + geom_smooth(method = "loess") +
    facet_wrap(Mouse~State)+
    theme_soo()

}

