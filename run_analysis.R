# This script creates a tidy data set out of raw training and test data sets
# from the accelerometers from the Samsung Galaxy S smartphone.

#  Each part of the script starts with a comment line describing the procedures 
# applied to prepare a tidy data set.

# Attach necessary libraries

library(plyr)

# Read data from training and test sets
trainingSet<-read.table("X_train.txt")  # read text file "X_train.txt"
testSet<-read.table("X_test.txt")       # read text file "X_test.txt"
# Check the size and type of data in the data sets
str(trainingSet)
str(testSet)


################# Creating a merged data set by binding training and test data sets ##########################
mergedDataSet<-rbind(trainingSet,testSet)


# Assign the names of the features to the columns of the data set
features<-read.table("features.txt")              # read the features 
features<-as.character(features$V2)               # make a list of features

indexMean<-grep("mean()",features,fixed = TRUE)             # index for the means of the measures
indexStd<-grep("std()",features)               # index for the std of the measures
index<-c(indexMean,indexStd)
index<-sort(index)                             # index for the measurements to leave in the data set

################ Extracts the measurements on the mean and standard deviation for each measurement############
mergedDataSet<-mergedDataSet[,index]           # data set only with mean and std of the measures
namesfeatures<-features[index]

################# additional columns with subject and activity type###########################################

subjectsTest<-read.table("subject_test.txt")      # subjects from test sample
subjectTrain<-read.table("subject_train.txt")     # subjects from training sample
subjects<-rbind(subjectTrain,subjectsTest)        # full column with subjects 


mergedDataSet$Subject<-subjects$V1                  # ctreate a column with subjects identificator
#mergedDataSet$Subject<-as.factor(mergedDataSet$Subject)

################# Assign activity names to name activities in the dataset#####################################
ltest<-read.table("y_test.txt")                   # activity labels for test set
ltrain<-read.table("y_train.txt")                 # activity labels for train set
label<-rbind(ltrain,ltest)
activityLabels<-read.table("activity_labels.txt") # activity names
colnames(activityLabels)<-c("V1","ACTIVITY")
activity<-left_join(label,activityLabels,by="V1") # attach descriptive activity names to labels
mergedDataSet$Label<-activity$ACTIVITY            # create a column with activity names

################# Label data set with descriptive variables names ############################################
# Assign the descriptive name to each variable
names<-c(namesfeatures,"SUBJECT","ACTIVITY")
colnames(mergedDataSet)<-names                 # assignes the descriptive name to each variable


################# Create a tidy data set with the average of each variable for each activity and each subject #
tidy_data<-mergedDataSet %>%   group_by(SUBJECT,ACTIVITY) %>%   summarise_all(mean)

# Create a .txt file with a tidy data set
write.table(tidy_data, file = "tidy_data.txt", sep = " ", col.name=TRUE,row.name=FALSE)

# How to read the tidy data in R 
DataSet<-read.table("tidy_data.txt",header = TRUE)
