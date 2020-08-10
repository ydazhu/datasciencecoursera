Overview
--------

The purpose of this project is to generate a model to predict the
‘classe’ variable. To do that, we are going to use the training data set
and split it into another training and cross validation set. The second
training set will be used to generate the model and the cross validation
set will be used to test and predict the error.

Method
------

First, we are going to load the data from the csv files. The data
variable will then be split into training and testing sets at a ratio of
6:4 to generate and test our model, respectively. In this case, the
testing data set is analogous to the cross validation set in which we
will use to determine the error of our generated models. Since there are
160 different variables each with its own contribution to the prediction
model, we are going to train the models using all the variables without
NAs and empty values. In addition, we are going to exclude all the
columns for which the inputs are characters as well as the X column that
identifies the case number. The following code takes the training data,
processes it, and splits it into two datasets: training and
cross-validation (testing)

    # Loading the data
    setwd("~/Desktop/Data Science Class/datasciencecoursera")
    library(AppliedPredictiveModeling)
    library(caret)

    ## Loading required package: lattice

    ## Loading required package: ggplot2

    library(lubridate)

    ## 
    ## Attaching package: 'lubridate'

    ## The following objects are masked from 'package:base':
    ## 
    ##     date, intersect, setdiff, union

    rawdata<-read.csv('pml-training.csv',na.strings=c("", "NA"))
    # Getting rid of the columns that are NA
    data<-data.frame(matrix(,nrow=length(rawdata[,1]),ncol=0))
    for (i in 1:length(rawdata)) {
         if (sum(is.na(rawdata[i]))==0) {
              data<-data.frame(data,rawdata[i])}}
    data$classe<-as.factor(data$classe)
    data$cvtd_timestamp<-NULL
    data$X<-NULL
    data$new_window<-NULL#as.factor(data$new_window)
    data$user_name<-NULL#as.factor(data$user_name)
    # Randomly Shuffle data
    set.seed(1)
    rand_ind<-sample(nrow(data))
    data<-data[rand_ind,]
    data<-data[,order(colnames(data))]
    # Splitting the data into training and testing sets
    testIndex<-createDataPartition(data$classe, p = 0.40,list=FALSE)
    training<-data[-testIndex,]
    testing<-data[testIndex,]

The following code is used to load the testing data (final) with the
twenty test cases.

    rawfinal<-read.csv('pml-testing.csv')
    final<-data.frame(matrix(,nrow=length(rawfinal[,1]),ncol=0))
    for (i in 1:length(data)) {
         for (j in 1:length(rawfinal))
              if (colnames(data[i])==colnames(rawfinal[j])) {
                   final<-data.frame(final,rawfinal[j])}}
    final<-final[,order(colnames(final))]
    final$cvtd_timestamp<-NULL
    final$X<-NULL
    final$new_window<-NULL#as.factor(final$new_window)
    final$user_name<-NULL#as.factor(final$user_name)

The two models that we will use are trees and random forest. The best
model will be the one that has the lowest error rate as calculated by
the number of incorrect predictions divided by the size of the test set.

### Trees Prediction

The first step is to generate a Trees model with the training set and
use the predict function to determine the predictions.

    treesFit<-train(classe~.,method='rpart',data=training)
    prediction<-predict(treesFit,newdata=testing);value<-testing$classe
    error<-sum(prediction!=value)/length(testing$classe)
    print(error)

    ## [1] 0.5059873

The calculated error for this model is 0.506, which means that our trees
model classified a little less than half of the predictions correctly.
This is not good.

### Random Forest

We will generate a model using the randomForest package much like we did
for the Trees prediction.

    library(randomForest)

    ## randomForest 4.6-14

    ## Type rfNews() to see new features/changes/bug fixes.

    ## 
    ## Attaching package: 'randomForest'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     margin

    rfFit<-randomForest(classe~.,data=training)
    prediction<-predict(rfFit,newdata=testing);value<-testing$classe
    error<-sum(prediction!=value)/length(testing$classe)
    print(error)

    ## [1] 0.001273885

As expected, the random forest model predicted our model with a small
error rate of approximately 0.00127, meaning that nearly correctly
predicted all of cases in the testing set.

    prediction<-predict(rfFit,newdata=final)
    print(prediction)

    ##  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 
    ##  B  A  B  A  A  E  D  B  A  A  B  C  B  A  E  E  A  B  B  B 
    ## Levels: A B C D E

Applying this model on the final test data and using the final quiz
confirms that our model is valid.
