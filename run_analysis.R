## Getting and cleaning data - course project 
setwd("~/Desktop/DS/GetAndCleanData")

# download file and unzip
filename <- "getdata_dataset.zip"

if(!file.exists(filename)){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                filename, method = "curl")
  unzip(filename)
}

# merge train and test set to create one merged dataset
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train_activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_feature <- read.table("./UCI HAR Dataset/train/X_train.txt")

train = cbind(train_sub, train_activity, train_feature)

test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test_activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_feature <- read.table("./UCI HAR Dataset/test/X_test.txt")

test = cbind(test_sub, test_activity, test_feature)

merged = rbind(train, test)

# extract measurements on mean and std for each measurement
features <- read.table("./UCI HAR Dataset/features.txt")
features_names <- as.character(features[,2])

feature_selected <- grep("[Mm]ean|std", features_names)
feature_selected_names <- grep("[Mm]ean|std", features_names, value = TRUE)
feature_selected_names = gsub("-mean","Mean", feature_selected_names)
feature_selected_names = gsub("-std","Std", feature_selected_names)
feature_selected_names = gsub("[()]","", feature_selected_names)

merged_selfeature <- merged[,c(1,2,feature_selected+2)]

# label the dataset with descriptive variable names
colnames(merged_selfeature) <- c("subject_id","activity_id", feature_selected_names)

# create separate dataset with mean of each var for each subj each act
library(reshape2)
merged_selfeature.melted <- melt(merged_selfeature, id = c("subject_id", "activity_id"))

merged_selfeature.mean <- dcast(merged_selfeature.melted, subject_id + 
                                  activity_id ~ variable, mean)
write.table(merged_selfeature.mean, "tidy_dataset.txt", row.names = FALSE)





