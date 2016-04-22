#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' @param apiVersion Supports 201509, 201601 or 201603. Default is 201603.
#' 
#' @importFrom utils read.csv
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT", apiVersion="201603"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  report <- gsub('_','-',report)
  report <- tolower(report)
  switch(apiVersion,
         "201603" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201603/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201601" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201601/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201509" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201509/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
         )
  metrics <- report$Name
  metrics
}