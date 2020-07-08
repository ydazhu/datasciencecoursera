# Step1: Merges the training and the test sets to create one data set.
  library('dplyr')
  setwd("~/Desktop/Data Science Class/datasciencecoursera/UCI HAR Dataset")
    features<-read.table('features.txt')
  setwd("~/Desktop/Data Science Class/datasciencecoursera/UCI HAR Dataset/test")
    subject_test<-read.table('subject_test.txt');colnames(subject_test)<-c("Subject")
    X_test<-read.table('X_test.txt');colnames(X_test)<-features[,2]
    y_test<-read.table('y_test.txt');colnames(y_test)<-c("Activity")
    test<-data.frame(Group=rep('test',2947),subject_test,y_test,X_test)
  setwd("~/Desktop/Data Science Class/datasciencecoursera/UCI HAR Dataset/train")
    subject_train<-read.table('subject_train.txt');colnames(subject_train)<-c("Subject")
    X_train<-read.table('X_train.txt');colnames(X_train)<-features[,2]
    y_train<-read.table('y_train.txt');colnames(y_train)<-c("Activity")
    train<-data.frame(Group=rep('train',7352),subject_train,y_train,X_train)
  master<-rbind(test,train)

# Step 2: Extracts only the measurements on the mean and standard deviation for each 
# measurement.
  grep('mean',names(master),fixed=FALSE)->x
  grep('std',names(master),fixed=FALSE)->y
  z<-sort(c(1:3,x,y))
  mean_std<-master[z]

# Step 3: Uses descriptive activity names to name the activities in the data set.
  mean_std$Activity<-sub(1,"Walking",mean_std$Activity);master$Activity<-sub(1,"Walking",master$Activity)
  mean_std$Activity<-sub(2,"Walking Upstairs",mean_std$Activity);master$Activity<-sub(2,"Walking Upstairs",master$Activity)
  mean_std$Activity<-sub(3,"Walking Downstairs",mean_std$Activity);master$Activity<-sub(3,"Walking Downstairs",master$Activity)
  mean_std$Activity<-sub(4,"Sitting",mean_std$Activity);master$Activity<-sub(4,"Sitting",master$Activity)
  mean_std$Activity<-sub(5,"Standing",mean_std$Activity);master$Activity<-sub(5,"Standing",master$Activity)
  mean_std$Activity<-sub(6,"Laying",mean_std$Activity);master$Activity<-sub(6,"Laying",master$Activity)

# Step 4: Appropriately labels the data set with descriptive variable names.
#         This step was completed in Step 1 by naming the column (variable) 
#         names using the features.txt file.  

# Step 5: From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
  # First, will create a table of averages for each activity.
  activity<-c('Walking','Walking Upstairs','Walking Downstairs','Sitting','Standing','Laying')
  a_avg<-split(mean_std[c(4:82)],mean_std$Activity)
  a_avg<-as.data.frame(t(sapply(a_avg,colMeans)))
  a_avg<-a_avg[activity,]
  a_avg<-cbind(Subject=rep('NA',6),Activity=activity,a_avg)
  
  # Second, we will create a table of averages for each subject
  subject<-c(1:30)
  s_avg<-split(mean_std[c(4:82)],mean_std$Subject)
  s_avg<-as.data.frame(t(sapply(s_avg,colMeans)))
  s_avg<-cbind(Subject=subject,Activity=rep('NA',30),s_avg)
  
  a_s_avg<-rbind(a_avg,s_avg)
  setwd("~/Desktop/Data Science Class/datasciencecoursera")
  write.table(a_s_avg,file='./tidydata.txt',row.names=FALSE)