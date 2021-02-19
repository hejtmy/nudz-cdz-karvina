baseline_rbans <- function(df_rbans){
  df_rbans_baseline <- df_rbans %>%
    arrange(rbansid, trenink) %>% # order baseline TP VR
    group_by(rbansid) %>%
    summarise_at(vars(testuceni:iq_celek, starts_with("dim")), 
                 list(VR = ~.x[3]-.x[1], TP = ~ .x[2]-.x[1])) %>%
    pivot_longer(!rbansid,
                 names_to = c(".value", "trenink"),
                 names_pattern = "(.+)_(.+)"
    )
  df_rbans_baseline <- df_rbans %>%
    select(rbansid, diagnosis, first_training, trenink, session) %>%
    filter(session > 1) %>%
    distinct() %>%
    right_join(df_rbans_baseline, by=c("rbansid", "trenink"))
  return(df_rbans_baseline)
}

add_training_to_rbans <- function(df_rbans, df_demographics){
  df_rbans <- left_join(df_rbans, 
                        select(df_demographics, rbansid, first_training),
                        by = "rbansid")
  return(df_rbans) 
}

add_session_to_rbans <- function(df_rbans, df_demographics){
  if(!("first_training" %in% colnames(df_rbans))){
    df_rbans <- add_training_to_rbans(df_rbans, df_demographics)
  }
  df_rbans$session <- 3
  df_rbans$session[df_rbans$first_training == df_rbans$trenink] <- 2
  df_rbans$session[df_rbans$trenink == "baseline"] <- 1
  df_rbans$session[is.na(df_rbans$first_training)] <- NA
  return(df_rbans)
}

add_summaries_to_rbans <- function(df_rbans){
  df_rbans <- df_rbans %>%
    mutate(dim_kratkodobapamet = testuceni + testpameti,
           dim_dlouhodobapamet = vybaveniseznamu + rekognice + vybavenipovidky + vybavenifigury,
           dim_pozornost = opakovanicisel + symboly,
           dim_rec = pojmenovaniobrazku + verbalnifluence,
           dim_vizuoprostor = kopiefigury + orientaceprimek,
           dim_celek = dim_kratkodobapamet + dim_dlouhodobapamet + dim_pozornost +
             dim_rec + dim_vizuoprostor)
  return(df_rbans)
}
