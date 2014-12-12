library(caret)
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234 )


modFit <- glm(chd ~ age + alcohol + obesity + tobacco + typea + ldl, family="binomial", data=trainSA)


missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}


print (missClass(trainSA$chd,predict(modFit, type = "response")))


print (missClass(testSA$chd,predict(modFit, newdata=testSA, type = "response")))

