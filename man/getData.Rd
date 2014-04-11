\name{getData}
\alias{clientCustomerId}
\alias{getData}
\alias{transformation}
\title{Get Adwords Data}
\usage{
getData(clientCustomerId, statement, transformation = TRUE)
}
\arguments{
  \item{clientCustomerId}{Adwords client customer Id}

  \item{statement}{awql statement generated with
  \code{\link{statement}}.}

  \item{transformation}{If TRUE, data will be transformed
  with \code{\link{transformData}} into suitable R
  dataframe. Else, the data are returned in raw format.}
}
\value{
Dataframe with the Adwords Data.
}
\description{
getData posts the Adwords Query Language (awql) Statement
which is generated with \code{\link{statement}}. The data
are retrieved from the Adwords API as a dataframe.
}
\examples{
data <- getData(clientCustomerId='xxx-xxx-xxxx',statement=body,transformation=TRUE)
#body: object generated with statement()
}

