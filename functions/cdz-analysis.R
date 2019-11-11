supermarket_results.participants <- function(participants){
  results <- data.frame()
  for(participant in names(participants)){
    participant_results <- supermarket_results.participant(participants[[participant]])
    results <- rbind(results, participant_results)
  }
  return(results)
}
supermarket_results.participant <- function(participant){
  results <- data.frame()
  for(i in 1:length(participant)){
    session <- participant[[i]]
    df_session <- supermarket_results.session(session)
    df_session$participant <- session$participant_id 
    df_session$timestamp <- session$timestamp
    results <- rbind(results, df_session)
  }
  return(results)
}

supermarket_results.session <- function(session){
  df <- brainvr.supermarket::task_performance_all(session)
  return(df)
}