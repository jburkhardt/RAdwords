#' @title Get Adwords Data
#' 
#' @aliases clientCustomerId transformation
#' 
#' @description getData posts the Adwords Query Language (awql) Statement which is generated with \code{\link{statement}}.
#' The data are retrieved from the Adwords API as a dataframe.
#' 
#' @param clientCustomerId Adwords client customer Id
#' @param statement awql statement generated with \code{\link{statement}}.
#' @param transformation If TRUE, data will be transformed with \code{\link{transformData}} into suitable R dataframe.
#' Else, the data are returned in raw format.
#' @param changeNames If TRUE, the display names of the transformed data are converted into more nicer/practical names. Requires transformation = TRUE
#' @export
#' @examples
#' data <- getData(clientCustomerId='xxx-xxx-xxxx',statement=body,transformation=TRUE)
#' #body: object generated with statement()
#' @return Dataframe with the Adwords Data.
getData <- function(clientCustomerId, statement, transformation=TRUE, changeNames=TRUE){
  # getData posts the Adwords Query Language Statement and retrieves the data.
  #
  # Args:
  #   clientCustomerId: Adwords client customer Id
  #   statement: Object generated with statement() including the Api request.
  #   transformation: If true, transformData() will be applied on data. Else raw csv data will be returned.
  # 
  # Returns:
  #   Dataframe with the Adwords Data.
  if(!exists("access.token")){
    return("Access token is missing! Execute getToken()")
  }
  else{
  google.auth <- paste(access.token$token_type, access.token$access_token)
  data <- getURL("https://adwords.google.com/api/adwords/reportdownload/v201402", httpheader = c("Authorization" = google.auth,
                                                                                                 "developerToken" = credentials$auth.developerToken,
                                                                                                 "clientCustomerId" = clientCustomerId,
                                                                                                 "returnMoneyInMicros" = "false"),
                 postfields=statement,
                 verbose = TRUE)
  if (transformation==TRUE){
    data <- transformData(data, report=reportType)
    if (changeNames==TRUE){
     data <-changeNames(data)
    }
  }
  return(data)
  }
}