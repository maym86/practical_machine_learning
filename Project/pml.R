library(caret)

set.seed(33355)

setwd("C:/Users/gleesonm/OneDrive - HERE Global B.V-/Projects/practical_machine_learning/Project")

dat = read.csv("pml-training.csv", na.strings=c("", "NA"))

#Clean Data - Remove NaN and other cols - timestamp etc
dat = dat[7:length(dat)]
dat = dat[,colSums(is.na(dat)) == 0] 

print(attributes(dat))

#Create training and testing data

inTrain = createDataPartition(dat$classe, p = 3/4)[[1]]
training = dat[ inTrain,]
testing = dat[-inTrain,]
print(attributes(testing))


#Perform PCA
#detect outliers?


#preProcValues <- preProcess(training, method = "pca", thresh = 0.8)


#Compute Rantdom Forest

randomForest <- train(classe~., method="rf",data=training)

rfRes = predict(randomForest,testing)

print ("rf"); confusionMatrix(testing$classe, rfRes)

validation = read.csv("pml-testing.csv")