## RAdwords: Getting Adwords data into R ##

**RAdwords** is a R package with the aim to load Adwords data into R. Therefore the package implements three main features.
First, the package provides an **authentication process** for **R** with the **Adwords API** via OAUTH2.
Second, the package offers an interface to apply the [Adwords query language](https://developers.google.com/adwords/api/docs/guides/awql) in R and **query the Adwords API** with [ad-hoc reports](https://developers.google.com/adwords/api/docs/guides/reporting}{ad-hoc reports).
Third, the received **data are transformed into suitable data formats** for further data processing and data analysis.


### Installation ###

The package can be installed directly from this repository with:

require(devtools)  
install_github('RAdwords', 'jburkhardt')


### Usage ###

#### Requirements: ####
In order to access the Adwords API you have to set up a [Google API project](https://developers.google.com/console/help/) for native apps. The Google API project provides a **Client Id** and **Client Secret** which is necessary for the authentication. Moreover you need to have a [Adwords MCC](https://developers.google.com/adwords/api/docs/signingup) with an **Adwords developer token**.

#### Authentication: ####
The function `<getToken>` manages the complete authentication process. Meaning `<getToken>` authenticates the R app for the first time, loads the access token or refreshes the access token if expired. Hence, you only run `<getToken()>` to authenticate whether it is your initial R Session or a later instance.

##### What's happening in details? #####
Once the API projects for native application is set up, `<getAuth>` is able to authenticate the R app with the credentials (Client Id, Client Secret) from the Google API project. The Google authentication server returns a client token, which later is used by `<loadToken>` to receive the access token. If the access token is expired after one hour, it can be updated with `<refreshToken>`. The access token in combination with the Adwords developer token enables a connection with the Adwords API.

#### Create Statement: ####
`<statement>` creates the Adwords Query Language Statement.

#### Receiving Data: ####
`<getData>` queries the data from the Adwords API and transforms the data into an R dataframe.

### Example ###

#### Authentication ####
getToken()
#### Create Statement ####
body <- statement(select=c('Clicks','AveragePosition','Cost','Ctr'),
                  report="ACCOUNT_PERFORMANCE_REPORT",
                  start="20140320",
                  end="20140321")
#### Query Adwords API and get data as dataframe ####
data <- getData(clientCustomerId='xxx-xxx-xxxx',statement=body)
#### Get available report types ####
reports()
#### Get available metrics/attributes of specific reporty type ####
metrics(report='ACCOUNT_PERFORMANCE_REPORT')