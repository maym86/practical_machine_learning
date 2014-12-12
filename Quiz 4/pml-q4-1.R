library(ElemStatLearn)

library(caret)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

is.factor(vowel.train$y)
is.factor(vowel.test$y)

set.seed(33833)


randomForest <- train(y~., method="rf",data=vowel.train)
gmb <- train(y~., method="gbm",data=vowel.train, verbose=FALSE)
print(randomForest)
print(gmb)

rfRes = predict(randomForest,vowel.test)
gmbRes = predict(gmb,vowel.test)




confusionMatrix(vowel.test$y, rfRes)
confusionMatrix(vowel.test$y, gmbRes)

