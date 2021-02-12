library(tidyverse)
source("functions/cdz-getters.R")
df_demographics <- get_sheet_demographics()
write.table(df_demographics, "demographics.csv", sep = ";", row.names = FALSE)

df_rbans <- get_sheet_rbans()
write.table(df_rbans, "rbans.csv", sep = ";", row.names = FALSE)

df_ids <- get_sheet_ids()
write.table(df_ids, "information.csv", sep = ";", row.names = FALSE)

df_questionnaire <- get_sheet_questionnaire()
write.table(df_questionnaire, "questionnaire.csv", sep = ";", row.names = FALSE)

df_sessions <- get_sheet_sessions()
write.table(df_sessions, "sessions.csv", sep = ";", row.names = FALSE)
