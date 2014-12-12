library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rattle)
set.seed(125)


training = segmentationOriginal[segmentationOriginal$Case == "Train",]
testing = segmentationOriginal[segmentationOriginal$Case == "Test",]


dim(training)
dim(testing)

modFit <- train(Class~., method="rpart", data=training)

print(modFit$finalModel)

fancyRpartPlot(modFit$finalModel)
