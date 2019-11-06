# Loads the participant data from given folder
#' @param dir: directory of all the data
#' @param type: monitor or VR
#' @param id: participants id
#' @param version: either settings version "A" or "B". Needs to be capitalized
#' 
#' WHY are tehre multiple exps???
load_participants_supermarket <- function(data_dir, tasklists){
  folders <- list.files(file.path(data_dir, "supermarket"), full.names = TRUE)
  result <- list() 
  for(folder in folders){
    if(!dir.exists(folder)) next
    message("Loading participant in folder ", folder)
    exps <- load_participant_supermarket(data_dir, basename(folder), tasklists)
    result[[basename(folder)]] <- exps
  }
  return(result)
}

load_participant_supermarket <- function(data_dir, id, tasklists){
  participant_folder <- file.path(data_dir, "supermarket", id)
  exps <- load_supermarket_experiments(participant_folder)
  version <- exps[[1]]$data$experiment_info$Experiment$Settings$settings[17]
  version <- gsub(".*verze ([A-Z])\\.json", "\\1", version)
  for(i in 1:length(exps)){
    exps[[i]]$tasklist <- tasklists[[version]]
  }
  return(exps)
}

load_tasklists <- function(data_dir) {
  settingsA <- file.path(data_dir, "verze A.json")
  settingsB <- file.path(data_dir, "verze B.json")
  settingsA <- brainvr.supermarket::load_supermarket_takslist(settingsA)
  settingsB <- brainvr.supermarket::load_supermarket_takslist(settingsB)
  return(list(A = settingsA, B = settingsB))
}

