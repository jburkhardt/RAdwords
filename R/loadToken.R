#' @title Loading the Access Token
#' 
#' @description loadToken loads the access token using credentials provided by \code{\link{getAuth}}. Execution of function is possible only once per authentication process.
#' Usually you need not to run loadToken() explicitly since the whole authentication process is managed by \code{\link{doAuth}}.
#' @param credlist list of credentials
#' @export
#' @return Access token with corresponding time stamp.
loadToken = function(credlist) {
  # This function loads the access token using credentials from getAuth(). Execution of function is only possible once.
  #
  # Args:
  #   None - credentials as input.
  #
  # Returns:
  #   access.token with corresponding time stamp
  opts = list(verbose=T)
  a = fromJSON(postForm("https://accounts.google.com/o/oauth2/token", .opts=opts, code=credlist$c.token, client_id=credlist$c.id,
                        client_secret=credlist$c.secret, redirect_uri="urn:ietf:wg:oauth:2.0:oob", grant_type="authorization_code", 
                        style="POST"))
  if (length(a) == 1) {
    print('You need to update the token - run getAuth()')
  } else {
    access.token <- list()
    access.token$timeStamp <- as.numeric(Sys.time())
    access.token.obj <- a 
    # make sure your credentials are ignored by svn and git ####
    if (!file.exists(".gitignore")){
      cat(".access.token.RData",file=".gitignore",sep="\n")
    } 
    if (file.exists(".gitignore")){
      cat(".access.token.RData",file=".gitignore",append=TRUE)
    }
    if (file.exists(".svnignore")){
      cat(".access.token.RData",file=".svnignore",append=TRUE)
    }
    if (!file.exists(".svnignore")){
      cat(".access.token.RData",file=".svnignore",append=TRUE)
    }
    
    save(access.token, file=".access.token.RData")
    
  }
  
  access.token
  
}
