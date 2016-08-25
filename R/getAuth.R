#' @title Authentication of R app
#' 
#' @description getAuth authenticates the R app at the Google authentication server using OAUTH2 and receives the client token.
#' Usually you need not to run getAuth() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' 
#' @importFrom utils browseURL
#' 
#' @param credentials data.frame with the credential information
#' 
#' @return credentials data frame with client token from Google authentication server appended,
#' which is optionally saved as RData file in .google.auth directory under the current working directory.
getAuth = function(credentials) {
  # This function uses the credentials (Client Id, Client Secret) from the Api project,
  # the developer token from the Adwords MCC and retrieves the client token from the Google authentication server.
  #
  # Returns:
  #   Client token from Google authentication server.

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
  
  # return credentials  
  credentials
}
