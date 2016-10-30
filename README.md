# GettingandCleaningData
Repository for Coursera Getting and Cleaning Data Week 4 Course Project

This repository contains the following files:
  1. run_analysis.R
  2. README.md
  3. Codebook.md
  
Run_Analysis.R
 
The script Run_Analysis.R downloads the Human Activity Recognition data collected via Samsung Galaxy S smartphone from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and performs the following tasks:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script produces two resulting data frames:

1. mergeData2

mergeData2 contains all of the mean and standard deviation measurements for each measurement in the training and test data sets. Variables have been added to designate the subject and activity for each measurement. 

2. mergeMeans

mergeMeans contains the calculated mean for each measurement by subject and by activity. 
