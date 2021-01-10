library(brainvr.supermarket)
library(googlesheets4)
library(tidyverse)
source("functions/cdz-loading-pilot.R")
source("functions/cdz-analysis.R")
source("functions/cdz-getters.R")

df_demographics <- get_sheet_demographics()
df_sessions <- get_sheet_sessions()

UNITY_DIR <- "E:/Google Drive/NUDZ/Projects/CDZ Karvina/VR-tasks/logy/2-pilot_VR-pen-paper/"
participatns <- unique(df_sessions$id)

exps <- load_participants_supermarket(UNITY_DIR, participatns)
df_results <- supermarket_results.participants(exps)

df_results <- df_results %>% 
  separate(timestamp, sep = "-", into = c("hour", "minute", "second", "day", "month", "year"), remove = FALSE) %>% 
  mutate(day = gsub("[0]([0-9])", "\\1", day),
         month = gsub("0([0-9])", "\\1", month)) %>%
  unite("date", c(day, month, year), sep = ".") %>%
  select(-c(hour, minute, second))
write.table(df_results, "run2-results-supermarket.csv", sep = ";", row.names = FALSE)
df_results <- read.table("run2-results-supermarket.csv", sep = ";", header = TRUE)

df_results <- df_results %>%
  left_join(filter(df_sessions, task == "supermarket", use),
            by = c("participant" = "id", "date" = "date")) %>%
  filter(!is.na(session))

write.table(df_results, "run2-results-supermarket-sessions.csv", 
            sep=";", row.names = FALSE)

# Missing information about session
df_results %>%
  filter(is.na(session)) %>%
  select(participant, timestamp) %>%
  distinct()

View(df_results)

df_results %>%
  filter(!is.na(session)) %>%
  group_by(participant) %>%
  summarise(n = n(), sessions = length(unique(session)),
            timestamps = length(unique(timestamp)))

df_results %>%
  group_by(session, participant) %>%
  summarise(trials = paste0(n_items, collapse = ", "),
            timestamp = timestamp) %>%
  distinct() %>%
  write.csv("session-trials.csv", row.names = FALSE)
