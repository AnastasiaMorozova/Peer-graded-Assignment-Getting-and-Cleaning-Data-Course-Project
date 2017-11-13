# This script creates a tidy data set out of raw training and test data sets
# from the accelerometers from the Samsung Galaxy S smartphone.

#  Each part of the script starts with a comment line describing the procedures 
# applied to prepare a tidy data set.

# Attach necessary libraries
library(stringr)
library(reshape2)
library(plyr)

# Read data from training and test sets
trainingSet<-read.table("X_train.txt")  # read text file "X_train.txt"
testSet<-read.table("X_test.txt")       # read text file "X_test.txt"
# Check the size and type of data in the data sets
str(trainingSet)
str(testSet)


# Creating a merged data set by binding training and test data sets
mergedDataSet<-rbind(trainingSet,testSet)

# Assign the names of the features to the columns of the data set
features<-read.table("features.txt")              # read the features 
grep("mean",features$V2)

subjectsTest<-read.table("subject_test.txt")      # subjects test 
subjectTrain<-read.table("subject_train.txt")     # subjects train
activityLabels<-read.table("activity_labels.txt") # activity labels
ltest<-read.table("y_test.txt")   # activity labels for test set
ltrain<-read.table("y_train.txt") # activity labels for train set
