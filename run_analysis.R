library(plyr)

# Step 1
# Read the training and test data Set to create one Set

x_Train <-read.table('train/x_train.txt'); 
y_Train  <- read.table('train/y_train.txt'); 
subject_train <- read.table("train/subject_train.txt");
features     <- read.table('features.txt', colClasses = c("character") );
activityType <- read.table('activity_labels.txt',col.names = c("ActivityId", "Activity"));


subjectTest <- read.table('test/subject_test.txt'); 
x_Test       <- read.table('test/x_test.txt'); 
y_Test       <- read.table('test/y_test.txt');

#Step 2 Merge training and test data to create on data set

training_data <- cbind(cbind(x_Train, subject_train), y_Train);
test_data <- cbind(cbind(x_Test, subjectTest), y_Test)
sensor_data <- rbind(training_data, test_data)
names(sensor_data)<-rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]

#Step 3 Extract the measurement for mean and standard deviation for each measurement
sensor_data_final <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]

finalData <- join(sensor_data_final, activityType, by = "ActivityId", match = "first");
finalData <- finalData[,-1]


#Step 4 correct the improve the column names of the final data
names(finalData) <- gsub('\\(|\\)',"",names(finalData), perl = TRUE)
names(finalData) <- make.names(names(finalData))
names(finalData) <- gsub('GyroJerk',"AngAcceleration",names(finalData))
names(finalData) <- gsub('Acc',"Acceleration",names(finalData))
names(finalData) <- gsub('Gyro',"AnguSpeed",names(finalData))
names(finalData) <- gsub('Mag',"Magnitude",names(finalData))
names(finalData) <- gsub('^t',"Time_Dom.",names(finalData))
names(finalData) <- gsub('^f',"Frequency_Dom.",names(finalData))
names(finalData) <- gsub('\\.mean',".Mean",names(finalData))
names(finalData) <- gsub('\\.std',".Standard_Deviation",names(finalData))
names(finalData) <- gsub('Freq\\.',"Frequency.",names(finalData))
names(finalData) <- gsub('Freq$',"Frequency",names(finalData))

#Step 5 Write to a clean file

Clean_Data_File<-ddply(finalData, c("Subject","Activity"), numcolwise(mean))
write.table(Clean_Data_File, file = "Clean_data.txt")
