#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' @param apiVersion Supports 201506 or 201502. Default is 201506.
#' 
#' @importFrom utils read.csv
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT", apiVersion="201506"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  if (apiVersion == "201506"){
    report <- gsub('_','-',report)
    report <- tolower(report)
    report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201506/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  }
  else if (apiVersion == "201502"){
    report <- gsub('_','-',report)
    report <- tolower(report)
    report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201502/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  }
  else if (apiVersion == "201409"){
    report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201409/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  }
  metrics <- report$Name
  metrics
}
