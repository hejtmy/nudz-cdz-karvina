df_demographics <- get_sheet_demographics()
df_rbans <- get_sheet_rbans()
df_ids <- get_sheet_ids()

write.table(df_ids, "information.csv", sep = ";", row.names = FALSE)
write.table(df_demographics, "demographics.csv", sep = ";", row.names = FALSE)
write.table(df_rbans, "rbans.csv", sep = ";", row.names = FALSE)
