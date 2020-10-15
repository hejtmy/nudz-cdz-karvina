get_ids_is_ok <- function(df_ids, idtype = "rbansid"){
  ids <- df_ids[[idtype]][df_ids$is_ok]
  return(ids)
}
