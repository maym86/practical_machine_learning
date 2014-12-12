library(ElemStatLearn)

library(caret)
data(vowel.train)
data(vowel.test) 

vowel.train$y <- as.factor(vowel.train$y)
vowel.test$y <- as.factor(vowel.test$y)

is.factor(vowel.train$y)
is.factor(vowel.test$y)

set.seed(33833)


modFit <- train(y~., method="rf",data=vowel.train, prox = TRUE, importance = TRUE)

print(modFit)



varImp(modFit,  type=2)

