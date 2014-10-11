#' Invoke the Authentication Process with Google
#' 
#' This function starts the authentication process with Google. 
#' Note that this functions needs user interaction.
#' 
#' @seealso \code{\link{getAuth}},\code{\link{loadToken}}
#' @export
doAuth <- function(){
  # do user interaction to store credentials in list
  # does not expire
  credentials <- getAuth()
  # get access token to communicate with API
  # access token can expire
  access_token <- loadToken(credentials)
  access_token
}




