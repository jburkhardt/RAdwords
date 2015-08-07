#' @title Authentication of R app
#' 
#' @description getAuth authenticates the R app at the Google authentication server using OAUTH2 and receives the client token.
#' Usually you need not to run getAuth() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' 
#' @importFrom utils browseURL
#' 
#' @return Client token from Google authentication server.
#' Dataframe with the credential information which is cached in working space 
#' and optionally saved as RData file in current working directory.
getAuth = function() {
  # This function asks for the credentials (Client Id, Client Secret) from the Api project,
  # the developer token from the Adwords MCC and retrieves the client token from the Google authentication server.
  # Moreover credentials optionally can be saved to the current working directory and .gitignore is generated for credentials.
  #
  # Inputs:
  #   Client Id from Google Api project.
  #   Client secret from Google Api project.
  #   Developer token from Adwords MCC.
  # 
  # Returns:
  #   Client token from Google authentication server.
  #   Dataframe with the credential information which is cached in working space 
  #   and optionally saved as RData file in current working directory.
  
  if(!exists('credentials')){
    cat('Authentication process needs your Client ID from the Adwords API project for native apps.')
    c.id <- readline(as.character(cat("\n\nPaste the Client ID here",
                                      ":=>")))
    if(c.id == ""){
      return(print('You have to provide a Client ID from the Adwords API Project for native apps.'))
    }
    else {
      credentials <- data.frame(c.id)
      cat('Authentication process needs your Client secret from the Adwords API project.')
      credentials$c.secret <- readline(as.character(cat("\n\nPaste the Client secret here",
                                                        ":=>")))
      cat('Authentication process needs your Developer Token from the Adwords MCC.')
      credentials$auth.developerToken <- readline(as.character(cat("\n\nPaste the Developer Token here",
                                                                   ":=>")))
    }
  }
  
  if(exists('credentials')){
    url <- paste('https://accounts.google.com/o/oauth2/auth?',
                 'client_id=', credentials$c.id, '&',
                 'response_type=code&',
                 'scope=https%3A%2F%2Fadwords.google.com%2Fapi%2Fadwords%2F&', #changed to adwords
                 'redirect_uri=urn:ietf:wg:oauth:2.0:oob&',
                 'access_type=offline&',
                 'approval_prompt=force', sep='', collapse='')
    cert <- system.file("CurlSSL", "ca-bundle.crt", package = "RCurl")#SSL Certificate Fix for Windows
    RCurl::getURL(url, cainfo=cert, ssl.verifypeer = TRUE) # Explicitly setting certificate verification for an error in OS X
    browseURL(url)
    # Manual next-step: input code-parameter to c.token variable and run loadToken()
    cat('Authentication process needs your Client token in order to receive the access token from the API. Copy the Client token from your webbrowser and paste it here.')
    credentials$c.token <- readline(as.character(cat("\n\nPaste the client token here",
                                                     ":=>")))
  }
  # return one environment that contains all the values...
  # call it by credential_env <- getAuth()    
  credentials
}
