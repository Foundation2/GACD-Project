# GACD-Project
Course Project for Coursera Getting and Cleaning Data course.

This repo contains  three files:

1. **run_analysis.R** - R script file that transforms UCI HAR Dataset according to the project requirements 1 to 5.
2. **CodeBook.md** - modified  version of the features_info.txt file included with the UCI HAR Dataset explaining the variables included in the output text file generated by the script in 1.
3. **README.md** - this file.

## Explanation of the script
The run_analysis.R script file contains 5 commented sections, each corresponding to an instruction in the assignment. Further notes on how the script works are given below.

**NB this script assumes that the UCI HAR Dataset folder is located in the Working Directory.**

>       1. Merges the training and the test sets to create one data set.

Each component of the Test/Train dataset is read into R and assigned to a data frame. For each component of the data set (X, Y, subject) the Test and Train data are combined using the row bind function on the test and train data in the same sequence so that the resulting data frames xAll, yAll and subjectAll maintain corresponding data by row.

>       2. Extracts only the measurements on the mean and standard deviation
>for each measurement. 

The full list of the 561 feature variables contained in the original data set is given in the features.txt file. For this step of the script the features.txt file is read in and the grep function is used with a Regular Expression to create an integer vector identifying the column numbers in the xAll data that contain feature variables with either of the literals: _mean_ or _std_ included in the name. This vector is then used to subset the xAll data into a new data frame xAllMeanStd that only includes these 86 columns.

>       3. Uses descriptive activity names to name the activities in the data set

The list of acivity codes and corresponding descriptions conatined in the activity_labels.txt file is read in and assigned to a data frame: activities. A new variable activity is then created in the yAll data frame formed from the activity name that corresponds to the existing activity code (the subject identifier variable in the subjectAll data frame is also given the column name subject).

>       4. Appropriately labels the data set with descriptive variable names. 

The meanStdFeatures integer vector created in step 2 is used to index the features data frame and create a character vector, meanStdFeatureLabels, containing the 86 variable names now contained in the xAll data frame. The colnames argument is used to assign these to the xAll data frame as column names.

>       5. From the data set in step 4, creates a second, independent tidy data set
>with the average of each variable for each activity and each subject.

The first step here is to require the dplyr package in case it is not already loaded. The cbind function is then used to combine the three elements of the data set: the subjectAll data frame, the activity name column of the yAll data frame and the xAllMeanStd data frame containing the 86 feature vectors containing either the text _mean_ or _std_. These three data frames contain data that corresponds by row and form a new data frame: tidyData. 

In the final step before output we use the summarise and group_by functions of the dplyr package together to group this data frame by subject and activity and summarise all non grouping variables by their means. The result is the **tidyDataMeans** data frame.

**tidyDataMeans** is a new independent tidy data set that meets the three requirements of tidy data (in the 'wide' form):

1. _Each variable forms a column_: subject, activity and the means of the 86 selected feature variables (88 columns).
2. _Each observation forms a row_: each combination of subject and activity (30 x 6 = 180 rows).
3. _Each type of observational unit forms a table_: in this case the summary of selcted feature variables for each subject and activity.

The resulting data frame is output to the text file, _tidyDataMeans.txt_, using the write.table function as per the project spec.