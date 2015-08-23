## --- read data --- ## 
# setwd("F:/PHBS/×ÔÑ§/±à³Ì/R/3. Getting and Cleaning Data/course project/UCI HAR Dataset") change to your own working directory
# test
Xtest = read.table("./test/X_test.txt")
subjectTest = read.table("./test/subject_test.txt")
activityTest = read.table("./test/y_test.txt")
# train
Xtrain = read.table("./train/X_train.txt")
subjectTrain = read.table("./train/subject_train.txt")
activityTrain = read.table("./train/y_train.txt")
# features and activities
features = read.table("features.txt")
activityLabel = read.table("activity_labels.txt")

## --- add column name --- ##
names(Xtest) = features[,2]
names(Xtrain) = features[,2]

## --- add subject and activity --- ##
Xtest2 = cbind(subjectTest[,1], activityTest[,1], Xtest)
colnames(Xtest2)[1:2] <- c("subjectID","activity")

Xtrain2 = cbind(subjectTrain[,1], activityTrain[,1], Xtrain)
colnames(Xtrain2)[1:2] <- c("subjectID","activity")

## --- merge and sort by subject ID--- ##
mergedData = rbind(Xtest2, Xtrain2)
mergedData2 = mergedData[order(mergedData$subjectID, mergedData$activity),]

## --- subset mean and std --- ##
temp1 = grep("mean()[^meanFreq]", names(mergedData2))
temp2 = grep("std()", names(mergedData2))
mergedData3 = mergedData2[,c(1, 2, temp1, temp2)]

## --- name the activities --- ##
activity = as.character(mergedData3$activity)
activityLabel = as.character(activityLabel[,2])
f <- function(number, activityName){
    activity[activity == as.character(number)] <- activityName
    activity
}
for (i in 1:6){
    activity = f(i, activityLabel[i])
}
mergedData3$activity = activity

## --- label the data set with descriptive variable names --- ##
colname = names(mergedData3)
colname = gsub("^f", "freq", colname)
colname = gsub("^t", "time", colname)
colname = gsub("Acc", "accelerometer", colname)
colname = gsub("Gyro", "Gyroscope", colname)
colname = gsub("Mag", "Magnitude", colname)
colname = gsub("\\(\\)", "", colname)
names(mergedData3) = colname

## --- average of each variable for each activity and each subject --- ##
library(reshape2)
mergedData3Melt = melt(mergedData3, id = c("subjectID", "activity"), measure.vars = names(mergedData3)[3:68])

new = NULL
for (i in 1:30) {
    subject = mergedData3Melt[mergedData3Melt$subjectID == i,]
    subject2 = dcast(subject, activity ~ variable, mean)
    new = rbind(new, subject2)
}
new2 = cbind(rep(1:30, each = 6), new)
colnames(new2)[1] <- "subjectID"

## --- create new txt file --- ##
write.table(new2, file = "newDataset.txt", col.names = TRUE, row.name=FALSE) 
# dataset = read.table("newDataset", header = TRUE)
