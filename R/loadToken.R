#' @title Loading the Access Token
#' 
#' @description loadToken loads the access token using credentials provided by \code{\link{getAuth}}. Execution of function is possible only once per authentication process.
#' Usually you need not to run loadToken() explicitly since the whole authentication process is managed by \code{\link{getToken}}.
#' @export
#' @examples
#' loadToken()
#' @return Access token with corresponding time stamp.
loadToken = function() {
  # This function loads the access token using credentials from getAuth(). Execution of function is only possible once.
  #
  # Args:
  #   None - credentials as input.
  #
  # Returns:
  #   access.token with corresponding time stamp
  if(!exists('credentials')){
    return(print('Credential information cannot be found!'))
  }
  if(exists('credentials')){
    opts = list(verbose=T)
    a = fromJSON(postForm("https://accounts.google.com/o/oauth2/token", .opts=opts, code=credentials$c.token, client_id=credentials$c.id,
                          client_secret=credentials$c.secret, redirect_uri="urn:ietf:wg:oauth:2.0:oob", grant_type="authorization_code", 
                          style="POST"))
    if (length(a) == 1) {
      print('You need to update the token - run getAuth()')
    } else {
      assign("access.token.timeStamp", as.numeric(Sys.time()), envir = .GlobalEnv)
      assign("access.token", a, envir = .GlobalEnv)
    }
  }
}