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
#' @param start Beginning of date range. Format: 20120101
#' @param end End of date rage. Format: 20120110
#' 
#' @export
#' @examples
#' body <- statement(select=c('CampaignName','Clicks','Cost','Ctr'),
#'                   report="CAMPAIGN_PERFORMANCE_REPORT",
#'                   where="CampaignName STARTS_WITH 'A' AND Clicks > 100",
#'                   start="20140320",
#'                   end="20140321")
#' body <- statement(select=c('KeywordText','Clicks','Cost','Ctr'),
#'                   report="KEYWORDS_PERFORMANCE_REPORT",
#'                   where="Clicks > 100",
#'                   start="20140320",
#'                   end="20140321")    
#' body <- statement(select=c('Clicks','AveragePosition','Cost','Ctr','ClickConversionRate'),
#'                   report="ACCOUNT_PERFORMANCE_REPORT",
#'                   start="20140320",
#'                   end="20140321") 
#' @return The statement neccessary for the \code{\link{getData}} function.
statement <- function(select= c("AccountDescriptiveName",
                                "AccountId","Impressions",
                                "Clicks","Cost","Date"),
                      report="ACCOUNT_PERFORMANCE_REPORT",
                      where,
                      start="20120101",
                      end="20120110"){  
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
  #
  # Returns:
  #   The statement for the RCurl post.
  selectA <- paste(select,collapse=",")
  
  if(missing(where)){
    body <- paste("__rdquery=SELECT+",selectA,"+FROM+",report,"+DURING+",start,",",end,"&__fmt=CSV",sep='')
  }
  if(!missing(where)){
    body <- paste("__rdquery=SELECT+",selectA,"+FROM+",report,"+WHERE+",where,"+DURING+",start,",",end,"&__fmt=CSV",sep='')
  }
  # attach report Type as attributes of body
  attr(body,"reportType") <- report  
  return(body)
}
