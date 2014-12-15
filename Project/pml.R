library(caret)
library(corrplot)
library(randomForest)
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
validation = dat[-inTrain,]

# plot a correlation matrix
correlMatrix <- cor(training[, -length(training)])
corrplot(correlMatrix, type = "lower", tl.cex = 0.8)

#Compute Rantdom Forest with PCA to remove corelations
randomForestFit <- randomForest(classe~., data=training, preprocessing="pca")
print(randomForestFit)
rfResVal = predict(randomForestFit,validation)

#Get an estimate of how well the model has been trained
print ("RF - Cross Validataion"); 
print(rfResVal)
confusionMatrix(validation$classe, rfResVal)

accuracy = confusionMatrix(validation$classe, rfResVal)$overall['Accuracy'] 
outOfSampleError = (1 - accuracy) * 100
print("Out of sample error estimation: "); print(round(outOfSampleError, digits = 2))

# Application of the model to new data set
testingFinal = read.csv("pml-testing.csv", na.strings=c("", "NA"))
testingFinal = testingFinal[8:length(testingFinal)]
testingFinal = testingFinal[,remCol == 0] 

# Fit the model to the new data
answers = predict(randomForestFit,testingFinal)
print (answers)

#Write the results to files
pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(answers)
