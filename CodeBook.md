#    Two datasets are created and saved:

(NOTE: The second dataset, #2 below - "HARUS_SummaryData.txt", is the course project dataset)

##       1. HARUS_data.txt

          Test and train measurements, combined, with activity and subject number.
          Only mean and standard deviation is retained for 33 parameters creating
          a dataset with 68 variables.
          Subject, Activity, (33 parameters with mean and std)

              Subject      (interger - 1 through 30)
              Activity     (text - one of six possible values indicating reported 
                                   activity at time of measurement)
                           (LAYING, SITTING, STANDING, WALKING, 
                              WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)

                 (numeric - variables below have _mean and _std versions - values are numeric in units of 
                            g = gravitational units) [66 total variables]
              tBodyAcc-XYZ       (tBodyAcc_mean_X, tBodyAcc_mean_Y, tBodyAcc_mean_Z,
                                  tBodyAcc_std_X, tBodyAcc_std_Y, tBodyAcc_std_Z, six variables)
              tGravityAcc-XYZ    (follows same format as tBodyAcc, six variables)
              tBodyAccJerk-XYZ   (follows same format as tBodyAcc, six variables)
              tBodyGyro-XYZ      (follows same format as tBodyAcc, six variables)
              tBodyGyroJerk-XYZ  (follows same format as tBodyAcc, six variables)
              tBodyAccMag        (tBodyAccMag_mean, tBodyAccMag_std, two variables)
              tGravityAccMag     (follows same format as tBodyAccMag, two variables)
              tBodyAccJerkMag    (follows same format as tBodyAccMag, two variables)
              tBodyGyroMag       (follows same format as tBodyAccMag, two variables)
              tBodyGyroJerkMag   (follows same format as tBodyAccMag, two variables)
              fBodyAcc-XYZ       (follows same format as tBodyAcc, six variables)
              fBodyAccJerk-XYZ   (follows same format as tBodyAcc, six variables)
              fBodyGyro-XYZ      (follows same format as tBodyAcc, six variables)
              fBodyAccMag        (follows same format as tBodyAccMag, two variables)
              fBodyAccJerkMag    (follows same format as tBodyAccMag, two variables)
              fBodyGyroMag       (follows same format as tBodyAccMag, two variables)
              fBodyGyroJerkMag   (follows same format as tBodyAccMag, two variables)

##       2. HARUS_SummaryData.txt

          Same as dataset 1, collapsed by subject/activity.  Means of all measurement 
          variables are computed by subject and activity, giving one record per subject/activity 
          and 66 parameter variables as above (180 total observations).

