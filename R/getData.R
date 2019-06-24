#' @title Get Adwords Data
#' 
#' @aliases clientCustomerId transformation
#' 
#' @description getData posts the Adwords Query Language (awql) Statement which is generated with \code{\link{statement}}.
#' The data are retrieved from the Adwords API as a dataframe.
#' 
#' @param clientCustomerId Adwords Account Id; supports a single account id: "xxx-xxx-xxxx" or a vector of ids from the same Google Ads MCC: c("xxx-xxx-xxxx", "xxx-xxx-xxxx")
#' @param google_auth list of authentication
#' @param statement awql statement generated with \code{\link{statement}}.
#' @param apiVersion supports 201809, 201806, 201802 defaults to 201806.
#' @param transformation If TRUE, data will be transformed with \code{\link{transformData}} into suitable R dataframe.
#' Else, the data are returned in raw format.
#' @param includeZeroImpressions If TRUE zero impressions will be included. Defaults to FALSE.
#' @param changeNames If TRUE, the display names of the transformed data are converted into more nicer/practical names. Requires transformation = TRUE
#' @param verbose Defaults to FALSE. If TRUE, the curl connection output will be printed.
#' 
#' @export
#' 
#' @return Dataframe with the Adwords Data.
getData <- function(clientCustomerId,
                    google_auth,
                    statement,
                    apiVersion = "201809",
                    transformation=TRUE,
                    changeNames=TRUE,
                    includeZeroImpressions=FALSE,
                    verbose=FALSE){
  # applies .getDataHelper for each account and saves data in list object
  data_list <- lapply(X = clientCustomerId,
                      FUN = .getDataHelper,
                      google_auth = google_auth,
                      statement = statement,
                      apiVersion = apiVersion,
                      transformation = transformation,
                      changeNames = changeNames,
                      includeZeroImpressions = includeZeroImpressions,
                      verbose = verbose)
  # binds list to dataframe
  data <- do.call(rbind, data_list)
  # return
  data
}
