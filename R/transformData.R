#' @title Transform data into R dataframe
#' 
#' @description Transforms the csv data file received from the Adwords API into a dataframe. Moreover the variables are converted into suitable formats.
#'  The function is used inside \code{\link{getData}} and parameters are set automatically.
#' 
#' @param data Raw csv data from Adwords API.
#' @param report Report type.
#' @param apiVersion set automatically by \code{\link{getData}}. Supported are 201502 or 201409. Default is 201502.
#' 
#' @export
#' 
#' @return Dataframe with the Adwords Data.
transformData <- function(data,
                          report=reportType,
                          apiVersion="201502"){
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
  #get metrics for requested report
  if (apiVersion=="201502"){
    report <- gsub('_','-',report)
    report <- tolower(report)
    reportType <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201502/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  }
  else if (apiVersion=="201409"){
    reportType <- read.csv(paste(system.file(package="RAdwords"),'/extdata/api201409/',report,'.csv',sep=''), sep = ',', encoding = "UTF-8")
  }
  #transform factor into character
  i <- sapply(data, is.factor)
  data[i] <- lapply(data[i], as.character)
  #elimitate % in data and convert percentage values into numeric data
  #find % values
  doubleVar <- as.character(subset(reportType, Type == 'Double')$Display.Name)
  for(var in doubleVar){
    if(var %in% colnames(data)){
      data[,var] <- sub("%","",data[,var])
      data[,var] <- as.numeric(data[,var])/100 
    }
  }
#   perVar <- as.numeric(grep("%",data))
#   #kill % and divide by 100
#   for(i in perVar){
#     data[,i] <- sub("%","",data[,i])
#     data[,i] <- as.numeric(data[,i])/100 
#   }
  Behavior = NULL
  #eliminate ',' thousend separater in data and convert values into numeric data
  metricVar <- as.character(subset(reportType, Behavior == 'Metric')$Display.Name)
  for(var in metricVar){
    if(var %in% colnames(data)){
      data[,var] <- as.character(data[,var])
      data[,var] <- sub(',','',data[,var])
      data[,var] <- as.numeric(data[,var])
    }
  }
  #since v201409 returnMoneyInMicros is deprecated, convert all monetary values
  Type <- NULL
  monetaryVar <- as.character(subset(reportType, Type == "Money")$Display.Name)
  for (var in monetaryVar) {
    if (var %in% colnames(data)) {
      data[,var] <- as.character(data[,var]) #Variables like Max. CPC are not recognized as metric in previous task since their "Behavior" is "Attribute". Hence convert all "Money" metrics in numeric again.
      data[,var] <- suppressWarnings(as.numeric(data[,var]))
      data[, var] <- data[, var] / 1000000 #convert into micros
    }
  }
  #eliminate " " spaces in column names
  names(data) <- gsub(" ","",names(data))
  return(data)
}
