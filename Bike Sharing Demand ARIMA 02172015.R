## Read the data
bike_train<-read.csv("train.csv",stringsAsFactors=FALSE,header=TRUE)
str(bike_train)

## Read columns names
names(bike_train)

## Read first 10 rows of data
head(bike_train, n=10)
str(bike_train)

## Install packages

install.packages("tseries", "forecast", dependencies=TRUE)
library("forecast"", "tseries"")

install.packages("forecast")
library(forecast)

#plot only Registered Users
RegUsers <- bike_train$registered
plot(RegUsers) 

## Store data in a column (say RegUsersDaily) as time series daily data:

RegUsersDaily <- ts(bike_train$registered, frequency=7)

plot(RegUsersDaily)

RegUsersMonthly <- ts(bike_train$registered, frequency=30)

plot(RegUsersMonthly)

RegUsersYearly <- ts(bike_train$registered, frequency=365.25)

plot(RegUsersYearly)

## Seasonality:

RegUsersSeas <- msts(bike_train$registered, seasonal.periods=c(7,365.25))

## Perform auto arima on Daily Registered time series data using auto.arima() function of “forecast” package

auto.arima(RegUsersDaily)

## We get:

## ARIMA(5,1,5)(2,0,2)[7] with drift         

## Coefficients:
##   ar1     ar2     ar3      ar4      ar5     ma1      ma2      ma3     ma4     ma5
## -0.0557  0.6858  0.6282  -0.1734  -0.4665  0.2412  -1.1072  -1.1139  0.2218  0.8154
## s.e.   0.0124  0.0123  0.0113   0.0114   0.0121  0.0091   0.0083   0.0082  0.0096  0.0081
## sar1    sar2     sma1     sma2   drift
## 0.0814  0.6264  -0.3670  -0.4717  0.0162
## s.e.  0.0231  0.0173   0.0228   0.0169  0.0585

## sigma^2 estimated as 5383:  log likelihood=-62198.37
## AIC=124428.7   AICc=124428.8   BIC=124545.5

## ALTERNATIVE

RegUsers.fit <- tbats(RegUsersDaily)

## Forecast it:

RegUsers.fc <- forecast(RegUsers.fit)

## Plot Registered Users Forecast: 

plot(RegUsers.fc)

## Seasonal decomposition, use the decompose() function in R

RegUsersDaily.dc <- decompose(RegUsersDaily)

## To print the first 10 estimated values of the seasonal component:

head(RegUsersDaily.dc$seasonal, n=10)

## We get: 

## [1] -0.9636416 -1.2614905  0.7981712  1.3946182 -0.4845734  0.7993663 -0.2824502 -0.9636416
## [9] -1.2614905  0.7981712

## Plot the decomposed series:

plot(RegUsersDaily.dc)
