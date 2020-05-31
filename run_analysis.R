### loading the libraries
library(plyr); library(dplyr)

### reading the test data

subject_test <- read.table("./data/test/subject_test.txt")

x_test <- read.table("./data/test/X_test.txt")

y_test <- read.table("./data/test/y_test.txt")

### reading the train data

subject_train <- read.table("./data/train/subject_train.txt")

x_train <- read.table("./data/train/X_train.txt")

y_train <- read.table("./data/train/y_train.txt")

### reading other data

column_labels <- read.table("./data/features.txt")

column_names_v <- column_labels$V2

### 4. put appropriate labels to the columns
### setting the names of the columns to the datasets

colnames(x_train) <- column_names_v
colnames(x_test) <- column_names_v
colnames(subject_test) <- c("subject_id")
colnames(subject_train) <- c("subject_id")
colnames(y_test) <- c("activity")
colnames(y_train) <- c("activity")

### attaching the activity and subject columns to the datasets

test_df <- cbind(x_test, subject_test, y_test)
train_df <- cbind(x_train, subject_train, y_train)

### combining the test and train datasets

df <- rbind(test_df, train_df)

### 2.
### creating a regex to extract columns only with mean and std, and the subject id and activity columns

pattern <- "[Mm]ean|std|subject_id|activity"
grep(pattern, colnames(df))

### saving only the columns containing the mean and std values in a new data frame

df_clean <- df[, grep(pattern, colnames(df))]

### 3. Use descriptive activity names to name the activities in the data set
### reading the activity labels
activity_labels <- read.table("./data/activity_labels.txt")
### substituting numbers with descriptive names
df_clean$activity <- as.character(df_clean$activity)
list <- c("1"="WALKING","2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING")
df_clean$activity <- as.factor(revalue(df_clean$activity, list))

### 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df_grouped <- group_by(df_clean, subject_id, activity)
df_summary <- summarise_all(df_grouped, mean)

#export tidydata set
write.table(df_summary , "./tidydata.txt" ,sep = "\t" ,row.names = FALSE)