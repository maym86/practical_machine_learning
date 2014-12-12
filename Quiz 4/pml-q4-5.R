set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

library(e1071)

svmFit <- svm(CompressiveStrength~.,data=training)


svmPred = predict(svmFit, testing)


rmse <- sqrt(mean((svmPred-testing$CompressiveStrength)^2))

print(rmse)
