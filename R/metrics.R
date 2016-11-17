#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' @param apiVersion Supports 201609, 201607, 201605. Default is 201609.
#' 
#' @importFrom utils read.csv
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT", apiVersion="201609"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  report <- gsub('_','-',report)
  report <- tolower(report)
  switch(apiVersion,
         "201609" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201609/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201607" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201607/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8"),
         "201605" = report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201605/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
         )
  metrics <- report$Name
  metrics
}