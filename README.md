# Course_project_human_activity
In the code file run analysis, we read the datasets related to the human activity experience that located in working directory.

First, we read the following files :

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/subject_train.txt': Each row identifies the subject who performed the   activity for each window sample. Its range is from 1 to 30. 

Second, for both test and train, we merge the files by columns and then by row.
So we obtain one dataset with all experiences with id subject and id activity for each experience.

Third, with the function grep we isolate the name variables that contain either the word mean or std and their position in features file. by these positions we select only the correponding variables in our data.

Fourth, we merge the data with the file containing the activity labels based on id activity.

Fifth, we rename the variables according to the features file.

Finally, we calculate the means of columns by aggregate function, and we write the data in a file named average_variable_data.txt located at working directory.
