The data used for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

run_analysis.R runs as follow:

1.	Loads and merges files as follow to create one data set.
	features.txt
	activity_labels.txt

	test/subject_test.txt
	test/X_test.txt
	test/y_test.txt

	train/subject_train.txt
	train/X_train.txt
	train/y_train.txt

2.	Extracts only the measurements on the mean and standard deviation for each measurement, i.e. output of mean() and std() functions.
3.	Uses descriptive activity names to name the activities in the data set ( i.e. WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
4.	Appropriately labels the data set with descriptive variable names.
5.	Creates a tidy data set with the average of each variable for each activity and each subject.
6.	Saves a tidy data set to tidy_dataset.txt file.

run_analysis.R uses libraries as follow:
	data.table
	dplyr
	reshape2