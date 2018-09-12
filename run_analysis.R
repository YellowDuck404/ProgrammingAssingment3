

library(data.table)
library(dplyr)
library(reshape2)

## directory to files
file_dir <- paste0(getwd(), "\\UCI HAR Dataset\\")
# "C://D/Coursera/DataScience/workspace/data/course2project/UCI HAR Dataset/"

read_my_data <- function(file_dir, type, activity_names, feature_names) {
  
  message(paste("start reading ", type, "files"))
  
  my_file_dir1 <- paste0(file_dir, type)
  # subject_*.txt file
  subject <- read.table(
    file = paste0(my_file_dir1, "\\subject_", type, ".txt"), 
    header = FALSE, 
    sep = " ",
    col.names = c("SubjectId")
  )
  
  message("finished reading subject_*.txt file - 1 out of 3")
  
  # y_*.txt file
  activity <- read.table(
    file = paste0(my_file_dir1, "\\y_", type, ".txt"), 
    header = FALSE, 
    sep = " ",
    col.names = c("ActivityId")
  )
  
  message("finished reading activity_*.txt file - 2 out of 3")
  
  # X_*.txt file
  data <- read.table(
    file = paste0(my_file_dir1, "\\X_", type, ".txt"), 
    header = FALSE,
    col.names = feature_names$featurename
  )
  
  message("finished reading X_*.txt file - 3 out of 3")
  
  dataAll <- cbind(subject, activity, data)
  
  return(dataAll)  
}

## step 1.	Merges the training and the test sets to create one data set.

# read activity_labels.txt file
ActivityNames <- read.table(
  file = paste0(file_dir, "./activity_labels.txt"), 
  header = FALSE, sep = " ", 
  col.names = c("ActivityId", "ActivityName")
  )

# read features.txt file
feature_names <- read.table(
  file = paste0(file_dir, "./features.txt"), 
  header = FALSE, sep = " ", 
  col.names = c("featureid", "featurename")
)

# read DATA, test and train, files
type <- "test"
test_data <- read_my_data(file_dir, type, ActivityNames, feature_names)

type <- "train"
train_data <- read_my_data(file_dir, type, ActivityNames, feature_names)

# merge DATA, test and train, files
data1 <- rbind(test_data, train_data)


# step 2.	Extracts only the measurements on the mean and standard deviation for each measurement. 

colnames_selection <- grep(".*mean\\(\\)|.*std\\(\\)", feature_names$featurename, ignore.case = TRUE)

data2 <- select(data1, contains("SubjectId"), contains("ActivityId"), colnames_selection+2)

# step 3.	Uses descriptive activity names to name the activities in the data set

data3 <- mutate(data2, 
                ActivityName = factor(
                  x = ActivityId, 
                  levels = ActivityNames$ActivityId,
                  labels = ActivityNames$ActivityName))
data3 <- select(data3, -contains("ActivityId"))

# step 4.	Appropriately labels the data set with descriptive variable names.
feature_names_clean <- gsub("[[:punct:]]", "", colnames(data3))    # remove special characters
feature_names_clean <- gsub("mean", "Mean", feature_names_clean) # replace mean with Mean
feature_names_clean <- gsub("std", "Std", feature_names_clean)   # replace std with Std
colnames(data3) <- feature_names_clean

# step 5.	From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject.

# melting data frames
id_vars <- c("SubjectId", "ActivityName")
measure_vars <- setdiff(names(data3), id_vars)

data5melt <- melt(data3, id = c("SubjectId", "ActivityName"), measure.vars = measure_vars)

# casting data frames
data5 <- dcast(data5melt, SubjectId + ActivityName ~ variable, mean)
head(data5)

# step 6. Save results to flaf file
filedate <- Sys.Date()
write.table(data5, paste0("tidy_dataset_", filedate, ".txt"), row.names = FALSE)
