#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' @param apiVersion Supports 201702, 201708, 201710. Defaults to 201710.
#' 
#' @importFrom utils read.csv
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT", apiVersion="201710"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  report <- gsub('_','-',report)
  report <- tolower(report)
  switch(apiVersion,
         "201702" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201702/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201708" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201708/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201710" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201710/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
         )
  metrics <- report$Name
  metrics
}