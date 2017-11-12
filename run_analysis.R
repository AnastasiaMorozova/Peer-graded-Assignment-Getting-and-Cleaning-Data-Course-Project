# This script creates a tidy data set out of raw training and test data sets
# from the accelerometers from the Samsung Galaxy S smartphone.

#  Each part of the script starts with a comment line describing the procedures 
# applied to prepare a tidy data set.

# Read data from training and test sets
trainingSet<-read.table("X_train.txt")  # read text file "X_train.txt"
testSet<-read.table("X_test.txt")       # read text file "X_test.txt"
