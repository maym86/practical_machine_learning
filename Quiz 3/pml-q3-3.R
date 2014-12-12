library(pgmm)
data(olive)
olive = olive[,-1]


modFit <- train(Area~., method="rpart", data=olive)

print(modFit$finalModel)

fancyRpartPlot(modFit$finalModel)

newdata = as.data.frame(t(colMeans(olive)))


print(newdata)
predict(modFit, newdata)


