#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' @param apiVersion Supports 201806, 201802, 201710. Defaults to 201806.
#' 
#' @importFrom utils read.csv
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT", apiVersion="201806"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  report <- gsub('_','-',report)
  report <- tolower(report)
  switch(apiVersion,
         "201806" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201806/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201802" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201802/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201710" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201710/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
         )
  metrics <- report$Name
  metrics
}