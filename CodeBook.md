
##Project Detail

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 



##Steps to run the run_analysis.R file.

### Section 1. read the file located here

- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

### Section 2. Merge the file
Merge the test and training data using cbind and r bind function

### Section 3. Extract the measurement for mean and standard deviation for each measurement 
Create a vector by finding the values of mean|std|Subject|ActivityId" in the data set and keep the required data

### Section 4. Change the label of the data to more logincal ones
As per instruction we need to appropriately labels the data set with descriptive variable names. 

### Section 5. Create a tidy data set
creates a second, independent tidy data set with the average of each variable for each activity and each subject. The file that is generated here is Clean_data.txt.
