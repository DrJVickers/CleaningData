---
title: "README"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


There is one R file required for the assignment. (run_analysis.R)
This R file defines a main function (run_analysis) and a number of helper functions.

# Functions:

## extract_data - This function opens up the folder with the data and applies the following transformations:
  
  1. Renames the columns to make them more descriptive
  
  
  2. Extracts columns where column name is either std or mean.
  
  
  3. Opens the subjects file and adds the subject to the table
  
  
  4. Opens the activity file and adds activities to the table
 
  
  5. Ensures the activity is described with a descriptive name
  
  
  6. Combines the STD, Mean, Activity and Subject Columns into one Table and Returns it.
  
  

## merge_data - This function merges the test and train data sets:

  1. Open the test files and extract required information
  
  2. Open training files and extract required information
  
  3. Merge the two tables into one.
  
  
## create_filename - This function is used to format a string into the required format so R can open the file.

descriptive_variable_names - This function searches through the column names for substrings and expands them to make the column names human readable.

## run_analysis - This is the main funtion.

  1.  Use the merge and extract data functions to acquire a table containing mean/std/activities and subjects.
  
  2. Use descriptive_variable_names function to relabel the columns to make them human readable.
  
  3. Group the information in the table by subject and activity.
  
  4. Use summarise function to find the mean of all the values and return them in a new table
  
  5. Returns the new table as an output of the function