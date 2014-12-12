set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)

print(attributes(training))

lasso <- train(CompressiveStrength~., method="lasso",data=training)

lassoPred <- predict(lasso,testing)
plot.enet(lasso$finalModel, xvar="penalty", use.color=T)
