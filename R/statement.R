#' @title Build Adwords Query Language Statement
#' 
#' @description Generates and builds the Adwords Query Language Statement for querying the Adwords API.
#' 
#' @param select Attributes
#' @param report Report type
#' @param where Condition list, e.g. "CampaignName STARTS_WITH 'A' AND Clicks > 100",
#' multiple conditions can be only combined with AND
#' Operators:  = | != | > | >= | < | <= | IN | NOT_IN | STARTS_WITH | STARTS_WITH_IGNORE_CASE |
#' CONTAINS | CONTAINS_IGNORE_CASE | DOES_NOT_CONTAIN | DOES_NOT_CONTAIN_IGNORE_CASE
#' @param start Beginning of date range. Format: 2018-01-01
#' @param end End of date rage. Format: 2018-01-10
#' @param compress TRUE / FALSE, Gzipped data download if TRUE
#' 
#' @export
#' @examples
#' body <- statement(select=c('CampaignName','Clicks','Cost','Ctr'),
#'                   report="CAMPAIGN_PERFORMANCE_REPORT",
#'                   where="CampaignName STARTS_WITH 'A' AND Clicks > 100",
#'                   start="2018-01-20",
#'                   end="2018-01-21")
#' body <- statement(select=c('Criteria','Clicks','Cost','Ctr'),
#'                   report="KEYWORDS_PERFORMANCE_REPORT",
#'                   where="Clicks > 100",
#'                   start="2018-01-20",
#'                   end="2018-01-21")    
#' body <- statement(select=c('Clicks','AveragePosition','Cost','Ctr','ClickConversionRate'),
#'                   report="ACCOUNT_PERFORMANCE_REPORT",
#'                   start="2018-01-20",
#'                   end="2018-01-21") 
#' @return The statement neccessary for the \code{\link{getData}} function.
statement <- function(select = c("AccountDescriptiveName",
                                 "AccountId",
                                 "Impressions",
                                 "Clicks",
                                 "Cost",
                                 "Date"),
                      report = "ACCOUNT_PERFORMANCE_REPORT",
                      where,
                      start = "2018-01-01",
                      end = "2018-01-10",
                      compress = FALSE){  
  # Generates and builds the Adwords Query Language Statement for querying the Adwords API.
  #
  # Args:
  #   select: Attributes
  #   report: Report type
  #   where:  Condition list, e.g. "CampaignName STARTS_WITH 'D_' AND Clicks > 100",
  #           multiple conditions can be only combined with AND
  #           Operators:  = | != | > | >= | < | <= | IN | NOT_IN | STARTS_WITH | STARTS_WITH_IGNORE_CASE |
  #                       CONTAINS | CONTAINS_IGNORE_CASE | DOES_NOT_CONTAIN | DOES_NOT_CONTAIN_IGNORE_CASE
  #   start:  Start date
  #   end:    End date
  #   compress: TRUE / FALSE, Gzipped data download if TRUE
  #
  # Returns:
  #   The statement for the RCurl post.
  start <- gsub("-", "", start)
  end <- gsub("-", "", end)
  selectA <- paste(select, collapse = ",")
  fmt <- if(compress) "GZIPPED_CSV" else "CSV"
  if(missing(where)){
    body <- sprintf("__rdquery=SELECT+%s+FROM+%s+DURING+%s,%s&__fmt=%s",selectA,report,start,end,fmt)
  }
  if(!missing(where)){
    body <- sprintf("__rdquery=SELECT+%s+FROM+%s+WHERE+%s+DURING+%s,%s&__fmt=%s",selectA,report,where,start,end,fmt)
  }
  # reports without statistics and date column
  if(report %in% c("LABEL_REPORT",
                   "CAMPAIGN_NEGATIVE_KEYWORDS_PERFORMANCE_REPORT",
                   "CAMPAIGN_NEGATIVE_LOCATIONS_REPORT",
                   "CAMPAIGN_NEGATIVE_PLACEMENTS_PERFORMANCE_REPORT")){
    body <- sprintf("__rdquery=SELECT+%s+FROM+%s&__fmt=%s",selectA,report,fmt)
    print(sprintf("The Adwords API does not support date ranges in the %s. Thus, date ranges will be ignored.", report))
  }
  # attach report Type and compression as attributes of body
  attr(body,"reportType") <- report
  attr(body,"compressed") <- compress
  return(body)
}