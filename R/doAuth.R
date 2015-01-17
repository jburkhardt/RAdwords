#' Invoke the Authentication Process with Google
#' 
#' This function starts the authentication process with Google. 
#' Note that this functions needs user interaction.
#' 
#' @param save logical denotes whether authentication information should be saved on disk. Defaults to TRUE.
#' @param service character name of the service, defaults to 'google'. Also supports 'bing'.
#' @seealso \code{\link{getAuth}},\code{\link{loadToken}}
#' @export
doAuth <- function(save = T,service = 'google'){
  
  if(service == 'google'){
    cache_file <- '.google.auth.RData'  
  }
  
  if(service == 'bing'){
    cache_file <- '.bing.auth.RData'  
  }
  
  # do user interaction to store credentials in list
  # does not expire
  if(file.exists(cache_file)){
    load(cache_file)
  } else{
    
    if(service == 'google'){
      credentials <- getAuth()  
      access_token <- loadToken(credentials)
      # credentials can be saved in workspace 
      # for use with cron jobs etc
      auth <- list()
      auth$credentials <- credentials
      auth$access <- access_token
    }
    
    if(service == 'bing'){
      auth <- list()
      auth$credentials <- bingAuth()
      auth$timeStamp <- Sys.time()
    }
    
    
    if(save){
      save(auth,file = cache_file)
      
      # make sure your credentials are ignored by svn and git ####
      if (!file.exists(".gitignore")){
        cat(cache_file,file=".gitignore",sep="\n")
      } 
      if (file.exists(".gitignore")){
        cat(cache_file,file=".gitignore",append=TRUE)
      }
    }
  }
  if(exists('auth')){
    auth  
  } else {
    cat("an error occurred.")
  }
  
}

