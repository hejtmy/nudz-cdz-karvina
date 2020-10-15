GS_RUN2_SESSION <- "1rFm8QnjGw3BQuFfMvGiLUa5hMvg3-8iTP8h5DGMZLlc"
GS_RUN2_DEMOGRAPHICS_RBANS <- "1qMdiLYY7EIbNvoRsE5knjBB24zXT7hgJNUCmwMX7IwY"

get_sheet_ids <- function(preprocess = TRUE){
  df_ids <- googlesheets4::range_read(GS_RUN2_DEMOGRAPHICS_RBANS, sheet = "ID")
  if(!preprocess) return(df_ids)
  colnames(df_ids) <- c("rbansid", "vrid", "name", "finished", "is_ok", "note")
  df_ids$name <- NULL
  df_ids$is_ok <- df_ids$is_ok == 1
  df_ids$finished <- df_ids$finished == 1
  return(df_ids)
}
get_sheet_demographics <- function(preprocess = TRUE){
  df_demographics <- googlesheets4::range_read(GS_RUN2_DEMOGRAPHICS_RBANS, 
                                             sheet = "demografie", 
                                             col_types = "ccccccciiiccc")
  if(!preprocess) return(df_demographics)
  colnames(df_demographics) <- c("name", "note", "first_training", "rbans_date",
                                 "rbansid", "retirement", "gender", "age",
                                 "education", "ilness_duration_years", "diagnosis",
                                 "medication", "other_notes")
  return(df_demographics)
}

get_sheet_rbans <- function(preprocess = TRUE){
  df_rbans <- googlesheets4::range_read(GS_RUN2_DEMOGRAPHICS_RBANS,
                                        sheet = "rbans")
  if(!preprocess) return(df_rbans)
  colnames(df_rbans) <- tolower(colnames(df_rbans))
  colnames(df_rbans) <- gsub("rbansbaseline_", "", colnames(df_rbans))
  return(df_rbans) 
}

get_sheet_sessions <- function(preprocess = TRUE){
  df_sessions <- googlesheets4::sheets_read(GS_RUN2_SESSION, col_types = "ccicc")
  if(!preprocess) returnb(df_sessions)
  colnames(df_sessions) <- tolower(colnames(df_sessions))
  return(df_sessions)
}