library(lubridate)  # For year() function below
setwd("C:/Users/gleesonm/OneDrive - HERE Global B.V-/Projects/PML")
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)


library(forecast)

print(attributes(training))

tsFit <- bats(tstrain)

h <- dim(testing)[1]

fcast <- forecast(tsFit, level = 95, h = h)
accuracy(fcast)
accuracy(fcast,testing$visitsTumblr)

result <- c()
l <- length(fcast$lower)

for (i in 1:l){
  x <- testing$visitsTumblr[i]
  a <- fcast$lower[i] < x & x < fcast$upper[i]
  result <- c(result, a)
}

sum(result)/l * 100
