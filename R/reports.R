#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @param apiVersion Supports 201802 and 201710. Defaults to 201802.
#' 
#' @export
#' @return Available report types.
reports <- function(apiVersion = "201802"){
# Function which returns all available report types
# Args: apiVersion
# Returns: Report types
  switch (apiVersion,
          "201802" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201802/')),
          "201710" = reportTypes <- list.files(system.file(package="RAdwords",'extdata/api201710/'))
  )
  reportTypes <- sub('.csv', '', reportTypes)
  reportTypes <- gsub('-', '_', reportTypes)
  reportTypes <- toupper(reportTypes)
  reportTypes
}