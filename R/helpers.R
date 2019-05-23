.getDataHelper <- function(clientCustomerId,
                           google_auth,
                           statement,
                           apiVersion = "201809",
                           transformation=TRUE,
                           changeNames=TRUE,
                           includeZeroImpressions=FALSE,
                           verbose=FALSE){
  
  # for a better overview split google auth
  access <- google_auth$access
  credlist <- google_auth$credentials
  
  # because access token can expire 
  # we need to check whether this is the case
  if(as.numeric(Sys.time())-3600 >= access$timeStamp){
    access <- refreshToken(google_auth) 
  } 
  # getData posts the Adwords Query Language Statement and retrieves the data.
  #
  # Args:
  #   clientCustomerId: Adwords Account Id
  #   statement: Object generated with statement() including the Api request.
  #   transformation: If true, transformData() will be applied on data. Else raw csv data will be returned.
  # 
  # Returns:
  #   Dataframe with the Adwords Data.
  google.auth <- paste(access$token_type, access$access_token)
  #cert <- system.file("CurlSSL", "ca-bundle.crt", package = "RCurl")#SSL certification Fix for Windows
  # data <- RCurl::getURL(paste("https://adwords.google.com/api/adwords/reportdownload/v",apiVersion,sep=""),
  #                       httpheader = c("Authorization" = google.auth,
  #                                       "developerToken" = credlist$auth.developerToken,
  #                                       "clientCustomerId" = clientCustomerId,
  #                                      "includeZeroImpressions" = includeZeroImpressions),
  #                postfields=statement,
  #                verbose = verbose,
  # #               cainfo = cert, #add SSL certificate
  #                ssl.verifypeer = TRUE)
  
  url <- paste("https://adwords.google.com/api/adwords/reportdownload/v",apiVersion,sep="")
  header <- c("Authorization" = google.auth,
              "developerToken" = credlist$auth.developerToken,
              "clientCustomerId" = clientCustomerId,
              "includeZeroImpressions" = includeZeroImpressions)
  if(attributes(statement)$compressed){
    data <- RCurl::getBinaryURL(url, 
                                httpheader = header,
                                postfields=statement,
                                verbose = verbose,
                                #                           cainfo = cert, #add SSL certificate
                                ssl.verifypeer = TRUE)
    tmp <- tempfile()
    if(.Platform$OS.type == "unix" && file.exists('/dev/shm') && file.info('/dev/shm')$isdir) {
      tmp <- tempfile(tmpdir = '/dev/shm')
    }
    on.exit(unlink(tmp), add = TRUE)
    writeBin(data, con=tmp)
    data <- paste(readLines(con <- gzfile(tmp), encoding = "UTF-8"), collapse = "\n")
    close(con)
  } else {
    data <- RCurl::getURL(url, 
                          httpheader = header,
                          postfields=statement,
                          verbose = verbose,
                          #                     cainfo = cert, #add SSL certificate
                          ssl.verifypeer = TRUE)
  }
  # check 
  valid <- grepl(attr(statement,"reportType"),data)
  
  if (transformation & valid){
    data <- transformData(data,
                          report = attributes(statement)$reportType,
                          apiVersion = apiVersion)
    if (changeNames){
      data <- changeNames(data)
    }
  }
  data 
  
}
