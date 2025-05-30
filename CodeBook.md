# Code Book

## Data Source
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Dataset Information
The experiments were carried out with a group of 30 volunteers performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone.

## Variables
* `subject` - The ID of the test subject (1-30)
* `activity` - The type of activity performed
* Time and Frequency domain signal variables (containing "Time" or "Frequency")
* Mean and standard deviation measurements

## Transformations
1. Merged training and test sets
2. Extracted only mean and standard deviation measurements
3. Used descriptive activity names
4. Labeled variables appropriately
5. Created independent tidy data set with activity and subject averages
