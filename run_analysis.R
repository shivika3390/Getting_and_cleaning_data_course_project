##Download and unzip the dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

##Reading the files
x_test <- read.table(file.path(path_rf, "test", "X_test.txt"), header=FALSE)
y_test <- read.table(file.path(path_rf, "test", "Y_test.txt"), header=FALSE)
subject_test <- read.table(file.path(path_rf, "test", "subject_test.txt"), header=FALSE)

x_train <- read.table(file.path(path_rf, "train", "X_train.txt"), header=FALSE)
y_train <- read.table(file.path(path_rf, "train", "Y_train.txt"), header=FALSE)
subject_train <- read.table(file.path(path_rf, "train", "subject_train.txt"), header=FALSE)

##1. Merging and creating one data set
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

##Merging columns to get the data frame
combine <- cbind(subject_data, y_data)
final_data <- cbind(x_data, combine)

##2. Extract only the measurements on the mean and std for each measurement
features <- read.table(file.path(path_rf, "features.txt"), header=FALSE)

##Get columns with only mean() or std() in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

##subset and correct the desired columns and then correct the column name
x_data <- x_data[, mean_std_features]
names(x_data) <- features[mean_std_features, 2]

##3. Use descriptive activity names to name the activities in the data set
activities <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

##Update the values with correct activity name and then correct the column name
y_data[,1] <- activities[y_data[,1],2]
names(y_data) <- "activity"

##4. Appropriately labels the data set with descriptive variable names
names(subject_data) <- "subject"
names(x_data)<-gsub("^t", "time", names(x_data))
names(x_data)<-gsub("^f", "frequency", names(x_data))
names(x_data)<-gsub("Acc", "Accelerometer", names(x_data))
names(x_data)<-gsub("Gyro", "Gyroscope", names(x_data))
names(x_data)<-gsub("Mag", "Magnitude", names(x_data))
names(x_data)<-gsub("BodyBody", "Body", names(x_data))

##Bind all data into one single data set
all_data <-cbind(x_data, y_data, subject_data)

##5. Create a second independent tidy dataset with average of each variable
##for each activity and each subject

Data2<-aggregate(. ~V1 + activity, all_data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)