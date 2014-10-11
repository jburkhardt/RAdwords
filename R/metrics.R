#' @title Get Metrics/Attributes of specified Report
#' 
#' @description metrics provides an overview of all available metrics/attributes for a specified report type.
#' 
#' @param report Report type
#' 
#' @export
#' @return List of available metrics/attributes.
#' 
metrics <- function(report="ACCOUNT_PERFORMANCE_REPORT"){
  # Function which returns all available metrics for a specific report.
  #
  # Args:
  #   report: Report type
  # Returns:
  #   Available metrics
  report <- read.csv(paste(system.file(package="RAdwords"),'/extdata/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  metrics <- report$Name
  return(metrics)
}
