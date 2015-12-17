#' Invoke the Authentication Process with Google
#' 
#' This function starts the authentication process with Google. 
#' Note that this functions needs user interaction.
#' 
#' @param save logical denotes whether authentication information should be saved on disk. Defaults to TRUE.
#' @param localname alias to save the auth token under. Defaults to "default".
#' @seealso \code{\link{getCredentials}},\code{\link{getAuth}},\code{\link{loadToken}}
#' @export
doAuth <- function(save = T, localname = "default"){
  # create directory to save credentials and token
  # if necessary make sure directory is ignored by git
  if(save & !dir.exists(".google.auth")){
    dir.create(".google.auth", mode = "0700")
    if(!file.exists(".gitignore") & system2("git", "rev-parse") == 0){
      cat(".google.auth",file=".gitignore",sep="\n")
    }
    if(file.exists(".gitignore")){
      cat(".google.auth",file=".gitignore",append=TRUE)
    }
  }
  
  # attempt to load stored credentials and token if not get everything interactively 
  auth.file <- file.path(".google.auth", paste0(localname,"auth.RData"))
  if(file.exists(auth.file)){
    load(auth.file)
  } else{
    # do user interaction to store credentials in list
    # does not expire
    if(file.exists(".google.auth/credentials.RData")){
      load(".google.auth/credentials.RData")
    } else {
      credentials <- getCredentials()
      if(save){
        save("credentials", file = file.path(".google.auth","credentials.RData"))
      }
    }
    credentials <- getAuth(credentials)  
    access_token <- loadToken(credentials)
    # credentials can be saved in workspace 
    # for use with cron jobs etc
    google_auth <- list()
    google_auth$credentials <- credentials
    google_auth$access <- access_token
    
    if(save){
      save("google_auth",file=auth.file)
    }
  }
  
  if(exists("google_auth")){
    google_auth  
  } else {
    cat("an error occurred.")
  }
  
}

