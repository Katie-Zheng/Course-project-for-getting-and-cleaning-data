## This README explains how the script works
### 1. Read in data
Related data files are "X_test.txt", "subject_test.txt", "y_test.txt", "X_train.txt", "subject_train.txt", "y_train.txt", "features.txt", "activity_labels.txt".
### 2. Complete the original data set
The second column of "features.txt" is the column name for Xtest and Xtrain data sets. "subject_test.txt" and "y_test.txt" provide subject ID and activity type for Xtest and Xtrain data sets.
### 3. Merge Xtest and Xtrain data sets into one data set
Since the two data sets are related to different subject ID, we can simply combine them together and sort the new large data sets according to subject ID and activity, both in ascending order.
### 4. Extract mean and std 
Use grep command to extract variables that have "mean" and "std" in them, but exclude "meanFreq", because they are not a direct indicator of the mean of the variables. Then subset the large data sets into a new data set that only includes subject ID, activity, mean and std.
### 5. Name the activities
Match activity number with their respective names provided in "activity_labels.txt". Use function and a for loop to loop over the six activities. 
### 6. label the data set with descriptive variable names
Use gsub to replace abbreviation in the variable names with the full expressions. Delete all the "()" in variable names. 
### 7. Average of each variable for each activity and each subject
First melt the data set. Then for each subject ID, dcast the data set that calculate the mean of each variable by activity and stick them back together. 
### 8. Create txt file
Use write.table to create txt file. We can use 
dataset = read.table("newDataset", header = TRUE)
to easily read them back into R. 
