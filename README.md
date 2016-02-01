# getting-cleaning-course-project
## Course Project for the Getting and Cleaning Data Course

This repo includes the files for the Course Project of the Getting and Cleaning Data Course on Coursera.

The project works with the data set from Human Activity Recognition Using Smartphones Dataset with a full description at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### The data set includes the following files:

- `README`

- `codebook.txt`: Shows information about the variables in each data set.

- `mean_std.txt`: Tidy data set of the mean values and standard deviations of the signals with the corresponing activity and subject.

- `averages.txt`: Tidy data set of the average of each variable in 'mean_std.txt' for each activity and each subject.

- `run_analysis.R`: Code for collect, work with, and clean the original data set.

### Description of the `run_analysis.R` script:

The code can be run as long as the Samsung data is in your working directory. The Samsung data is available at

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This code loads and cleans the data set, then creates two .txt files for the Course Project of the Getting ans Cleaning Data course.

The script does the followings:

1. Loads the data from the working directory into data frames.

2. Merges the training and the test sets to create one data set.

3. Extracts only the measurements on the mean and standard deviation for each measurement.

4. Appropriately labels the data sets test and train with descriptive variable names.

5. Uses descriptive activity names to name the activities in the data set.

6. From the data set in step 4, creates a second tidy data set with the average of each variable for each activity and each subject.

7. Saves the two data sets in two .txt files in the working directory.

### Reference:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
