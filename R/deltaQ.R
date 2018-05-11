#' A function to calculate delta CT values by groups
#'
#' @param df A data frame.
#' @param  ... Variables to group by.
#' @param ref_gene Reference or housekeeping gene for comparison.
#' @return Data frame of delta CT values by groups.
#' @example
#'   df %>%   deltaQ(Mouse, State,
#'                   ref_gene = "GAPDH")
#'
#' @keywords delta, deltaCT
#' @import tidyverse
#'
#' @export

deltaQ <- function(df, ..., ref_gene) {

  group_var <- quos(...)
  ref_gene2 <- as.name(ref_gene)

  ref_gene_df <- df %>%
    group_by(!!! group_var) %>%
    spread(Gene, meanCT) %>%
    select(!!! group_var, ref_gene) %>%
    drop_na() %>%
    ungroup()

  print(ref_gene_df)

  df %>%
    filter(!Gene == "GAPDH")  %>%
    inner_join(ref_gene_df) %>%
    mutate(deltaCT = meanCT - UQ(ref_gene2))

}
