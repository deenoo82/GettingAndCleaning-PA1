file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(file_url,destfile="DataSet-PA1.zip",mode="wb")
unzip("DataSet-PA1.zip")
date_downloaded <- date()

install.packages("stringr")
library(stringr)
#str_replace_all(test, "[[:punct:]]", " ")

## load the data
### load feature names
features <- read.csv(".\\UCI HAR Dataset\\features.txt",sep=" ")
#### exam the features
features

f### load X
x_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", strip.white=TRUE)
x_test <-  read.table(".\\UCI HAR Dataset\\test\\X_test.txt", strip.white=TRUE)

### load y
y_train <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt", strip.white=TRUE)
y_test <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", strip.white=TRUE)

### load activities
activity_label <- read.table(".\\UCI HAR Dataset\\activity_labels.txt",strip.white=TRUE)
activity_label
