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

summarize(df)


