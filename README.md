### Introduction

This repositoary conatins the code for programming assignment 1 of Getting
and Cleaning Data in Coursera by by Jeff Leek, Roger D. Peng, Brian Caffo, PhD.

The purpose of this project is to demostrate my ability to collect, work with
and clean a data set.  The  The goal is to prepare tidy data that can be used 
for later analysis.

The data that will be used is the Human Activity Recognition Using Smartphones 
Data Set from UCI.  A full description of the data can be obtained at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is downloaded from 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R contains the code for the following steps

1. download the dataset
2. unzip and merge the training and testing dataset into one dataset
3. extract mean and standard deviation of each measurement
4. format the dataset into tidy data based on tidy data pricipal
5. create a second dataset of the average of each subject and each activitythat based 
   on the prevoius dataset of mean and standard deviaion