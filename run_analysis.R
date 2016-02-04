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
features <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE, quote="\"")
names(x_data) <- features$V2
y_data <- rbind(y_train, y_test)
names(y_data) <- c("Activity")
subject_data <- rbind(subject_train, subject_test)
names(subject_data) <- c("Subject")

##Merging columns to get the data frame
combine <- cbind(subject_data, y_data)
final_data <- cbind(x_data, combine)

##2. Extract only the measurements on the mean and std for each measurement
subset_data <-final_data[,grepl("Subject|Activity|mean\\(\\)|std\\(\\)", names(final_data))]

##Get columns with only mean() or std() in their names
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

##subset and correct the desired columns and then correct the column name
x_data <- x_data[, mean_std_features]
names(x_data) <- features[mean_std_features, 2]

##3. Use descriptive activity names to name the activities in the data set
activities <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

##Update the values with correct activity name and then correct the column name
y_data[,1] <- activities[y_data[,1],2]

##4. Appropriately labels the data set with descriptive variable names
names(x_data)<-gsub("^t", "time", names(x_data))
names(x_data)<-gsub("^f", "frequency", names(x_data))
names(x_data)<-gsub("Acc", "Accelerometer", names(x_data))
names(x_data)<-gsub("Gyro", "Gyroscope", names(x_data))
names(x_data)<-gsub("Mag", "Magnitude", names(x_data))
names(x_data)<-gsub("BodyBody", "Body", names(x_data))
names(x_data)<-gsub("-mean", "Mean", names(x_data))
names(x_data)<-gsub("-std", "Std", names(x_data))
names(x_data)<-gsub("\\()", "", names(x_data))

##Bind all data into one single data set
all_data <-cbind(x_data, y_data, subject_data)

##5. Create a second independent tidy dataset with average of each variable
##for each activity and each subject

averages_data <- ddply(all_data, .(Subject, activity), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "tidy_data.txt", row.name=FALSE)
