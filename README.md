# Getting and Cleaning Data Course Project

This is a README file for the course project on getting and cleaning data.
The data is included in the repository and can be also downloaded here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data should be saved in the script folder named "data"

### Prerequisites

you will need to install the following packages for the code to run: plyr and dplyr

```
install.packages("plyr"), install.packages("dplyr")
library(plyr); library(dplyr)
```
Also data should be saved in the a folder named "data"

## Explanation of the script run_analysis.R

1. in the first part we are just loading the necessary libraries and loading the data

```
library(plyr); library(dplyr)

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
```

2. in the second part we read the file containing the column names and assign them to the columns in the data frames
```
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
```

3. in this step we attach the activity and the subject id to the data frames

```
### attaching the activity and subject columns to the datasets

test_df <- cbind(x_test, subject_test, y_test)
train_df <- cbind(x_train, subject_train, y_train)
```

4. Here, we are merging the test and the train datasets using rbind, because using the merge function with mess the order of the values

```
### combining the test and train datasets
df <- rbind(test_df, train_df)
```

5. In the next step we are creating a regex to extract all the columns that contain mean and std in their names

```
### creating a regex to extract columns only with mean and std, and the subject id and activity columns

pattern <- "[Mm]ean|std|subject_id|activity"
grep(pattern, colnames(df))

### saving only the columns containing the mean and std values in a new data frame

df_clean <- df[, grep(pattern, colnames(df))]
```

6. Here we change the values in the column "activity" in order for it to be more comprehensive. Instead of numbers 1 to 6, we assign the action activities taken from the activity_labels.txt

```
### reading the activity labels
activity_labels <- read.table("./data/activity_labels.txt")
### substituting numbers with descriptive names
df_clean$activity <- as.character(df_clean$activity)
list <- c("1"="WALKING","2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING")
df_clean$activity <- as.factor(revalue(df_clean$activity, list))
```

7. At last we are grouping by subject_id and activity and summarizing all the other columns to show the average of the values

```
df_grouped <- group_by(df_clean, subject_id, activity)
df_summary <- summarise_all(df_grouped, mean)
```