#' @title Refresh Access Token
#' 
#' @description refreshToken returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refreshToken() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' 
#' @param auth list of credentials and access token
#' @param service character name of the service. Defaults to 'google'. Could also be 'bing'.
#' @export
#' @return New access token with corresponding time stamp.
refreshToken = function(auth,service = 'google') {
  
  if(service == 'bing'){
    url <- sprintf('https://login.live.com/oauth20_token.srf?client_id=%s&client_secret=%s&grant_type=refresh_token&redirect_uri=%s&refresh_token=%s',
            auth$credentials$client_id,
            auth$credentials$client_secret,
            auth$credentials$redirect_uri,
            auth$credentials$refresh_token)
    access <- rjson::fromJSON(RCurl::postForm(url,style="POST"))
    access
  }
  
  # This function refreshes the access token. The access token deprecates after one hour and has to updated with the refresh token.
  #
  # Args:
  #   access.token$refreh_token and credentials as input
  # Returns:
  #   New access.token with corresponding time stamp
  if(service == 'google'){
    rt = rjson::fromJSON(RCurl::postForm('https://accounts.google.com/o/oauth2/token', 
                                         refresh_token=google_auth$access$refresh_token, 
                                         client_id=google_auth$credentials$c.id,
                                         client_secret=google_auth$credentials$c.secret, 
                                         grant_type="refresh_token", 
                                         style="POST"))
    access <- rt
    
    access
  }
    
}
