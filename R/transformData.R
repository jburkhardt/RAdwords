#' @title Transform data into R dataframe
#' 
#' @description Transforms the csv data file received from the Adwords API into a dataframe. Moreover the variables are converted into suitable formats.
#'  The function is used inside \code{\link{getData}} and parameters are set automatically.
#' 
#' @param data Raw csv data from Adwords API.
#' @param report Report type.
#' 
#' @export
#' 
#' @return Dataframe with the Adwords Data.
transformData <- function(data, report=reportType){
  # Transforms the csv into a dataframe. Moreover the variables are converted into suitable formats.
  #
  # Args:
  #   data: csv from Adwords Api
  #   report: Report type
  #
  # Returns:
  #   R Dataframe
  data <- read.csv2(textConnection(data),sep=",",header=F)[-1,]
  #Rename columns
  for(i in 1:ncol(data)){
    names(data)[i] <- as.character(data[1,i])
  }
  #eliminate row with names
  data <- data[-1,]
  #eliminate row with total values
  data <- data[-nrow(data),]
  #change data format of variables
  if("Day" %in% colnames(data)){
    data$Day <- as.Date(data$Day)
  }
  #get metrics for requestet report
  reportType <- read.csv(paste(system.file(package="RAdwords"),'/extdata/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  #elimitate % in data and convert percentage values into numeric data
  percVar <- as.character(reportType[grep('x.xx%',reportType$Notes),'Display.Name'])
  for(var in percVar){
    if(var %in% colnames(data)){
      data[,var] <- as.character(data[,var])
      data[,var] <- sub('%','',data[,var])
      data[,var] <- as.numeric(data[,var])
      data[,var] <- data[,var]/100
    }
  }
  #eliminate ',' thousend separater in data and convert values into numeric data
  metricVar <- as.character(subset(reportType, Behavior == 'Metric')$Display.Name)
  for(var in metricVar){
    if(var %in% colnames(data)){
      data[,var] <- as.character(data[,var])
      data[,var] <- sub(',','',data[,var])
      data[,var] <- as.numeric(data[,var])
    }
  }
  #eliminate " " spaces in column names
  names(data) <- gsub(" ","",names(data))
  return(data)
}