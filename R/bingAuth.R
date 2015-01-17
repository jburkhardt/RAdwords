bingAuth <- function(redirect_uri = 'https://login.live.com/oauth20_desktop.srf'){
  # clients
  cat('Please enter your BING client ID to initiate the first step of the authentication process.')
  client_id <- readline(as.character(cat("\n\nPaste the Client ID here",
                                    ":=>")))
  if(client_id == ""){
    return(print('You have to provide a Client ID.'))
  }
  
  url <- sprintf('https://login.live.com/oauth20_authorize.srf?client_id=%s&scope=bingads.manage&response_type=code&redirect_uri=%s',client_id,redirect_uri)
  
  browseURL(url)
  
  cat('Authentication process needs the authorization code. Copy the code from the URL.')
  code <- readline(as.character(cat("\n\nPaste authorization code (&code=XXXX) here",
                                         ":=>")))
  cat('Client secret needed')
  client_secret <- readline(as.character(cat("\n\nPaste the client secret",
                                         ":=>")))
  
  
  url1 <- sprintf("https://login.live.com/oauth20_token.srf?client_id=%s&client_secret=%s&code=%s&grant_type=authorization_code&redirect_uri=%s",
                  client_id,
                  client_secret,
                  code,
                  redirect_uri)
  
  credentials <- rjson::fromJSON(RCurl::getURL(url1))
  credentials$client_id <- client_id
  credentials$client_secret <- client_secret
  credentials$redirect_uri <- redirect_uri
  credentials
}


