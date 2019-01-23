#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @param apiVersion Supports 201809, 201806 and 201802. Defaults to 201809.
#' 
#' @export
#' @return Available report types.
reports <- function(apiVersion = "201809"){
# Function which returns all available report types
# Args: apiVersion
# Returns: Report types
  switch (apiVersion,
          "201809" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201809/')),
          "201806" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201806/')),
          "201802" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201802/'))
  )
  
  reportTypes <- sub('.csv', '', reportTypes)
  reportTypes <- gsub('-', '_', reportTypes)
  reportTypes <- toupper(reportTypes)
  reportTypes
}