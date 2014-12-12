library(caret)

set.seed(33355)

setwd("C:/Users/gleesonm/OneDrive - HERE Global B.V-/Projects/practical_machine_learning/Project")

dat = read.csv("pml-training.csv", na.strings=c("", "NA"))

#Clean Data - Remove NaN and other cols - timestamp etc
dat = dat[8:length(dat)]
remCol =  colSums(is.na(dat))
dat = dat[,remCol == 0] 

#Create training and testing data

inTrain = createDataPartition(dat$classe, p = 3/4)[[1]]
training = dat[ inTrain,]
testing = dat[-inTrain,]

#Compute Rantdom Forest with PCA

randomForestFit <- randomForest(classe~., data=training, preProcess="pca")
rfRes = predict(randomForestFit,testing)
print ("rf - testing"); confusionMatrix(testing$classe, rfRes)



# Validation data set

val = read.csv("pml-testing.csv", na.strings=c("", "NA"))
val = val[8:length(val)]
val = val[,remCol == 0] 

rfRes = predict(randomForestFit,val)
print ("rf - validation"); confusionMatrix(val$classe, rfRes)
