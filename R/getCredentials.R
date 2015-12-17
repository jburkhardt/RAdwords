#' @title Credentials of R app
#' 
#' @description getCredentials asks the user to provide the credentials (Client Id, Client Secret) from the Api project
#' and the developer token from the adwords MCC.
#' Usually you need not to run getCredentials() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' 
#' @return Dataframe with the credential information which is cached in working space 
#' and optionally saved as RData file in current working directory.
getCredentials <- function() {
  # This function asks for the credentials (Client Id, Client Secret) from the Api project,
  # the developer token from the Adwords MCC.
  # Moreover credentials optionally can be saved to the current working directory and .gitignore is generated for credentials.
  #
  # Inputs:
  #   Client Id from Google Api project.
  #   Client secret from Google Api project.
  #   Developer token from Adwords MCC.
  # 
  # Returns:
  #   Dataframe with the credential information which is cached in working space 
  #   and optionally saved as RData file the .google.auth directory under the current working directory.
  
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
  credentials
}