#' Invoke the Authentication Process with Google
#' 
#' This function starts the authentication process with Google. 
#' Note that this functions needs user interaction.
#' 
#' @param save logical denotes whether authentication information should be saved on disk. Defaults to TRUE.
#' @seealso \code{\link{getAuth}},\code{\link{loadToken}}
#' @export
doAuth <- function(save = T){
  # do user interaction to store credentials in list
  # does not expire
  if(file.exists(".google.auth.RData")){
    load(".google.auth.RData")
  } else{
    credentials <- getAuth()  
  }
    
  # now check whether we have unexpired 
  # access token from the file
  
  
  # get access token to communicate with API
  # access token can expire
  access_token <- loadToken(credentials)

  
  # credentials can be saved in workspace 
  # for use with cron jobs etc
  if(save){
    save(credentials,access_token,file=".google.auth.RData")
    
    # make sure your credentials are ignored by svn and git ####
    if (!file.exists(".gitignore")){
      cat(".google.auth.RData",file=".gitignore",sep="\n")
    } 
    if (file.exists(".gitignore")){
      cat(".google.auth.RData",file=".gitignore",append=TRUE)
    }
  }
  
  google_auth <- list()
  google_auth$credentials <- credentials
  google_auth$access <- access_token
  
  google_auth
  
}




