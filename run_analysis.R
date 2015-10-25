# run_analysis.R - solution to course project for Getting and Cleaning Data
#
# Author: Jeffrey D. Young - Oct 23, 2015
#
# Description: 
#    This script reads data created from the 
#    "Human Activity Recognition Using Smartphones" project.
#
#    From this data a summary dataset is created that contains the means
#    of various measurements, by subject and reported activity.
#    (one record per subject/activity)
#
#    Two datasets are created and saved:
#
#       1. HARUS_data.txt
#
#          Test and train measurements, combined, with activity and subject number.
#          Only mean and standard deviation is retained for 33 parameters creating
#          a dataset with 68 variables.
#          Subject, Activity, (33 parameters with mean and std)
#
#              Subject      (interger - 1 through 30)
#              Activity     (text - one of six possible values indicating reported activity at time of measurement)
#                              (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
#
#                 (numeric - variables below have _mean and _std versions - values are numeric in units of 
#                            g = gravitational units) [66 total variables]
#              tBodyAcc-XYZ       (tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z,
#                                  tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z, six variables)
#              tGravityAcc-XYZ    (follows same format as tBodyAcc, six variables)
#              tBodyAccJerk-XYZ   (follows same format as tBodyAcc, six variables)
#              tBodyGyro-XYZ      (follows same format as tBodyAcc, six variables)
#              tBodyGyroJerk-XYZ  (follows same format as tBodyAcc, six variables)
#              tBodyAccMag        (tBodyAccMag_mean, tBodyAccMag_std, two variables)
#              tGravityAccMag     (follows same format as tBodyAccMag, two variables)
#              tBodyAccJerkMag    (follows same format as tBodyAccMag, two variables)
#              tBodyGyroMag       (follows same format as tBodyAccMag, two variables)
#              tBodyGyroJerkMag   (follows same format as tBodyAccMag, two variables)
#              fBodyAcc-XYZ       (follows same format as tBodyAcc, six variables)
#              fBodyAccJerk-XYZ   (follows same format as tBodyAcc, six variables)
#              fBodyGyro-XYZ      (follows same format as tBodyAcc, six variables)
#              fBodyAccMag        (follows same format as tBodyAccMag, two variables)
#              fBodyAccJerkMag    (follows same format as tBodyAccMag, two variables)
#              fBodyGyroMag       (follows same format as tBodyAccMag, two variables)
#              fBodyGyroJerkMag   (follows same format as tBodyAccMag, two variables)
#
#       2. HARUS_SummaryData.txt
#
#          Same as dataset 1 (collapsed by subject/activity).  Means of all measurement 
#          variables are computed by subject and activity, giving one record per subject/activity 
#          and 66 parameter variables as above.
#

library(dplyr)

# load test data
test_subj <- read.table("data/test/subject_test.txt",header=F)     # file with test subjects
test_act <- read.table("data/test/y_test.txt",header=F,col.names=c("Act_ID"))      # file with test activities
test_meas <- read.table("data/test/X_test.txt",header=F)           # file with test measurements
test_data <- cbind(test_subj,test_act,test_meas)                   # combine subject ID, activity ID and measurements

# load train data
train_subj <- read.table("data/train/subject_train.txt",header=F)  # file with train subjects
train_act <- read.table("data/train/y_train.txt",header=F,col.names=c("Act_ID"))   # file with train activities
train_meas <- read.table("data/train/X_train.txt",header=F)        # file with train measurements
train_data <- cbind(train_subj,train_act,train_meas)               # combine subject ID, activity ID and measurements

# combine test and train data
all_data <- rbind(test_data,train_data)

# read in measurement labels and apply nice names to columns in measurement data tables
meas_labels <- read.table("data/features.txt",header=F)                  # labels for measurements (columns in measurement files)
names(meas_labels) <- c("Meas_ID","Measurement")                         # label columns in measurement labels lookup
meas_labels$Measurement <- gsub("[()]","",meas_labels$Measurement)       # drop ()s from name
meas_labels$Measurement <- gsub("[-,]","_",meas_labels$Measurement)      # change dashes and commas to periods to make nice names
meas_names <- c("Subject","Act_ID",as.vector(meas_labels$Measurement))   # make a vector of the new column names

names(all_data) <- meas_names                                            # apply column names to combined data set

# load activity codes
activity_codes <- read.table("data/activity_labels.txt",header=F)  # codelist for activities
names(activity_codes) <- c("Act_ID","Activity")

# add activity text description
all_data <- merge(activity_codes, all_data, sort=FALSE)

# keep only activity, subject and mean/std measurements
datanames <- names(all_data)
all_data <- subset(all_data,select=c("Subject","Activity",datanames[grep("(_mean_|_std_|_mean$|_std$)",datanames)]))

# save full dataset
write.table(all_data,"HARUS_data.txt",row.names=FALSE)

# compute means by subject and activity
anal_data <- aggregate(all_data[3:ncol(all_data)],by=list(Subject=all_data$Subject,Activity=all_data$Activity),mean)
anal_data <- arrange(anal_data,Subject,Activity)

# save final summary dataset
write.table(anal_data,"HARUS_SummaryData.txt",row.names=FALSE)

