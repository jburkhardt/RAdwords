#' @title Get Adwords Data
#' 
#' @aliases clientCustomerId transformation
#' 
#' @description getData posts the Adwords Query Language (awql) Statement which is generated with \code{\link{statement}}.
#' The data are retrieved from the Adwords API as a dataframe.
#' 
#' @param clientCustomerId Adwords client customer Id
#' @param access list that contains the access token information (expires)
#' @param credlist list that contains credentials information (does not expire)
#' @param statement awql statement generated with \code{\link{statement}}.
#' @param transformation If TRUE, data will be transformed with \code{\link{transformData}} into suitable R dataframe.
#' Else, the data are returned in raw format.
#' @param changeNames If TRUE, the display names of the transformed data are converted into more nicer/practical names. Requires transformation = TRUE
#' @export
#' @return Dataframe with the Adwords Data.
getData <- function(clientCustomerId, access,
                    credlist,
                    statement,
                    transformation=TRUE,
                    changeNames=TRUE){
  # because access token can expire 
  # we need to check whether this is the case
  if(as.numeric(Sys.time())-3600 >= access$timeStamp){
    refreshToken(access,credlist) 
  } 
  # getData posts the Adwords Query Language Statement and retrieves the data.
  #
  # Args:
  #   clientCustomerId: Adwords client customer Id
  #   statement: Object generated with statement() including the Api request.
  #   transformation: If true, transformData() will be applied on data. Else raw csv data will be returned.
  # 
  # Returns:
  #   Dataframe with the Adwords Data.
  google.auth <- paste(access$token_type, access$access_token)
  data <- getURL("https://adwords.google.com/api/adwords/reportdownload/v201402", httpheader = c("Authorization" = google.auth,
                                                                                                 "developerToken" = credlist$auth.developerToken,
                                                                                                 "clientCustomerId" = clientCustomerId,
                                                                                                 "returnMoneyInMicros" = "false"),
                 postfields=statement,
                 verbose = TRUE)
  if (transformation==TRUE){
    data <- transformData(data, report="ACCOUNT_PERFOMANCE_REPORT")
    if (changeNames==TRUE){
     data <-changeNames(data)
    }
  }
  data  
}
