baseline_rbans <- function(df_rbans){
  df_rbans_baseline <- df_rbans %>%
    left_join(select(df_demographics, rbansid, first_training), by = "rbansid") %>%
    arrange(rbansid, trenink) %>% # order baseline TP VR
    group_by(rbansid) %>%
    summarise_at(vars(testuceni:celek), list(vr = ~.x[3]-.x[1], tp = ~ .x[2]-.x[1])) %>%
    pivot_longer(!rbansid,
                 names_to = c(".value", "trenink"),
                 names_pattern = "(.+)_(.+)"
    )
  df_rbans_baseline <- df_rbans %>%
    select(rbansid, diagnosis) %>%
    distinct() %>%
    right_join(df_rbans_baseline, by="rbansid")
  return(df_rbans_baseline)
}
