# Load required packages
library(dplyr)

# 1. Download and unzip the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = "dataset.zip")
unzip("dataset.zip")

# 2. Read the data files
# Features and activity labels
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# 3. Merge training and test sets
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
merged_data <- cbind(Subject, Y, X)

# 4. Extract only mean and standard deviation measurements
tidy_data <- merged_data %>%
        select(subject, code, contains("mean"), contains("std"))

# 5. Use descriptive activity names
tidy_data$code <- activities[tidy_data$code, 2]

# 6. Label with descriptive variable names
names(tidy_data)[2] = "activity"
names(tidy_data) <- gsub("^t", "Time", names(tidy_data))
names(tidy_data) <- gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <- gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <- gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <- gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <- gsub("BodyBody", "Body", names(tidy_data))

# 7. Create independent tidy dataset with averages
final_data <- tidy_data %>%
        group_by(subject, activity) %>%
        summarise_all(mean)

# 8. Write the final tidy dataset to a file
write.table(final_data, "tidy_data.txt", row.names = FALSE)
