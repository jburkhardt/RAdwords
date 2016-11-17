#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @param apiVersion Supports 201609, 201607, 201605. Default is 201609.
#' 
#' @export
#' @return Available report types.
reports <- function(apiVersion="201609"){
# Function which returns all available report types
#
# Args: None
#
# Returns:
#     Report types
  switch (apiVersion,
          "201609" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201609/')),
          "201607" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201607/')),
          "201605" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201605/'))
  )
  reportTypes <- sub('.csv','',reportTypes)
  reportTypes <- gsub('-','_',reportTypes)
  reportTypes <- toupper(reportTypes)
  reportTypes
}