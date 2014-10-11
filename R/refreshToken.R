#' @title Refresh Access Token
#' 
#' @description refreshToken returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refreshToken() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' 
#' @param credlist list of credentials
#' @param access list that contains access token information 
#' @export
#' @return New access token with corresponding time stamp.
refreshToken = function(access,credlist) {
  # This function refreshes the access token. The access token deprecates after one hour and has to updated with the refresh token.
  #
  # Args:
  #   access.token$refreh_token and credentials as input
  # Returns:
  #   New access.token with corresponding time stamp
  
    rt = fromJSON(postForm('https://accounts.google.com/o/oauth2/token', 
                           refresh_token=access$refresh_token, 
                           client_id=credlist$c.id,
                           client_secret=credlist$c.secret, 
                           grant_type="refresh_token", 
                           style="POST"))
    access <- rt
    
    access
}
