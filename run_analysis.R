# Install the package if it's not already installed
if (!require(dplyr)) {
  install.packages("dplyr")
}

library(dplyr)

# URL for the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download and unzip the dataset
temp <- tempfile()
download.file(url, temp)
unzip(temp, exdir = "./data")
unlink(temp)

# Set the path for the files to be loaded
path_rf <- file.path("./data", "UCI HAR Dataset")

# Load the training data
train_x <- read.table(file.path(path_rf, "train", "X_train.txt"))
train_y <- read.table(file.path(path_rf, "train", "y_train.txt"))
subject_train <- read.table(file.path(path_rf, "train", "subject_train.txt"))

# Load the test data
test_x <- read.table(file.path(path_rf, "test", "X_test.txt"))
test_y <- read.table(file.path(path_rf, "test", "y_test.txt"))
subject_test <- read.table(file.path(path_rf, "test", "subject_test.txt"))

# Combine the training and test sets
X <- rbind(train_x, test_x)
Y <- rbind(train_y, test_y)
Subject <- rbind(subject_train, subject_test)

# Load the feature names
features <- read.table(file.path(path_rf, "features.txt"))

# Extract only the measurements on the mean and standard deviation
mean_std_indices <- grep("-(mean|std)\\(\\)", features$V2)
X <- X[, mean_std_indices]

# Set the feature names as column names
names(X) <- features$V2[mean_std_indices]

# Load the activity labels
activity_labels <- read.table(file.path(path_rf, "activity_labels.txt"))

# Assign descriptive activity names to the activities in the data set
Y$Activity <- factor(Y$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Make variable names more descriptive (optionally using regular expressions for cleaning)
names(X) <- gsub("^t", "Time", names(X))
names(X) <- gsub("^f", "Frequency", names(X))
names(X) <- gsub("Acc", "Accelerometer", names(X))
names(X) <- gsub("Gyro", "Gyroscope", names(X))
names(X) <- gsub("Mag", "Magnitude", names(X))
names(X) <- gsub("-mean\\(\\)", "Mean", names(X))
names(X) <- gsub("-std\\(\\)", "STD", names(X))

# Rename the first "V1" column to "Subject"
names(Subject)[names(Subject) == "V1"] <- "Subject"

# Combine everything into one dataset
cleaned_data <- cbind(Subject, Y, X)

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- cleaned_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(mean)

# Write out the tidy_data to a file
write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
