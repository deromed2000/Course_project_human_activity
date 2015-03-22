#####Getting and cleaning Data Course Project 2 ################

###Reading the Data we need for our task
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subj_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subj_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")

#### Merges the training and the test sets to create one data set.
total_experience = rbind(cbind(subj_test, y_test, x_test), 
                         cbind(subj_train, y_train, x_train))
colnames(total_experience)[1] <- "id_subject"
colnames(total_experience)[2] <- "id_activity"

####Extracts only the measurements 
####on the mean and standard deviation for each measurement.

meanstd <- features[grep("mean", features[,2]),]
meanstd <- rbind(meanstd, meanstd <- features[grep("std", features[,2]),])
rownames(meanstd)  <- 1:79
measur_mean_std <- total_experience[ , meanstd[,1] + 2]
measur_mean_std <- cbind(total_experience[,1:2], measur_mean_std)

###Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
measur_mean_std <- merge(measur_mean_std, activity_labels, 
                         by.x = "id_activity", by.y = "V1", all = TRUE, 
                         sort = FALSE)
measur_mean_std <- rename(measur_mean_std,  activity_name = V2.y)

####Appropriately labels the data set with descriptive variable names

colnames(measur_mean_std)[3:81] <- as.character(meanstd[,2])


###From the data set in step 4, creates a second, independent tidy data set 
###with the average of each variable for each activity and each subject.

avg_tidy_data <- aggregate(measur_mean_std[,3:81], 
                           by= list(measur_mean_std$id_subject, 
                                    measur_mean_std$activity_name), FUN = mean)

colnames(avg_tidy_data)[1:2] <- c("id_subject", "activity_name")

write.table(avg_tidy_data, "./average_variable_data.txt", row.names = FALSE)
