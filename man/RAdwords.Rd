\name{RAdwords}
\alias{RAdwords}
\title{Loading Google Adwords Data into R}
\description{
    The aim of \strong{RAdwords} is loading Google Adwords data into R. Therefore the
    package implements three main features.\cr
    First, the package provides an \strong{authentication process} for \strong{R} with the \strong{Adwords API} via OAUTH2.\cr
    Second, the package offers an interface to apply the \href{https://developers.google.com/adwords/api/docs/guides/awql}{Adwords query language} in R and \strong{query the Adwords API} with \href{https://developers.google.com/adwords/api/docs/guides/reporting}{ad-hoc reports}.\cr
    Third, the received \strong{data are transformed into suitable data format} for further data processing
    and data analysis.
}

\details{
\strong{Requirements:}\cr
In order to access the Adwords API you have to set up a \href{https://developers.google.com/console/help/}{Google API project} for native apps. The Google API project provides a \strong{Client Id} and \strong{Client Secret} which is necessary for the authentication. Moreover you need to have a \href{https://developers.google.com/adwords/api/docs/signingup}{Adwords MCC} (My Client Center) with an \strong{Adwords developer token}.\cr
\cr
\strong{Authentication:}\cr
\code{\link{doAuth}} manages the complete authentication process. Meaning \code{\link{doAuth}} authenticates the R app for the first time, loads the access token or refreshes the access token if expired. Hence, you only run doAuth() to authenticate whether it is your initial R Session or a later instance.\cr
\cr
What's happening in details?\cr
Once the API projects for native application is set up, \code{\link{getAuth}} is able to authenticate the R app with the credentials (Client Id, Client Secret) from the Google API project. The Google authentication server returns a client token, which later is used by \code{\link{loadToken}} to receive the access token. If the access token is expired after one hour, it can be updated with \code{\link{refreshToken}}. The access token in combination with the Adwords developer token enables a connection with the Adwords API.\cr
\cr
\strong{Create Statement:}\cr
\code{\link{statement}} creates the Adwords Query Language Statement.\cr
\cr
\strong{Receiving Data:}\cr
\code{\link{getData}} queries the data from the Adwords API and transforms the data into an R dataframe.\cr
}

\examples{
\dontrun{
Authentication:
google_auth <- doAuth()
Create Statement:
body <- statement(select=c('Clicks','AveragePosition','Cost','Ctr'),
                  report="ACCOUNT_PERFORMANCE_REPORT",
                  start="2016-03-20",
                  end="2016-03-21")
Query Adwords API and load data as dataframe:
data <- getData(clientCustomerId='xxx-xxx-xxxx', #use Adwords Account Id (MCC Id will not work)
                google_auth=google_auth,
                statement=body)
Get available report types:
reports()
Get available metrics/attributes of specific report type:
metrics(report='ACCOUNT_PERFORMANCE_REPORT')
}
}

\author{
Johannes Burkhardt <johannes.burkhardt@gmail.com>\cr
Matthias Bannert <matthias.bannert@gmail.com>\cr
\url{https://github.com/jburkhardt/RAdwords}
}

\keyword{ ~Adwords }
\keyword{ ~Google Adwords }
\keyword{ ~Adwords API }
\keyword{ ~Google Adwords API }
\keyword{ ~Adwords Report }
\keyword{ ~Google Adwords Report }
