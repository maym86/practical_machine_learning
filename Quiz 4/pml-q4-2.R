library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]
set.seed(62433)

randomForest <- train(diagnosis~., method="rf",data=training)
gmb <- train(diagnosis ~., method="gbm",data=training, verbose=FALSE)
lda <- train(diagnosis ~., method="lda",data=training)


rfRes = predict(randomForest,training)
gmbRes = predict(gmb,training)
ldaRes = predict(lda,training)




'Stacking Training'
predDF <- data.frame(rfRes,gmbRes,ldaRes, diagnosis=training$diagnosis)
stackedRf <- train(diagnosis~., method="rf",data=predDF)

'Stacking Testing'

rfRes = predict(randomForest,testing)
gmbRes = predict(gmb,testing)
ldaRes = predict(lda,testing)


print ("rf"); confusionMatrix(testing$diagnosis, rfRes)$overall['Accuracy']
print ("gmb"); confusionMatrix(testing$diagnosis, gmbRes)$overall['Accuracy']
print ("lda"); confusionMatrix(testing$diagnosis,ldaRes)$overall['Accuracy']

predDF <- data.frame(rfRes,gmbRes,ldaRes, diagnosis=testing$diagnosis)

stackedRfRes = predict(stackedRf,predDF)

print ("stacked");confusionMatrix(testing$diagnosis, stackedRfRes)$overall['Accuracy']

