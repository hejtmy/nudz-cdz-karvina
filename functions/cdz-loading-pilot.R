# SUPERMARKET --------------------
library(brainvr.supermarket)
#' Loads the participant data from given folder
#' @param dir: directory of all the data
#' @param type: monitor or VR
#' @param id: participants id
#' @param version: either settings version "A" or "B". Needs to be capitalized
#' 
#' WHY are tehre multiple exps???
load_participants_supermarket <- function(data_dir, ids = c()){
  if(length(ids) == 0){
    ids <- list.files(file.path(data_dir, "supermarket"),
                      full.names = FALSE, recursive = FALSE)
  }
  result <- list() 
  for(id in ids){
    folder <- path_supermarket_participant(data_dir, id)
    if(!dir.exists(folder)) next
    message("Loading participant in folder ", folder)
    exps <- load_participant_supermarket(data_dir, id)
    result[[basename(folder)]] <- exps
  }
  return(result)
}

load_participant_supermarket <- function(data_dir, id){
  folder <- path_supermarket_participant(data_dir, id)
  exps <- load_supermarket_experiments(folder, language = "CZR")
  ## ThIS DOESN'T WORK FOR ALL FOR SOME REASON FFS
  # version <- exps[[1]]$data$experiment_info$Experiment$Settings$settings[17]
  # version <- gsub(".*verze ([A-Z])\\.json", "\\1", version)
  #for(i in 1:length(exps)){
   # exps[[i]]$tasklist <- tasklists[[version]]
  #}
  return(exps)
}

path_supermarket_participant <- function(base_dir, id){
  return(file.path(base_dir, "supermarket", id))
}

load_tasklists <- function(data_dir) {
  settingsA <- file.path(data_dir, "verze A.json")
  settingsB <- file.path(data_dir, "verze B.json")
  settingsA <- load_supermarket_takslist(settingsA)
  settingsB <- load_supermarket_takslist(settingsB)
  return(list(A = settingsA, B = settingsB))
}

### Super validation ------
supermarkets_are_valid <- function(supermarkets){
  for(name in names(supermarkets)){
    exps <- supermarkets[[name]]
    for(i in length(exps)){
      exp <- exps[[i]]
      valid <- TRUE
      valid <- !is.null(exp$data$results_log$data)
      if(!valid) warning(name, " ", exp$timestamp, " is not valid")
    }
  }
}

# HOUSE ------------------
load_participant_house <- function(data_dir, id){
  participant_folder <- file.path(data_dir, "supermarket", id)
}