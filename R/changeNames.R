#' @title Change Names of Attributes/variables
#' 
#' @description Converts the default display names into nicer or more practical names.
#' 
#' @param data Transformed dataframe
#' 
#' @export
#' 
#' @return New column names of dataframe.
changeNames <- function(data){
  names(data)[names(data)=="Avg.CPC"] <- "CPC"
  names(data)[names(data)=="Avg.position"] <- "Position"
  names(data)[names(data)=="Clickconversionrate"] <- "CVR"
  names(data)[names(data)=="Convertedclicks"] <- "Conversions"
  names(data)[names(data)=="Totalconv.value"] <- "ConversionValue"
  names(data)[names(data)=="Cost/convertedclick"] <- "CPO"
  names(data)[names(data)=="Value/convertedclick"] <- "ValuePerConversion"
  names(data)[names(data)=="Value/conv."] <- "ValuePerConversion"
  return(data)
}