#' @title Refresh Access Token
#' 
#' @description refreshToken returns a new valid access token. The access token deprecates after one hour and has to updated with the refresh token.
#' Usually you need not to run refreshToken() explicitly since the whole authentication process is managed by \code{\link{getToken}}.
#' 
#' @export
#' @examples
#' refreshToken()
#' @return New access token with corresponding time stamp.
refreshToken = function() {
  # This function refreshes the access token. The access token deprecates after one hour and has to updated with the refresh token.
  #
  # Args:
  #   access.token$refreh_token and credentials as input
  # Returns:
  #   New access.token with corresponding time stamp
  if(!exists('access.token')){
    return(print('Access Token cannot be found! Execute getToken()'))
  }
  if(exists('access.token')){
    rt = fromJSON(postForm('https://accounts.google.com/o/oauth2/token', 
                           refresh_token=access.token$refresh_token, 
                           client_id=credentials$c.id,
                           client_secret=credentials$c.secret, 
                           grant_type="refresh_token", 
                           style="POST" ))
    access.token$access_token = rt$access_token
    access.token$expires_in = rt$expires_in
    assign("access.token.timeStamp", as.numeric(Sys.time()), envir = .GlobalEnv)
    assign("access.token", access.token, envir = .GlobalEnv)
  }
}