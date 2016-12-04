# Codebook

This file describes the code in `run_analysis.R`

The code is separated by comments/sections:

* Subjects
* Activities
3. Preparing the Dataset
4. Features
5. Merging training & testing data
6. Splitting the readings into multiple columns
7. Getting the mean & std columns
8. Final tidy dataset consisting of the averages of each variable for each subject/activity

## Subjects
Reads the subjects for both the training & testing dataset and combines them together.

## Activites
Reads and tidies the activity labels. 
Adds id to the activity labels.
Reads the list of training & testing activities.
Stacks the training and testing activities together in one dataset along with the labels.

## Preparing the Dataset
Combines the subjects and activities into one dataset. Readings to be added later.

## Features
Reads the features file, cleans it into a readable format and generates a 'feature vector' to be used as column headings later.

## Merging Training & Testing Data
Reads both the training & testing datasets for the measurements and merges them into one dataset.

## Splitting the readings into multiple columns
The measurements dataset needs to be split into several columns. The code here splits the measurements into individual columns, one for each feature. Then generates a dataset that contains the measurements with their descriptive column names.

## Getting the mean & std columns
As requested, we only need the columns that contain the mean or standard deviation measurements. This code creates a subset of the data to give the desired output ("dataset").

## Final tidy dataset consisting of the  average of each variable for each subject/activity
Creates a new dataset that summarises the average of each of the measures from the above dataset for each subject/activity combination.
Saves the output to a text file.
