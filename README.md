# Course-Project-Getting-and-Cleaning-Data

NOTE: Original data, README, and file descriptions for the "Human Activity Recognition Using Smartphones Dataset" can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Files should be downloaded the the local workspace


run_analysis.R...

include the following libraries:
dplyr
readr
plyr
tidyr
  
The code executes the following steps:

Read in train & test subject files; update column label V1 to ""subjectID"
Read in train & test activity files; update column label V1 to "activity"
Read in train & test data files
Add 'activity' and 'subjectID' (columns and data) to train & test data files
Combine testdata and traindata into one data frame (fulldata)
Select the columns (variables) for the mean & std variables
Read in features table to get variable (column) names and indexes
Subset data to mean & std variables
Rename variable/column names to descriptive
Create tidydata set with collapsed means for each activity per subject

Available data sets:
fulldata (dataframe) - full dataset which combines training and test data with all variables; orignal variable names;
groupdf	(dataframe) - tidy dataset which includes only variables related to means and standard deviations; updated column names; collapsed means per subject/acivity.
