#' A function to graph (ggplot) amplification values (deltaRN vs CT)
#'
#' @param df A data frame.
#' @param  color Variable to dictate color of the graph
#' @param facets Include variables for facetwrap; tie two variables with ~ in quotations
#' @return ggplot of Amplification plot
#' @keywords amplification, RN, deltaRN
#'
#' @export


ampliQ <- function(df, color, facets) {

    p <- df %>%
      ggplot2::ggplot(aes_string(x = "Cycle",
                 y = "deltaRN",
                 color = color)) # ... define the variable for color

    p + ggplot2::geom_smooth(method = "loess") +
      ggplot2::facet_wrap(reformulate(facets))+
    themesoo::theme_soo()

}
