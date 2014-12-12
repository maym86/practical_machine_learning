library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

print(attributes(training))



preProc <- preProcess(training[58:69], , method = "pca", thresh = 0.80 )

print(preProc)
print(preProc$dim)
