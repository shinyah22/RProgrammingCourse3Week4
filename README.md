# README for Data Cleaning Script

## Overview

This script, `run_analysis.R`, performs data preparation and then followed by a series of steps to clean a data set containing wearable computing data. The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. The goal is to prepare tidy data that can be used for later analysis.

## Data Source

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

- Dataset: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data for the project:

- [Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Script Functionality

1. **Setup and Data Download**: The script first checks if the necessary `dplyr` package is installed and then loads it. It then downloads the dataset from the provided URL and unzips it into a directory on your local machine.

2. **Read Data**: It reads in the training and test data sets along with the subject, activity, and feature data. 

3. **Merge Data**: The script merges the training and the test sets to create one data set.

4. **Extract Measurements**: It extracts only the measurements on the mean and standard deviation for each measurement.

5. **Use Descriptive Activity Names**: The script uses descriptive activity names to name the activities in the data set.

6. **Label Data with Descriptive Variable Names**: It appropriately labels the data set with descriptive variable names, making it more understandable and accessible.

7. **Create a Tidy Data Set**: Finally, it creates a second, independent tidy data set with the average of each variable for each activity and each subject.

8. **Output File**: The tidy data set is then outputted into a file named `tidy_data.txt`, which can be used for further analysis.

## How to Run the Script

1. Place `run_analysis.R` in your R working directory.
2. Run the script using `source("run_analysis.R")`.
3. The tidy data will be written in the working directory as `tidy_data.txt`.

## Dependencies

- R package: `dplyr`

