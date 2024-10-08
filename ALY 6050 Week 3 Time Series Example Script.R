

### from the class lecture
rm(list=ls())
dev.off(dev.list()["RStudioGD"]) # get rid of all plots




### example of times series and panel regression with stock prices

rm(list=ls())
getwd()

# AAPL stock
#install.packages("quantmod",dependencies=T)
library(quantmod)
library(forecast)

See quantmod: 
https://www.r-bloggers.com/2015/10/a-guide-on-r-quantmod-package-how-to-get-started/


# VAR model (time series as a function of multiple other time series)

getSymbols("aapl") # from  finance
getSymbols("msft") # from  finance
getSymbols("intc") # from  finance
getSymbols("hd") # from  finance
getSymbols("dis") # from  finance
together <- cbind(AAPL,INTC,MSFT,DIS,HD)

# example of VAR (Vector Autoregressive Model)
model <- lm(data=together, AAPL.Close ~ INTC.Close + MSFT.Close + DIS.Close + HD.Close)
summary(model)

together$AAPL.Close_0 <- lag(together$AAPL.Close, 0)
together$AAPL.Close_1 <- lag(together$AAPL.Close, 1)
together$AAPL.Close_2 <- lag(together$AAPL.Close, 2)
together$AAPL.Close_3 <- lag(together$AAPL.Close, 3)

# AR(1), AR(2), and AR(3) by hand
head(together)
summary(lm(data=together, AAPL.Close_0 ~ AAPL.Close_1 ))
summary(lm(data=together, AAPL.Close_0 ~ AAPL.Close_1 + AAPL.Close_2)) # second order
summary(lm(data=together, AAPL.Close_0 ~ AAPL.Close_1 + AAPL.Close_2 + AAPL.Close_3))

together$MSFT.Close_0 <- lag(together$MSFT.Close, 0)
together$MSFT.Close_1 <- lag(together$MSFT.Close, 1)
together$MSFT.Close_2 <- lag(together$MSFT.Close, 2)

# VAR Vector autoregressive model

summary(lm(data=together, AAPL.Close_0 ~ MSFT.Close_1 ))
summary(lm(data=together, AAPL.Close_0 ~ MSFT.Close_1 + AAPL.Close_1 ))

#write.csv(together,"together_stock.csv")

# convert into ts prior to making chart
aapl <- as.ts(together$AAPL.Close)
msft <- as.ts(together$MSFT.Close)
plot(aapl, col="red")
par(new=TRUE)
plot(msft, col="blue")




## more time series data
install.packages("devtools")
devtools::install_github("FinYang/tsdl")
library(tsdl)
library(forecast)
help(tsdl)
tsdl
sales <- subset(tsdl,"Sales") # extract sales
View(sales)
str(sales) # list of 46 sales times series
sales[5] # description of 5th sales time series
sales[[5]] # extract the 5th sales time series
view_sales_5 <- as.data.frame(sales[[5]]) # for viewing, not for ts analysis
View(view_sales_5)

drink_sales <- ts(sales[[5]], frequency = 12, start = c(1980, 1)) 
drink_sales
head(drink_sales)
dim(drink_sales)
str(drink_sales) # multiple columns
plot(drink_sales)
dim(drink_sales)

### forecasting here:
drystuff <- drink_sales[,1] # extract one drink
plot(drystuff)
tseries::adf.test(drystuff)  #  Augmented Dickey-Fuller test 
fit <- auto.arima(drystuff)
plot(decompose(drystuff))
plot(forecast(fit,h=20))


## homework hint:
# convert the dry wine data into a time series prior to forecast using as.ts()

df <- read.csv("C:/Users/jmadi/Dropbox/Common/3 Develop/NEU/NEU 2024.1A 6050 20471 M Hayden 012/Week 3 Forecasting & Regression/dry_wine.csv")
df$x
df$dry <- ts(df$x, frequency = 12) #ts(1:10, frequency = 4, start = c(1959, 2)) # 2nd Quarter of 1959
df$dry
str(df)

# can you predict dry wine here?



# can you predict apple stock here?
fit <- auto.arima(together$AAPL.Close)
plot(forecast(fit,h=500))





#Time Series R code
data(AirPassengers)
AP<-AirPassengers
class(AP)
start(AP)
end(AP)
frequency(AP)
summary(AP)
plot(AP)
cycle(AP)
aggregate(AP) # count
aggregate(AP, FUN=mean) # mean
plot(aggregate(AP))
boxplot(AP~cycle(AP))

decompose(AP)
plot(decompose(AP))


webdata<-"https://ryanwomack.com/data/UNRATE.csv"
webdata2<-"https://ryanwomack.com/data/CPIAUCSL.csv"
Unemployment<-read.csv(webdata, row.names=1)
Urate<-ts(Unemployment$VALUE, start=c(1948,1), freq=12) # connver ts
Inflation<-read.csv(webdata2, row.names=1)
Irate<-ts((Inflation$VALUE), start=c(1948,1), freq=12)
plot(Irate)

Urate.July<-window(Urate, start=c(1980,7),freq=TRUE)
time(Urate)
plot(Urate)
abline(reg=lm(Urate~time(Urate)))
# decompose into seasonal, trend and irregular components using moving averages
decompose(Urate)
plot(decompose(Urate))
plot(Irate,Urate) # without time dimension
ts.plot(Irate,Urate, col=c("blue","red"))

# acf computes an estimate of the autocorrelation function of a (possibly multivariate) time series
acf(Urate)
acf(AP)
acf(ts.intersect(Urate, AP))
ts.union(Urate,AP)

# # Pacf computes (and by default plots) an estimate of the partial autocorrelation function of a (possibly multivariate) time series.
# pacf(Urate)
# pacf(AP)
# pacf(ts.intersect(Urate, AP))
# ts.union(Urate,AP)
# 
# # Function Ccf computes the cross-correlation or cross-covariance of two univariate series.
# ccf(Urate)
# ccf(AP)
# ccf(ts.intersect(Urate, AP))
# ts.union(Urate,AP)


plot(HoltWinters(Urate, alpha=0.001, beta=1, gamma=0))
plot(HoltWinters(AP))
plot(HoltWinters(AP, alpha=0.1, beta=0.2, gamma=0))


AP.hw <- HoltWinters(AP)
plot(AP.hw)
AP.predict<-predict(AP.hw, n.ahead=10*12)
ts.plot(AP, AP.predict, lty=1:2)

UR.hw <- HoltWinters(Urate, seasonal="additive")
UR.predict<-predict(UR.hw, n.ahead=10*12)
ts.plot(Urate, UR.predict, lty=1:2)

#randomwalk
x<-w<-rnorm(1000)
for (t in 2:1000) x[t]<-x[t-1]+w[t]
plot(x, type="l")
acf(x)
acf(diff(x))
acf(diff(Urate))


#stationary autoregressive process
x<-w<-rnorm(1000)
for (t in 2:1000) x[t]<-(x[t-1]/2)+w[t]
plot(x, type="l")
acf(diff(x))

#partial autocorrelation
pacf(x) 
acf(x)

pacf(Urate)
acf(Urate)

#autoregression model
U.ar<-ar(Urate, method="mle")
x.ar<-ar(x, method="mle")
acf(U.ar$res[-1], na.action=na.pass)
acf(x.ar$res[-1])

#regression on time dimension
Urate.reg<-lm(Urate~time(Urate))
summary(Urate.reg)
acf(resid(Urate.reg))
pacf(resid(Urate.reg))

AP.reg<-lm(AP~time(AP))
summary(AP.reg)
confint(AP.reg) # confidence intermal of a fitted model
acf(resid(AP.reg))
pacf(resid(AP.reg))



# auto arima
auto.arima(AP)
forecast(auto.arima(AP))
plot(forecast(auto.arima(AP)))



#ARIMA (Autoregressive integrated moving average)
#MA(3)
AP.ma <- arima(AP, order=c(0,0,3), list(order = c(12,0,12), period = 1)) #estimates moving average of three time periods of "white noise"
#ARMA(1,1)
AP.arma <- arima(AP, order=c(1,0,1), list(order = c(12,0,12), period = 1)) #1 prior period of AP, 1 prior period of white noise
#ARIMA(2,1,2)
# this model is composed of 2 prior periods of AP, 2 prior periods of white noise
# and a first-order difference
AP.arima <- arima(AP, order=c(2,1,2), list(order = c(12,0,12), period = 1))

AP.predict1<-predict(AP.ma, n.ahead=60)
AP.predict2<-predict(AP.arma, n.ahead=60)
AP.predict3<-predict(AP.arima, n.ahead=60)
ts.plot(AP, AP.predict1$pred,
        AP.predict2$pred,
        AP.predict3$pred,
        col=c("black","blue","red","green"))

# another example using forecast library
install.packages("forecast")
library(forecast)
AP <- AirPassengers
logAP <- log(AP) 
logARIMA <- arima(logAP, order = c(1, 0, 1), list(order = c(12,0, 12), period = 1)) #Just a fake ARIMA in this case... 
plot(forecast(logARIMA, h=24)) #but my question is how to get a forecast plot according to the none log AirPassenger data

# plot against non log 
fc<-forecast(logARIMA,h=24)
fc$mean<-exp(fc$mean)
fc$upper<-exp(fc$upper)
fc$lower<-exp(fc$lower)
fc$x<-exp(fc$x)
plot(fc)

#GARCH
#Generalized autoregressive conditioned heteroskedastic
library(tseries)
garch(AP, grad="numerical")






