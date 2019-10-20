library(brainvr.reader)

# functions -----
folder_output <- function(folder){
  df <- data.frame(folder = character(),
                   id=character(), type=character(), 
                   date=character(), time=character(),
                   player_log_length = numeric(),
                   stringsAsFactors = FALSE,
                   items_picked = numeric())
  exps <- load_experiments(folder)
  for(exp in exps){
    result <- list()
    result$folder <- basename(folder)
    result$id <- exp$participant_id
    result$type <- type
    t <- strptime(exp$timestamp, format = "%H-%M-%S-%d-%m-%Y")
    result$date <- strftime(t, format = "%x")
    result$time <- strftime(t, format = "%X")
    result$items_picked <- nrow(exp$data$experiment_log$data)
    log_length <- tail(exp$data$position$data$time_since_start, 1)
    result$player_log_length <-  paste0(round(log_length/60,0), "m ", round(log_length %% 60, 0), "s")
    df <- base::rbind(df, as.data.frame(result))
  }
  return(df)
}

# script ----
UNITY_DIR <- "E:/Google Drive/NUDZ/Projects/CDZ Karvina/VR-tasks/logy/1-pilot_VR-pen-paper/"
TYPES <- c("house", "supermarket")
type <- TYPES[2]
pth <- file.path(UNITY_DIR, type)
folders <- list.files(pth, full.names = TRUE)
folders <- folders[!grepl("[.]ini", folders)] #removes potential .ini on windows
#folders <- folders[1:4]
df <- data.frame()
for(type in TYPES){
  for(folder in folders){
    output <- folder_output(folder)
    df <- base::rbind(df, output)
  }
}
write.csv(df, "logs_present.csv", row.names = FALSE)
