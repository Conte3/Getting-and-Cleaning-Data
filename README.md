# Getting-and-Cleaning-Data
View the Codebook for data explanation and list of features.

Steps followed to tidy the data:

0. Setting working directory and loading libraries.
    - Libraries used: dplyr for bind_rows() and bind_cols(), reshape2 for melt() and dcast() and data.table for the grouping

1. Create data frames for the basic project:
    - Activity list: Assigned to data frame activityLabels
    - Feature list: Assigned to data frame featureLabels
    
2. Geting the datasets
    - Read the subjects: Assigned to data frame subtrain 
    - Read the activity list: Assigned to data frame ytrain
    - Read the test data: Assigned to data frame xtrain and inserted the column names from featureLabels
      
    - Repeat the same steps for test dataset
    
3. Col bind and Row bind the datasets together
    - Column Binding the sub,y and x sets for both test and train, naming them respectively
    - Row Binding both test and train into assined as dataset
    - Deleting temporary datasets to clean up memory
    
4. Subsetting and Labeling
    - Extracting only the columns that contain the means or the standard deviation for each measurement 
    and assigne this to data frame subset
    - Labeling the activities according to the activityLabels data frame. 
    This generated another column with the names and the new data frame was assigned to labeled
    
5. Reshaping, finding the average and saving the txt
    - Melt the many colums into a single column called variable
    - Finding the average by SubjectID,ActivityLabelName and variable, and using data.table for more agile operation
    - Writting the result into a text file
