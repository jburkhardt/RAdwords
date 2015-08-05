#' @title Get Adwords Data
#' 
#' @aliases clientCustomerId transformation
#' 
#' @description getData posts the Adwords Query Language (awql) Statement which is generated with \code{\link{statement}}.
#' The data are retrieved from the Adwords API as a dataframe.
#' 
#' @param clientCustomerId Adwords client customer Id
#' @param google_auth list of authentication
#' @param statement awql statement generated with \code{\link{statement}}.
#' @param apiVersion supports 201506 or 201502, where default is 201506.
#' @param transformation If TRUE, data will be transformed with \code{\link{transformData}} into suitable R dataframe.
#' Else, the data are returned in raw format.
#' @param changeNames If TRUE, the display names of the transformed data are converted into more nicer/practical names. Requires transformation = TRUE
#' @export
#' @return Dataframe with the Adwords Data.
getData <- function(clientCustomerId,
                    google_auth,
                    statement,
                    apiVersion = "201506",
                    transformation=TRUE,
                    changeNames=TRUE){
  
  # for a better overview split google auth
  access <- google_auth$access
  credlist <- google_auth$credentials
  
  # because access token can expire 
  # we need to check whether this is the case
  if(as.numeric(Sys.time())-3600 >= access$timeStamp){
    access <- refreshToken(google_auth) 
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
  cert <- system.file("CurlSSL", "ca-bundle.crt", package = "RCurl")#SSL certification Fix for Windows
  data <- RCurl::getURL(paste("https://adwords.google.com/api/adwords/reportdownload/v",apiVersion,sep=""), httpheader = c("Authorization" = google.auth,
                                                                                                 "developerToken" = credlist$auth.developerToken,
                                                                                                 "clientCustomerId" = clientCustomerId),
                 postfields=statement,
                 verbose = TRUE,
                 cainfo = cert, #add SSL certificate
                 ssl.verifypeer = TRUE)
  if (transformation==TRUE){
    data <- transformData(data,report=attributes(statement)$reportType,apiVersion=apiVersion)
    if (changeNames==TRUE){
     data <-changeNames(data)
    }
  }
  data  
}
