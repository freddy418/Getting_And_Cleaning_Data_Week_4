library(dplyr)

filename <- "dataset.zip"
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

# Merges the training and the test sets to create one data set.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

# Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./UCI HAR Dataset/features.txt")
extracted_features <- features[grep(".*mean\\(\\)|std\\(\\)", features[,2], ignore.case = FALSE),]
x_merged_extracted <- x_merged[,extracted_features[,1]]

# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
colnames(x_merged_extracted) <- extracted_features[,2]
colnames(y_merged)   <- "activity"
colnames(subject_merged) <- "subject"

# From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
ds2 <- cbind(subject_merged, y_merged, x_merged_extracted)
ds2$activity <- factor(ds2$activity, levels = labels[,1], labels = labels[,2]) 
ds2$subject  <- as.factor(ds2$subject) 
ds2_mean <- ds2 %>% group_by(subject, activity) %>% summarize_all(funs(mean)) 
write.table(ds2_mean, file = "./output_data.txt", row.name = FALSE)
