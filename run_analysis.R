library(plyr)

# Step 1
# Read abd Merge the training and test data Set to create one Set

x_Train <-read.table('train/x_train.txt',header=FALSE); 
y_Train  <- read.table('train/y_train.txt',header=FALSE); 
subject_train <- read.table("train/subject_train.txt",header=FALSE);
features     <- read.table('features.txt',header=FALSE);
activityType <- read.table('activity_labels.txt',header=FALSE);

#Step 2 Import test data

subjectTest <- read.table('test/subject_test.txt',header=FALSE); 
x_Test       <- read.table('test/x_test.txt',header=FALSE); 
y_Test       <- read.table('test/y_test.txt',header=FALSE);

#Step 3 Merge training and test data to create on data set

training_data <- cbind(cbind(x_Train, subject_train), y_Train);
test_data <- cbind(cbind(x_Test, subjectTest), y_Test)
sensor_data <- rbind(training_data, test_data)
names(sensor_data)<-rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]

#Step 4 Extract the measurement for mean and standard deviation for each measurement
sensor_data_final <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]
sensor_data_final <- sensor_data_final[,-1]


finalData = merge(sensor_data_final,activityType,by='activityId',all.x=TRUE);

#Step 4 correct the improve the column names of the final data
names(sensor_data_final) <- gsub('\\(|\\)',"",names(sensor_data_final), perl = TRUE)
names(sensor_data_final) <- make.names(names(sensor_data_final))
names(sensor_data_final) <- gsub('GyroJerk',"AngAcceleration",names(sensor_data_final))
names(sensor_data_final) <- gsub('Acc',"Acceleration",names(sensor_data_final))
names(sensor_data_mean_std) <- gsub('Gyro',"AnguSpeed",names(sensor_data_final))
names(sensor_data_final) <- gsub('Mag',"Magnitude",names(sensor_data_final))
names(sensor_data_final) <- gsub('^t',"Time_Dom",names(sensor_data_final))
names(sensor_data_final) <- gsub('^f',"Frequency_Dom",names(sensor_data_final))
names(sensor_data_final) <- gsub('\\.mean',".Mean",names(sensor_data_final))
names(sensor_data_final) <- gsub('\\.std',".Standard_Deviation",names(sensor_data_final))
names(sensor_data_final) <- gsub('Freq\\.',"Frequency.",names(sensor_data_final))
names(sensor_data_final) <- gsub('Freq$',"Frequency",names(sensor_data_final))

#Step 4 Write to a clean file

Clean_Data_File<-ddply(sensor_data_final, c("Subject","Activity"), numcolwise(mean))
write.table(Clean_Data_File, file = "Clean_data.txt")
