file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url,destfile="DataSet-PA1.zip",mode="wb")
unzip("DataSet-PA1.zip")
date_downloaded <- date()

install.packages("reshape2")
library(reshape2)

## load the data

### load feature names
features <- read.csv(".\\UCI HAR Dataset\\features.txt",sep=" ",header=FALSE)
#### exam the features
features
#### load activities
activity_label <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",strip.white=TRUE)
head(activity_label)

### load subject data
train_subjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt",strip.white=TRUE)
test_subjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt",strip.white=TRUE)
#### merging subject data
subjects<- rbind(train_subjects, test_subjects)
#### remove un-needed subject objects
rm(train_subjects,test_subjects)
#### rename column name for the subjects
names(subjects)<-"subject"

### load y
y_train <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt", strip.white=TRUE)
y_test <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", strip.white=TRUE)
#### merging y data
Y<-rbind(y_train,y_test)
#### merge the y data with activity_label to get descriptive activity name by using the first column of activity_label
Y_label <- merge(Y,activity_label,by.y="V1")
#### rename column for Y_label for descritive column name
names(Y_label)<-c("activity_cd","activity")
#### remove un-needed data, y_train & y_test
rm(y_train,y_test,Y)

### load X
x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", strip.white=TRUE)
x_test <-  read.table(".\\UCI HAR Dataset\\test\\X_test.txt", strip.white=TRUE)
#### merging data for x
X<-rbind(x_train,x_test)
#### rename columns for X for descritive column name based on features
names(X)<-t(features$V2)
rm(x_train,x_test)

## extract mean and standard deviaion of each measure and form a new tidy data

### getting variables with mean & std
#### getting position of features that has mean or standard deviation
mean_std_pos <- features[grep("mean\\(\\)|std\\(\\)",features$V2),]
#### using the position extract above to extract only the mean and standard deviation
mean_std_dataset<- X[,mean_std_pos$V1]
#### remove un-needed data
rm(mean_std_pos)

### merging data of X, Y_label, meand_std_dataset into one single Dataset
#### merging
merged_data <- cbind(subjects, Y_label$activity, mean_std_dataset)
#### get the number of columns from the merged data to be used later in forming tidy data
size<-length(merged_data)
#### rename Y_label$activity to activity
names(merged_data)[2]<-"activity"
#### remove un-needed dataset
rm(mean_std_dataset,features,subjects,X,Y_label,activity_label)

### melting the data to form tidy data to move measurement to rows per subject & activity
tidyData<-melt(merged_data,id=c(1,2),measure.vars=c(3:size))
rm(merged_data)

### rename columns to subject, activity, measure, value
names(tidyData)<-c("subject","activity","measure","value")

## Creating new dataset with average per subject per activity
#### cast the data to calculate mean of per each subject per activity
meanData <- dcast(tidyData, subject+activity ~ measure, mean)
#### get size of meanData to be used in forming tidy data
size<-length(meanData)
#### melt the data to form 
tidyData_mean <- melt(meanData,id=c(1,2),measure.vars=c(3:size))
rm(meanData,size)
names(tidyData_mean)<-c("subject","activity","measure","mean")

#### save the tidy datas for submission
save(tidyData,file="PA1-tidyData.Rda")
save(tidyData_mean,file="PA1-tidyData_mean.Rda")

#### instruction for loading the saved data
load("PA1-tidyData.Rda")
load("PA1-tidyData_mean.Rda")