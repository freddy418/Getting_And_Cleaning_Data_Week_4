# Getting and Cleaning Data - Week 4 Programming Assignment

This repo contains file run_analysis.R, this README, and a CodeBook describing the processed data file

# The run_analysis.R script does the following processing steps:

1. Downloads and extracts the data set from link provided by assignment description.

2. Merges the training and the test sets to create one data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement.

4. Uses descriptive activity names to name the activities in the data set

5. Appropriately labels the data set with descriptive variable names.

6. From the data set in step 4, creates a second, independent tidy data set named output_data.txt with the average of each variable for each activity and each subject.

# Code book describing the variables

The output data set, named output_data.txt, generated by run_analysis.R script contains the same number of rows as the training and test sets combined of the original data set. Each row includes the activity, the subject identifier, and feature variables estimated from sensor measurements. As part of the assignment, the mean and standard deviation estimates were the only feature variables extracted from the set of sensor measurements in the original data set and moved over to the output data set.
