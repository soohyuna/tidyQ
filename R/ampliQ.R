#' A function to graph (ggplot) amplification values (deltaRN vs CT)
#'
#' @param df A data frame.
#' @param  color Variable to dictate color of the graph
#' @param facets Include variables for facetwrap; tie two variables with ~ in quotations
#' @return ggplot of Amplification plot
#' @example df %>% ampliQ(df, color = "State", facets = "Mouse~State")
#'
#' @keywords amplification, RN, deltaRN
#' @import tidyverse, themesoo
#'
#' @export


ampliQ <- function(df, color, facets) {

    p <- df %>%
      ggplot(aes_string(x = "Cycle",
                 y = "deltaRN",
                 color = color)) # ... define the variable for color

    p + geom_smooth(method = "loess") +
    facet_wrap(reformulate(facets))+
    theme_soo()

}

