The following is a description of how my run_analysis.R script works. It is broken down into the five steps that were listed as part of the assignment. 

Step 1: Merging the training and test sets to create one data set. 
  The first portion of the code uses the read.table() function to import the text files into appropriate variables. Notice that the setwd() function preceeds the appropriate commands to ensure that the working directory is automatically set to the correct folder. This step also includes the requirements for Step 4 by ascribing the columns with the names listed in the features.txt file. 
  
Step 2: Extracting only the measurements for mean and standard deviation for measurement. 
  This part of the code uses regular expression, specifically the grep() function, to find all the column names that include the work 'mean' and 'std'. All relavant columns are assigned to a new data frame. 
  
Step 3: Uses descriptive activity names to name the activities in the data set. 
  The activity column is updated according to the activity_labels.txt file. The numbers are converted to their corresponding string value. 
  
Step 4: Appropriately label the data set with descriptive variable names.   This step is accomplished in Step 1 as described. 

Step 5: Create a second, independent tidy data set from the data set in step 4 with the average of each variable for each activity and each subject. 
  The final step was broken down into two parts. The first part splits the data according to activity and uses the sapply() function to find the averages of the columns. The second part splits the data by subject # and uses the same method to find the averages of each column. The data frames from the two parts are then combined together using the rbind() function and, using the write.table() function, is exported to the designated folder. 
