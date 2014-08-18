set.seed(1234)
options(stringsAsFactors=TRUE)
training <- read.csv("data/pml-training.csv", header=TRUE)
names(training)
training$X <- NULL
sapply(training, class)
summary(training)

# remove user_name, raw_timestamp_part_1, raw_timestamp_part_2, cvtd_timestamp,
# new_window and num_window attributes.

f_training <- training
f_training$user_name <- NULL
f_training$raw_timestamp_part_1 <- NULL
f_training$raw_timestamp_part_2 <- NULL
f_training$cvtd_timestamp <- NULL
f_training$new_window <- NULL
f_training$num_window <- NULL

# removing columns with NA's values
f_training <- f_training[,colSums(is.na(f_training))==0]
summary(f_training)

# for some reason, there are some attributes that were imported without values
# and as character. In this case, I removed manually each attribute using the commands
# below:

f_training$kurtosis_roll_belt <- NULL
f_training$kurtosis_picth_belt <- NULL
f_training$kurtosis_yaw_belt <- NULL
f_training$skewness_roll_belt <- NULL
f_training$skewness_roll_belt.1 <- NULL
f_training$skewness_yaw_belt <- NULL
f_training$max_yaw_belt <- NULL
f_training$min_yaw_belt <- NULL
f_training$amplitude_yaw_belt <- NULL
f_training$kurtosis_roll_arm <- NULL
f_training$kurtosis_picth_arm <- NULL
f_training$kurtosis_yaw_arm <- NULL
f_training$skewness_roll_arm <- NULL
f_training$skewness_pitch_arm <- NULL
f_training$skewness_yaw_arm <- NULL
f_training$kurtosis_roll_dumbbell <- NULL
f_training$kurtosis_picth_dumbbell <- NULL
f_training$kurtosis_yaw_dumbbell <- NULL
f_training$skewness_roll_dumbbell <- NULL
f_training$skewness_pitch_dumbbell <- NULL
f_training$skewness_yaw_dumbbell <- NULL
f_training$max_yaw_dumbbell <- NULL
f_training$min_yaw_dumbbell <- NULL
f_training$amplitude_yaw_dumbbell <- NULL
f_training$kurtosis_roll_forearm <- NULL
f_training$kurtosis_picth_forearm <- NULL
f_training$kurtosis_yaw_forearm <- NULL
f_training$skewness_roll_forearm <- NULL
f_training$skewness_pitch_forearm <- NULL
f_training$skewness_yaw_forearm <- NULL
f_training$max_yaw_forearm <- NULL
f_training$min_yaw_forearm <- NULL
f_training$amplitude_yaw_forearm <- NULL

# The model will be build using Random Forest Algorithm.

library(randomForest)
model <- randomForest(classe ~ ., data=f_training, importance=TRUE, do.trace=100)

# The results with the training dataset are:

model
plot(model)
varImpPlot(model)
save(model, file="data/model.Rda")

# The results with the test dataset are:

testing <- read.csv("data/pml-testing.csv", header=TRUE)
testPred <- predict(model, newdata=testing)
testPred
