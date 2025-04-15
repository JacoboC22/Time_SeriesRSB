library (quantmod)
library(forecast)
library(Metrics)

getSymbols("MSFT", src = "yahoo", from = "2019-01-01", to = "2024-12-31", periodicity = "monthly")
print(MSFT)

data = MSFT
MSFT

#Graph for Volume
volume = data[, "MSFT.Volume"]
volume
autoplot(volume)

#Graph for Open column
open = data[, "MSFT.Open"]
open
autoplot(open)

#Graph for High
High = data[, "MSFT.High"]
High
autoplot(High)

#Graph for Low
Low = data[, "MSFT.Low"]
Low
autoplot(Low)

#Graph for close
close = data[, "MSFT.Close"]
#close = GSPC$GSPC.Close
close
autoplot(close)

#Looking at the ts there's a slight upwards trend, and a strong seasonality happening.
#We can use ARIMA and Holt winters

#Creating Time series variable for Open column
open_ts <- ts(data$MSFT.Open, start = c(2019, 1), frequency = 12)
opendecomp <- decompose(open_ts)
autoplot(opendecomp)

#Creating Time series variable for High column
High_ts <- ts(data$MSFT.High, start = c(2019, 1), frequency = 12)
highdecomp <- decompose(High_ts)
autoplot(highdecomp)

#Creating Time series variable for Low column
Low_ts <- ts(data$MSFT.Low, start = c(2019, 1), frequency = 12)
lowdecomp <- decompose(Low_ts)
autoplot(lowdecomp)

#Creating Time series variable for close column
close_ts <- ts(data$MSFT.Close, start = c(2019, 1), frequency = 12)
decomp <- decompose(close_ts)
autoplot(decomp)

length(close_ts)
close_ts
72*0.75 #Training sample
18 #Testing_sample


#Simple exponential smoothing

ses.pred = ses(close_ts, h = 14)
plot(close_ts, type = "l")
length(names(ses.pred))
autoplot(ses.pred)


#Holt winters
holt.pred = holt(close_ts, h = 14)
autoplot(holt.pred)

##### Holt winters additive #####

hw.add = hw(close_ts, frequency = 1, h =14, seasonal = "additive")
autoplot(hw.add)

##### Holt winters multiplicative #####

hw.mult = hw(close_ts, frequency = 2, h =14, seasonal = "multiplicative")
autoplot(hw.mult)


train = close_ts[1:58]
test = close_ts[59:72]


ses.test = ses(train, h = length(test))
length(ses.test$mean)

holt.test = holt(train, h =length(test))
hw.add.test = hw(ts(train, frequency = 12), h =length(test), seasonal = "additive")
hw.mult.test = hw(ts(train, frequency = 12), h =length(test), seasonal = "multiplicative")

rmse.ses = rmse(test, ses.test$mean)
rmse.holt = rmse(test, holt.test$mean)
rmse.hw.add = rmse(test, hw.add.test$mean)
rmse.hw.mult = rmse(test, hw.mult.test$mean)

table = data.frame(c("SES", "HOLT", "HW-ADD", "HW-MULT"), c(rmse.ses, rmse.holt, rmse.hw.add, rmse.hw.mult))
print(table)

colnames(table) = c("METHOD", "RMSE")

print("The best forecasting method for the oil dataset is")
table[which.min(table[,2]), 1]

#Now for the ARIMA Model

fit = auto.arima(close_ts) #Best ARIMA model for this ts
summary(fit) 

h = 18 #Number of forecast to predict
train_end = length(close_ts)-h 
test.start = length(close_ts)-h+1

closetrain = close_ts[1:train_end]
closetest = close_ts[test.start:length(close_ts)]

fittrain = auto.arima(closetrain) #Best ARIMA model for the train set, in order to make predictions in the test set and avoid overfitting
summary(fittrain)

predtrain = forecast(fittrain, h = length(closetest))
predtrain
names(predtrain)

predictedtrain = predtrain$mean
predictedtrain

rmse.bestarima = rmse(as.vector(closetest), as.vector(predictedtrain))
rmse.bestarima

ifelse(rmse.bestarima < rmse.hw.add, "ARIMA Model is best to predict the future behavior of this time Series", "HW Add is best to predict the future behavior of this time Series")
