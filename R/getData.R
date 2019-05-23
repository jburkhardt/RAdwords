#' @title Get Adwords Data
#' 
#' @aliases clientCustomerId transformation
#' 
#' @description getData posts the Adwords Query Language (awql) Statement which is generated with \code{\link{statement}}.
#' The data are retrieved from the Adwords API as a dataframe.
#' 
#' @param clientCustomerId Adwords Account Id
#' @param google_auth list of authentication
#' @param statement awql statement generated with \code{\link{statement}}.
#' @param apiVersion supports 201809, 201806, 201802 defaults to 201806.
#' @param transformation If TRUE, data will be transformed with \code{\link{transformData}} into suitable R dataframe.
#' Else, the data are returned in raw format.
#' @param includeZeroImpressions If TRUE zero impressions will be included. Defaults to FALSE.
#' @param changeNames If TRUE, the display names of the transformed data are converted into more nicer/practical names. Requires transformation = TRUE
#' @param verbose Defaults to FALSE. If TRUE, the curl connection output will be printed.
#' 
#' @importFrom purrr map
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
  if(length(clientCustomerId)==1){
    data <- .getDataHelper(clientCustomerId = clientCustomerId,
                           google_auth = google_auth,
                           statement = statement,
                           apiVersion = apiVersion,
                           transformation = transformation,
                           changeNames = changeNames,
                           includeZeroImpressions = includeZeroImpressions,
                           verbose = verbose)
  } else {
    data_list <- purrr::map(.x = clientCustomerId,
                            .f = function(.x){.getDataHelper(clientCustomerId = .x,
                                                             google_auth = google_auth,
                                                             statement = statement,
                                                             apiVersion = apiVersion,
                                                             transformation = transformation,
                                                             changeNames = changeNames,
                                                             includeZeroImpressions = includeZeroImpressions,
                                                             verbose = verbose)})
    data <- do.call(rbind, data_list)
    
  }
  
  data
}