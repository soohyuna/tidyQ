#' A function to import amplification data from .xls files.
#'
#' @param file The `.xls/x` present in working directory or specific `.xls/x`.
#' @param  num_samples The specific range of cells within each sheet in your `.xls/x` file.
#' @param sep_var Variables to separate the 'Sample' column into.
#' @return Data frame of amplification data.
#' @example amportQ(file = "my_file.csv", num_samples = 96, sep_var = c("Treatment", "Replicate"))
#' @keywords import, amplification, amplification curve
#' @import tidyverse
#'
#' @export

amportQ <- function(file = here(list.files(pattern = "*.xls|*.xlsx")),
                    num_samples,
                    sep_var){

  amplification <- file %>%
    map( ~ read_excel(path = .x, sheet = "Amplification Data", skip = 7)) %>%
    bind_rows()

  results <- file %>%
    map2_df(num_samples, ~ read_excel(path = .x, sheet = "Results", skip = 7, n_max = .y)) %>%
    bind_rows()

  results %>%
    inner_join(amplification) %>%
    rename("Sample" = `Sample Name`, "Gene" = `Target Name`, "CT" = Cт, "deltaRN" = ΔRn) %>%
    select(Sample,Gene,CT,Cycle,deltaRN) %>%
    separate(Sample, into = sep_var, sep = "_") %>%
    mutate_at(vars(1:CT),as.factor)

}
