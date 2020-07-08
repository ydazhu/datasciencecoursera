The following is a description of all the variables that come up in my run_analysis.R script. It is organized into the five sections that were listed as part of the direction for this assignment.

Step 1: Merging the test and training set.
     {features, subject_test, X_test, y_test, subject_train, X_train, y_train} - the text files included with the data were loaded into these variables
     {test,train} - two data frome for the test and training set, respectively, were created that combines the three text files for each case
     {master} - the rbind() function is used to combine the test and train data frames into a single data frame. 
     
Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
     {x,y} - indices of all the features that contain the strings 'mean' and 'std'
     {z} - the sorted vector that contains all x and y values
     {mean_std} - a new data frame that contains all the columns in the master data frame according to the indices in the z vector
     
Step 3 + 4: No new variables introduced. This portion of the code uses the sub() function to add a descriptive string to the Activity column. 

Step 5: From the data set in step 4, creates a second, independent tidy data set 
     {activity} - character vector correponding to the 6 performed activities
     {a_avg} - data frame that contains the average values of all the column for each corresponding activity (n=6)
     {s_avg} - data frame that contains the average values of all the column for each corresponding subject (n=30)
     {a_s_avg} - combination of a_avg and s_avg data frames using the rbind() function
     