#' @title Show available Adwords Reports
#' 
#' @description reports provides an overview of all available Adwords report types. The report type is specified in \code{\link{statement}}.
#' 
#' @export
#' @return Available report types.
reports <- function(){
# Function which returns all available report types
#
# Args: None
#
# Returns:
#     Report types
reportTypes <- list.files(system.file(package="RAdwords",'extdata/'))
reportTypes <- sub('.csv','',reportTypes)
reportTypes
}
