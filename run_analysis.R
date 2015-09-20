#Make sure that the data directories are set at your working directory
  setwd("./Getting and Cleaning Data/Projeto")
  
# Load libraries
  library(dplyr)
  library(reshape2)
  library(data.table)
  
#1 - Merges the training and the test sets to create one data set.
  #reading the labels
  activityLabels <- read.table("activity_labels.txt", col.names = c("ActivityLabelID","ActivityLabelName"))
  featureLabels <- read.table("features.txt",col.names = c("FeatureLabelID","FeatureLabelName"))
  
  #reading the train
  subtrain <- read.table("./train/subject_train.txt", col.names = "SubjectID")
  ytrain <- read.table("./train/y_train.txt", col.names = "ActivityLabelID")
  xtrain <- read.table("./train/x_train.txt", col.names=featureLabels$FeatureLabelName)
  
  #reading the test
  subtest <- read.table("./test/subject_test.txt", col.names = "SubjectID")
  ytest <- read.table("./test/y_test.txt", col.names = "ActivityLabelID")
  xtest <- read.table("./test/x_test.txt", col.names=featureLabels$FeatureLabelName)
  
  # putting it all toguether and deleting to clean up memory
  test <- bind_cols(subtest,ytest,xtest)
  train <- bind_cols(subtrain,ytrain,xtrain)
  dataset <- bind_rows(test,train)
  rm(subtest,subtrain,ytest,ytrain,xtest,xtrain,test,train)
  
#2 Extracts only the measurements on the mean and standard deviation for each measurement.
  # Use grep to find the columns related to what we want to find. Order does not matter here since the result will be a ordered vector with the columns numbers
  subset <- dataset[,grep("(\\.std\\.)|(\\.mean\\.)|(ActivityLabelID)|(SubjectID)",names(dataset))]
  
#3 Uses descriptive activity names to name the activities in the data set
  # Used the same keys in both tables in order to merge both into a single one and create a 69th column named ActivityName
  labeled <- merge(subset,activityLabels,by = "ActivityLabelID")

#4 Appropriately labels the data set with descriptive variable names. 
  # Already been done when reading the documents.
  
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # Melt the data table from 69 columns to only 5, replicating the columns as a "variable" column, line by line.
  tidyds <- melt(labeled, id=c("SubjectID","ActivityLabelID","ActivityLabelName"),measures.vars=grep(".std.|.mean.",names(labeled)))
  tidydt <- data.table(tidyds,key = "SubjectID")
  tidyavg <- tidydt[,list(value=mean(value)),by="SubjectID,ActivityLabelName,variable"]
  rm(tidyds,tidydt)
  
  #Write to a txt file.
  write.table(tidyavg,file="tidy.txt",append=FALSE,row.names=FALSE,col.names=TRUE)
