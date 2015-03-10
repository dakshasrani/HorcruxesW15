dataset <- read.csv("UCIDataNorm.csv")

nbrow <- nrow(dataset)
nb <-ncol(dataset)
class <- as.character(dataset[,nb])

attribs <- dataset[,-nb]

# use 90 % of objects as train
ntrain <- 15121
# sample
tindex <- sample(nbrow,ntrain) # indices of training samples 
train <- attribs[tindex,]
test <- attribs[-tindex,]
classtrain <- class[tindex]
classtest <- class[-tindex]
# learn the model, type="C-classification" is set so that 
model <- svm(train, classtrain,type="C-classification")

prediction <- predict(model,test)
# confusion matrix
tab <- table(pred = prediction, true = classtest)

error <- mean(classtest != prediction)