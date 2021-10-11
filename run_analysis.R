
  #library(dplyr)
  #libary(readr)
  #library(plyr)
  #library(tidyr)
  
  #NOTE: download files to local workspace
  
  #read in train & test subject files; update column label V1 to ""subjectID"
  subject_id_train<-read.table("./UCI_HAR_Dataset/train/subject_train.txt")
  subject_id_train<-rename(subject_id_train, subjectID=V1)
  subject_id_test<-read.table("./UCI_HAR_Dataset/test/subject_test.txt")
  subject_id_test<-rename(subject_id_test, subjectID=V1)
  
  #read in train & test activity files; update column label V1 to "activity"
  activity_train<-read.table("./UCI_HAR_Dataset/train/y_train.txt")
  activity_train<-rename(activity_train, activity=V1)
  activity_test<-read.table("./UCI_HAR_Dataset/test/y_test.txt")
  activity_test<-rename(activity_test, activity=V1)
  
  #read in train & test data files
  #add 'activity' and 'subjectID' (columns and data) to train & test data files
  traindata<-read.table("./UCI_HAR_Dataset/train/X_train.txt")
  traindata<-cbind(traindata, subject_id_train)
  traindata<-cbind(traindata, activity_train)
  traindata<-select(traindata, subjectID, activity, everything())
  testdata<-read.table("./UCI_HAR_Dataset/test/x_test.txt")
  testdata<-cbind(testdata, subject_id_test)
  testdata<-cbind(testdata, activity_test)
  testdata<-select(testdata, subjectID, activity, everything())
  
  #combine testdata and traindata into one data frame (fulldata)
  fulldata<-rbind(testdata, traindata)
  
  #select the columns (variables) for the mean & std variables
  #read in features table to get variable (column) names and indexes
  features<-read.table("./UCI_HAR_Dataset/features.txt")
  x<-grep("\\bmean()\\b|\\bstd()\\b", features$V2)
  measures<-features[x,]
  colnames(measures)<-c("measureID", "measure")
  measures$measure<-as.character(as.factor(measures$measure))
  
  #subset data to mean & std variables
  variables<-c("subjectID","activity","V1","V2","V3","V4","V5", "V6","V41","V42","V43","V44","V45", "V46","V81","V82","V83","V84","V85", "V86","V121","V122","V123","V124","V125", "V126","V161","V162","V163","V164","V165", "V166", "V201","V202","V214","V215","V227", "V228", "V240","V241","V253","V254","V266","V267","V268","V269","V270","V271","V345","V346","V347","V348","V349","V350","V424","V425","V426","V427","V428","V429","V503","V504","V516","V517","V529","V530","V542","V543")
  fulldata<-fulldata[,variables]
  
  #rename variable/column names to descriptive
  newnames<-c(measures$measure)
  colnames(fulldata)<-c("subjectID", "activity", newnames)
  fulldata<-arrange(fulldata, subjectID, activity)
  fulldata$activity[fulldata$activity==1]<-"WALKING"
  fulldata$activity[fulldata$activity==2]<-"WALKING_UPSTAIRS"
  fulldata$activity[fulldata$activity==3]<-"WALKING_DOWNSTAIRS"
  fulldata$activity[fulldata$activity==4]<-"SITTING"
  fulldata$activity[fulldata$activity==5]<-"STANDING"
  fulldata$activity[fulldata$activity==6]<-"LAYING"
  
  #create tidydata set...
  #rename activities to activity names vs IDs
  groupdf<-fulldata %>% group_by(subjectID,activity) %>% summarize_all(mean)

