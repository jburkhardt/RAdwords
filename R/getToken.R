#' @title Managing the Authentication Process
#' 
#' @description getToken manages the whole authentication process and executes the required functions.
#' Meaning getToken authenticates the R app for the first time, loads the access token or refreshes the access token if expired.
#' Hence, you only run getToken() to authenticate whether it is your initial R session or a later instance.
#' 
#' @details If the authentication is done for the first time or there are no credential information provided, getToken executes \code{\link{getAuth}}
#' and \code{\link{loadToken}}. If the access token is expired, getToken executes \code{\link{refreshToken}}.\cr
#' Once the API projects for native application is set up, \code{\link{getAuth}} is able to authenticate the R app with the credentials (Client Id, Client Secret)
#' from the Google API project. The Google authentication server returns a client token, which later is used by \code{\link{loadToken}} to receive the access token.
#' If the access token is expired after one hour, it can be updated with \code{\link{refreshToken}}. The access token in combination with the 
#' Adwords developer token enables a connection with the Adwords API.\cr
#' \cr
#' getToken() asks for the credentials (Client Id, Client Secret) from the Api project, the developer token from the Adwords MCC and retrieves the client token
#' from the Google authentication server. The credential information are cached in a R object in the current workspace.\cr
#' Optionally the credentials and access token can be saved in hidden RData files in the current working directory. In this case the credentials and access token can be relaoded if
#' the workspace gets cleared, otherwise the credentials have to be provided again. If the credentials are saved in the current working directory,
#' a .gitignore is generated for the credential information or appends an existing .gitignore by the credential information.
#' 
#' @export
#' @import RCurl
#' @import rjson
#' @examples
#' getToken()
#' @return Access token.
getToken <- function(){
  # This function manages the whole authentication process and executes the relevant functions.
  if (exists(as.character(substitute(access.token)))){
    # case: access token exists in workspace
    if ((as.numeric(Sys.time()) - access.token.timeStamp) >= 3600){
      # case: access token is deprecated
      refreshToken()
    }
  }
  if (!exists(as.character(substitute(access.token)))){
    # access token does not exist in workspace
    if (file.exists('.access.token.RData')){
      # access token exists in RData file object in local working directory
      # loads token if RData file exists in working directory.
      load('.credentials.RData', envir= .GlobalEnv)
      load('.access.token.RData', envir = .GlobalEnv)
      refreshToken()
    }
    else {
      # case: no access token, no credentials
      credential_env <- getAuth()
      loadToken()
    }
  }
}
