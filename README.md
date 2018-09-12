==================================================================
==================================================================
INTRODUCTION
==================================================================
==================================================================
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 
==================================================================
The data used for the project represents data collected from the accelerometers from the Samsung Galaxy S smartphone. The whole description is available at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
==================================================================

The project has only one script, run_analysis.R.

run_analysis.R requires below libraries to run:
	data.table
	dplyr
	reshape2

In run_analysis.R there is one function, read_my_data(), responsible for loading and merging input data sets.

"UCI HAR Dataset" folder with input data needs to be unzipped to your R working directory.
Output file, tidy_dataset_<filedate>.txt will be saved to "UCI HAR Dataset" folder, where <filedate> is date of file creation.
