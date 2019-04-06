#' A function to calculate delta CT values by groups
#'
#' @param df A data frame.
#' @param  ... Variables to group by.
#' @param ref_gene Reference or housekeeping gene for comparison.
#' @return Data frame of delta CT values by groups.
#' @keywords delta, deltaCT
#'
#' @export

deltaQ <- function(df, ..., ref_gene) {

  group_var <- quos(...)
  ref_gene2 <- as.name(ref_gene)

  ref_gene_df <- df %>%
    dplyr::group_by(!!! group_var) %>%
    tidyr::spread(Gene, meanCT) %>%
    dplyr::select(!!! group_var, ref_gene) %>%

    # dplyr::drop_na() %>%

    tidyr::drop_na() %>%

    dplyr::ungroup()

  print(ref_gene_df)

  df %>%
    dplyr::filter(!Gene == "GAPDH")  %>%
    dplyr::inner_join(ref_gene_df) %>%
    dplyr::select(-dplyr::starts_with("sd"),
                  -dplyr::starts_with("se")) %>%
    dplyr::mutate(deltaCT = meanCT - UQ(ref_gene2))

}
