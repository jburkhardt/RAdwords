#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @param apiVersion Supports 201509, 201601 or 201603. Default is 201603.
#' 
#' @export
#' @return Available report types.
reports <- function(apiVersion="201603"){
# Function which returns all available report types
#
# Args: None
#
# Returns:
#     Report types
  switch (apiVersion,
          "201603" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201603/')),
          "201601" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201601/')),
          "201509" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201509/'))
  )
  reportTypes <- sub('.csv','',reportTypes)
  reportTypes <- gsub('-','_',reportTypes)
  reportTypes <- toupper(reportTypes)
  reportTypes
}