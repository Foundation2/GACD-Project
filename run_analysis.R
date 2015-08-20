
# Merges the training and the test sets to create one data set (6 files to 3 data frames).

        xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
        xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
        xAll <- rbind(xTest, xTrain)

        subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
        subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
        subjectAll <- rbind(subjectTest, subjectTrain)

        yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
        yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
        yAll <- rbind(yTest, yTrain)

# Extracts only the measurements on the mean and standard deviation for each measurement. 

       features <- read.table("UCI HAR Dataset/features.txt") 
       meanStdFeatures <- grep("mean|std", features$V2,ignore.case = TRUE)
       xAllMeanStd <- xAll[,meanStdFeatures]
        
# Uses descriptive activity names to name the activities in the data set
       
       activities <- read.table("UCI HAR Dataset/activity_labels.txt")
       yAll$activity <- activities[yAll$V1,2]
       colnames(subjectAll) <- "subject"

# Appropriately labels the data set with descriptive variable names. 
       
       meanStdFeatureLabels <- as.character(features[meanStdFeatures,2])
       colnames(xAllMeanStd)<- meanStdFeatureLabels

# From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject and output to text file.
       
       require(dplyr)
       tidyData <- cbind(subjectAll,select(yAll, activity),xAllMeanStd)
       tidyDataMeans <- summarise_each(group_by(tidyData, subject, activity), funs(mean))
       
       write.table(tidyDataMeans, "tidyDataMeans.txt", row.names = FALSE)
      