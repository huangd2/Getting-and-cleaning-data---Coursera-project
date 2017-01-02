## Getting and cleaning data - course project

This is the course project for Data Science Course 3 - Getting and cleaning data. The R script run_analysis.R submitted does the following:

1. Download the dataset if it doesn't exist in the current working directory.
2. Merge train and test sets to create one merged dataset.
   - step 1: column bind subject_train, y_train and X_train to train.
   - step 2: column bind subject_test, y_test and X_test to test.
   - step 3: row bind train and test to merged.
3. Extract columns that measure mean or standard deviation, together with columns of subject_id and activity_id.
4. Label the extracted dataset with descriptive variable names
5. Create a tidy dataset (saved as tidy_dataset.txt) with the mean of each variable for each subject and activity pair.
