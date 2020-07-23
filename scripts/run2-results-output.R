library(brainvr.supermarket)
library(googlesheets4)
source("functions/constants.R")
source("functions/cdz-loading-pilot.R")
source("functions/cdz-analysis.R")

demographics <- googlesheets4::sheets_read(GS_RUN2_DEMOGRAPHICS)
df_sessions <- googlesheets4::sheets_read(GS_RUN2_SESSION,col_types = "ccicc")

UNITY_DIR <- "E:/Google Drive/NUDZ/Projects/CDZ Karvina/VR-tasks/logy/2-pilot_VR-pen-paper/"
participatns <- unique(df_sessions$ID)
exps <- load_participants_supermarket(UNITY_DIR, participatns)
df_results <- supermarket_results.participants(exps)
write.table(df_results, "run2-results.csv", sep=",", row.names = FALSE)
