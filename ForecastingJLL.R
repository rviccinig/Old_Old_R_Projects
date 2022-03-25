#FORECASTING uSING TIME sERIES ANALYSIS

library("timeSeries")
library("knitr")
library("normtest")
library("moments")
library("likelihood")
library("TTR")
library("forecast")
library("portes")
library("tseries")
library("fUnitRoots")
library("Quandl")
library("xlsx")
library("MASS")
library("urca")
library("lmtest")
library("dplyr")
library("vars")
library("rugarch")
library("ggplot2")
library("reshape2")
library("lubridate")
library("scales")
library("gridExtra")
library("ggthemes")
library('mgarchBEKK')
library("quantmod")
library("egcm")
library("FinTS")
library("knitr")
library("zoo")
library("normtest")

# JLL National
Histdatanational<-read.csv("C:/Users/reinaldo.viccini/Desktop/Desktop Folder/Historical Data of Office Research/CSV Version/HistNationalVac.csv",header = TRUE,sep=",")
str(Histdatanational)
#Fixing dates
Histdatanational$date2<- as.character(Histdatanational$Date)
Histdatanational$date2<- paste("01-", Histdatanational$date2, sep = "")
Histdatanational$date2<-as.Date(Histdatanational$date2, format = "%d-%y-%b")

#Delete non-Important Variables
Histdatanational<-Histdatanational[,-c(1,2,3)]
Calgary<-Histdatanational[,c(20)]

#TRansformed into a TS object, When Frequency is 4 it becomes a quarter.
Calgary<-ts(Calgary,frequency=4, start=c(2010),end=c(2019))

#Check Stationarity of the Series
ajb.norm.test(Calgary, nrepl=2000)
geary.norm.test(Calgary, nrepl=2000)
skewness(Calgary)
kurtosis(Calgary)
adf.test(Calgary)
pp.test(Calgary)

#Lets graph log prices
plot.ts(Calgary)
plot(decompose(Calgary)) 
forecasts<-HoltWinters(Calgary, beta=FALSE, gamma=FALSE) # Forecasting using First diferences
plot(forecasts)

#More forecasting # aRIMA (0,1,0) IS A RANDOM WALK. mEANING THAT MY MODEL IS USELESS
Fit <- Arima(log(Calgary),order=c(0,1,0)) 
auto.arima(Calgary)
plot(forecast(Fit,h=10))
fort<-forecast(Fit,h=10)

#Extract the data for ggplot
pd<-funggcast(Calgary,fort)


