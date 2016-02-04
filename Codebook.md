# INTRODUCTION
Codebook summarizes the resulting data fields in tidydata.txt

A full description of the data that was used in this project can be found at the URL: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data can be found at the URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#IDENTIFIERS
1. subject - The ID of the test subject
2. activity - The type of activity performed when the corresponding measurements were taken

#MEASUREMENTS
tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tBodyAccStdX
tBodyAccStdY
tBodyAccStdZ
tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tGravityAccStdX
tGravityAccStdY
tGravityAccStdZ
tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyAccJerkStdX
tBodyAccJerkStdY
tBodyAccJerkStdZ
tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroStdX
tBodyGyroStdY
tBodyGyroStdZ
tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyGyroJerkStdX
tBodyGyroJerkStdY
tBodyGyroJerkStdZ
tBodyAccMagMean
tBodyAccMagStd
tGravityAccMagMean
tGravityAccMagStd
tBodyAccJerkMagMean
tBodyAccJerkMagStd
tBodyGyroMagMean
tBodyGyroMagStd
tBodyGyroJerkMagMean
tBodyGyroJerkMagStd
fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccStdX
fBodyAccStdY
fBodyAccStdZ
fBodyAccMeanFreqX
fBodyAccMeanFreqY
fBodyAccMeanFreqZ
fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkStdX
fBodyAccJerkStdY
fBodyAccJerkStdZ
fBodyAccJerkMeanFreqX
fBodyAccJerkMeanFreqY
fBodyAccJerkMeanFreqZ
fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroStdX
fBodyGyroStdY
fBodyGyroStdZ
fBodyGyroMeanFreqX
fBodyGyroMeanFreqY
fBodyGyroMeanFreqZ
fBodyAccMagMean
fBodyAccMagStd
fBodyAccMagMeanFreq
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagStd
fBodyBodyAccJerkMagMeanFreq
fBodyBodyGyroMagMean
fBodyBodyGyroMagStd
fBodyBodyGyroMagMeanFreq
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagStd
fBodyBodyGyroJerkMagMeanFreq

#ACTIVITY LABELS
WALKING (VALUE 1)
WALKING_UPSTAIRS (VALUE 2)
WALKING_DOWNSTAIRS (VALUE 3)
SITTING(VALUE 4)
STANDING (VALUE 5)
LAYING(VALUE 6)

#DATA SET INFORMATION
1. x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
2. x_data, y_data and subject_data contain the merged data of the respective train and test data.
3. final_data merges x_data, y_data and subject_data.
4. mean_std_features is a numeric vector which is used to extract the desired data and x_data dataset is corrected with the names contained in features.txt
5. A similar approach is taken with activity names through the activities variable.
6. Using cbind all_data dataset is created which contains the descriptive labels and desired data only.
7. Finally, using the all_data dataset, tidydata.txt is created which contains the relevant averages of each variable for each activity and each subject.

#DATA PROCESSING STEPS
The R script run_analysis.R performs the 5 steps as decsribed in the course project guidelines.

1. Firstly, all the similar data is merged using the rbind() function. 
2. Then the columns with the mean and standard deviation measures are taken from the whole dataset and those extracted columns are given the correct names for which features.txt is used.
3. The activity names are taken from activity_labels.txt and they are substituted in the dataset.
4. Similarly, the columns with abbreviated names are corrected with descriptive labels.
5. Finally, a new dataset is generated with all the average measures for each subject and activity type. The output file is called tidydata.txt, and uploaded to this repository.