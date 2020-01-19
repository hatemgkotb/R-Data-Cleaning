# libraries ######
 library(dplyr)
library(tidyr)
library(stringr)
library(purrr)

# Subjects ####
subject_train = read.csv("./data/subject_train.txt", header = FALSE)
subject_test = read.csv("./data/subject_test.txt", header = FALSE)
colnames(subject_train) = "subject"
colnames(subject_test) = "subject"
subjects = rbind(subject_train, subject_test)

# Activities ####
# Reading the labels
activity_labels = read.csv("./data/activity_labels.txt", header = FALSE)
activity_labels = activity_labels %>% separate(V1, c("id", "activity"),sep = " ")
activity_labels$id = as.integer(activity_labels$id)

# Reading the activity recordings
activity_train = read.csv("./data/y_train.txt", header = FALSE)
activity_test = read.csv("./data/y_test.txt", header = FALSE)
colnames(activity_train) = "activity"
colnames(activity_test) = "activity"
activities = rbind(activity_train, activity_test)
colnames(activities) = "id"

# Describing activities with their labels
activities = left_join(activities, activity_labels, by = "id")

# Preparing the Dataset ####
dataset = cbind(subjects, activities)
dataset = dataset %>% select(subject, activity)
colnames(dataset) = c("subject", "activity")

# Features ####
# I need to note that I removed the commas from the features.txt file as 
# I couldn't separate the features having them
features = read.csv("./data/features.txt", header = FALSE)
features = features %>% separate(V1, c("Index", "Feature"), sep = " ")
features = features %>% select(Feature)
features_vector = features$Feature
features_vector[1:3]

# Merging Training & Testing Data ####
training = read.csv("./data/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
testing = read.csv("./data/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
sensor_data = rbind(training, testing)
colnames(sensor_data) = "readings"

# Splitting the readings into multiple columns ####
data = sensor_data[1:10299, 1]
data_split = str_split(data, " ") # split by space
data_numbers = lapply(data_split, as.numeric) # convert to numeric to remove the exponential/string
data_numbers = lapply(data_numbers, function(x) x[!is.na(x)]) # removing nulls
data_df = as.data.frame(data_numbers) # converting to data frame
data_transposed = as.data.frame(t(data_df)) # transposing to get it to the right shape
colnames(data_transposed) = features_vector # column names = features (descriptive)
rownames(data_transposed) = seq(1:10299) # renaming rows to indices

# Getting the mean & std columns ####
target = c("mean", "std")
grepl(paste(target, collapse = "|"), features_vector) # filtering those that contain "mean" or "std"
colnumbers = grep(paste(target, collapse = "|"), features_vector)
data_final = data_transposed[,colnumbers] # measurements on mean & std deviation
dataset = cbind(dataset, data_final)
View(head(dataset))

# Final tidy dataset consisting of the  average of each variable
# for each subject/activity ####
averages = dataset %>% group_by(activity, subject) %>% summarise_each(funs(mean)) # 180 combinations
write.table(averages, "./data/averages.txt", row.names = FALSE)












