#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @param apiVersion Supports 201506 or 201502. Default is 201506.
#' 
#' @export
#' @return Available report types.
reports <- function(apiVersion="201506"){
# Function which returns all available report types
#
# Args: None
#
# Returns:
#     Report types
if (apiVersion=="201506"){
    reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201506/'))
    reportTypes <- sub('.csv','',reportTypes)
    reportTypes <- gsub('-','_',reportTypes)
    reportTypes <- toupper(reportTypes)
  }
else if (apiVersion=="201502"){
  reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201502/'))
  reportTypes <- sub('.csv','',reportTypes)
  reportTypes <- gsub('-','_',reportTypes)
  reportTypes <- toupper(reportTypes)
}
else if (apiVersion=="201409"){
  reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201409/'))
  reportTypes <- sub('.csv','',reportTypes)
}
reportTypes
}
