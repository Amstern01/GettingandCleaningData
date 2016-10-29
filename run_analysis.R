## This code performs the following operations:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject.

## download and unzip file
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./datazip.zip")
unzip("./datazip.zip", exdir = "./datazip")

## read in test, train, and features files 
dataTest <- read.table("./datazip/UCI HAR Dataset/test/X_test.txt")
dataTrain <- read.table("./datazip/UCI HAR Dataset/train/X_train.txt")
dataFeatures <- read.table("./datazip/UCI HAR Dataset/features.txt")

## add column names for Test and Train data

colnames(dataTest) <- dataFeatures[ ,2]
colnames(dataTrain) <- dataFeatures[, 2]

##add activity code to Test and Train data

SubjectTest <- read.table("./datazip/UCI HAR Dataset/test/subject_test.txt")
SubjectTrain <- read.table("./datazip/UCI HAR Dataset/train/subject_train.txt")
LabelTest <- read.table("./datazip/UCI HAR Dataset/test/Y_test.txt")
LabelTrain <- read.table("./datazip/UCI HAR Dataset/train/Y_train.txt")

dataTest2 <- cbind(SubjectTest, LabelTest, dataTest)
dataTrain2 <- cbind(SubjectTrain, LabelTrain, dataTrain)

names(dataTest2)[1] <- "Subject"
names(dataTest2)[2] <- "ActivityLabel"

names(dataTrain2)[1] <- "Subject"
names(dataTrain2)[2] <- "ActivityLabel"

## merge test and train data

mergeData <- rbind(dataTest2, dataTrain2)

## extract mean and standard deviation for each measurement
cols <- intersect(grep("mean()|std()|Subject|ActivityLabel", colnames(mergeData)), grep("Freq", colnames(mergeData), invert = TRUE))
mergeData2 <- mergeData[,cols]

## assign activity names

mergeData2$ActivityLabel[mergeData2$ActivityLabel == '1'] <- 'Walking'
mergeData2$ActivityLabel[mergeData2$ActivityLabel == '2'] <- 'WalkingUpstairs'
mergeData2$ActivityLabel[mergeData2$ActivityLabel == '3'] <- 'WalkingDownstairs'
mergeData2$ActivityLabel[mergeData2$ActivityLabel == '4'] <- 'Sitting'
mergeData2$ActivityLabel[mergeData2$ActivityLabel == '5'] <- 'Standing'
mergeData2$ActivityLabel[mergeData2$ActivityLabel == '6'] <- 'Laying'

## assign descriptive variable names
names(mergeData2) <- gsub("^t", "time", names(mergeData2))
names(mergeData2) <-gsub("^f", "frequency", names(mergeData2))
names(mergeData2) <-gsub("()", "", names(mergeData2))
names(mergeData2) <- gsub("-", "", names(mergeData2))

## average by activity and subject
mergeMelt <- melt(mergeData2, id= c("Subject", "ActivityLabel"), measure.vars= names(mergeData2)[3:68])
meansubject <- dcast(mergeMelt, Subject ~ variable, mean)
meanactivity <- dcast(mergeMelt, ActivityLabel ~ variable, mean)

names(meansubject)[1] <- "AverageBy"
names(meanactivity)[1] <- "AverageBy"

mergeMeans <- rbind(meansubject, meanactivity)