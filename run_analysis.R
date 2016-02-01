# This code loads and cleans the data set, then creates two .txt files for
# the Course Project of the Getting ans Cleaning Data course.
# 
# The script does the followings:
# 1. Loads the data from the working directory into data frames.
# 2. Merges the training and the test sets to create one data set.
# 3. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 4. Appropriately labels the data sets test and train with descriptive 
#    variable names.
# 5. Uses descriptive activity names to name the activities in the data set.
# 6. From the data set in step 4, creates a second tidy data set with the
#    average of each variable for each activity and each subject.
# 7. Saves the two data sets in two .txt files in the working directory.


library(dplyr)

# Load data from the working directory into data frames:
# 1. Get the path to the working directory
# 2. Combine this path with the name of the .zip file of the data set.
# 3. Unzip the file and read the .txt data sets into variables
wd <- getwd()
pth <- paste(wd, "getdata-projectfiles-UCI HAR Dataset.zip", sep = "/")

test <- read.table(unz(pth,"UCI HAR Dataset/test/X_test.txt"),
                   header = FALSE, stringsAsFactors = FALSE)
test_act <- read.table(unz(pth,"UCI HAR Dataset/test/y_test.txt"),
                       header = FALSE, stringsAsFactors = FALSE)
test_sub <- read.table(unz(pth,"UCI HAR Dataset/test/subject_test.txt"), 
                       header = FALSE, stringsAsFactors = FALSE)

train <- read.table(unz(pth,"UCI HAR Dataset/train/X_train.txt"), 
                    header = FALSE, stringsAsFactors = FALSE)
train_act <- read.table(unz(pth,"UCI HAR Dataset/train/y_train.txt"), 
                        header = FALSE, stringsAsFactors = FALSE)
train_sub <- read.table(unz(pth,"UCI HAR Dataset/train/subject_train.txt"), 
                        header = FALSE, stringsAsFactors = FALSE)

feat <- read.table(unz(pth, "UCI HAR Dataset/features.txt"), 
                   header = FALSE, stringsAsFactors = FALSE)
act_labs <- read.table(unz(pth, "UCI HAR Dataset/activity_labels.txt"), 
                       header = FALSE, stringsAsFactors = FALSE)

# Combine the data sets:
# 1. Combine the test data set with the test activity and test subject data.
# 2. Combine the train data set with the train activity and train subject data.
# 3. Combine the train and the test data sets to create one tbl data set 
#    named ds.
test[, 562] <- test_act[, 1]
test[, 563] <- test_sub[, 1]
train[, 562] <- train_act[, 1]
train[, 563] <- train_sub[, 1]
ds <- rbind(test, train)
ds <- tbl_df(ds)

# Extract only the measurements on the mean and standard deviation for each 
# measurement:
# 1. Find the indices for which "mean()" or "std()" is in the list of the
#    measurements, feat[, 2]. These  are the relevant indices, store them 
#    in meansd
# 2. Append indices 562 and 563 to meansd. These are the columns of the
#    activity and subject in ds.
# 3. Subset ds for the columns with indices in meansd
meansd <- grep("(mean|std)\\(\\)", feat[, 2])
len <- length(meansd)
meansd[len + 1] <- 562
meansd[len + 2] <- 563
ds <- ds[, meansd]

# Label the data set ds with descriptive variable names:
# 1. Add two rows to the data frame of measurements, feat, to incule "activity"
#    and "subject" in the 2nd column of the last two rows.
# 2. Subset feat for the rows with indices in meansd. Now the 2nd column stores
#    the column names for ds.
# 3. Assign the 2nd column of feat to the column names in ds.
feat[562,] <- c(562, "activity")
feat[563,] <- c(563, "subject")
colnam <- feat[meansd, 2]
colnames(ds) <- colnam

# Give descriptive activity names to name the activities in the data set
ds[, ncol(ds)-1] <- lapply(ds[, ncol(ds)-1], function(i) act_labs$V2[i])

# From the data set named ds, create a second tidy data set with the average
# of each variable for each activity and each subject:
# 1. Group ds by activity and subject
# 2. Calculate the averages for each group
grouped <- group_by(ds, activity, subject)
avers <- summarize_each(grouped, funs(mean))

# Save the two datasets, ds and avers into files ds.txt and avers.txt in the 
# working directory
write.table(ds, "./mean_std.txt")
write.table(avers, "./averages.txt")