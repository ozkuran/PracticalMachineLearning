

library(caret)
trainingData <- read.csv("pml-training.csv", na.strings = c("NA",""))
testingData <- read.csv("pml-testing.csv", na.strings = c("NA",""))
naList <- apply(trainingData, 2, function(x) { sum(is.na(x)) })
trainingData <- trainingData[, which(naList == 0)]
testingData <- testingData[, which(naList == 0)]

trainingData <- subset(trainingData, select=-c(X, user_name, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp, new_window, num_window))
testingData <- subset(testingData, select=-c(X, user_name, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp, new_window, num_window))
mytrControl = trainControl(method = "cv", number = 4)
modelFit <- train(trainingData$classe ~ ., data = trainingData, method = "rf", trControl = mytrControl)
