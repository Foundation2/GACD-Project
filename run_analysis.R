
# Merges the training and the test sets to create one data set.

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

        
        
# Uses descriptive activity names to name the activities in the data set

# Appropriately labels the data set with descriptive variable names. 

# From the data set in step 4, creates a second, independent tidy data set with the
# average of each variable for each activity and each subject.
