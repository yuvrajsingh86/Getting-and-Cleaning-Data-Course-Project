library(plyr)

# Step 1
# Read the training and test data Set to create one Set

#Get Training Data
x_Train <-read.table('train/x_train.txt'); 
y_Train  <- read.table('train/y_train.txt'); 
subject_train <- read.table("train/subject_train.txt");


#Get Test Data
subjectTest <- read.table('test/subject_test.txt'); 
x_Test       <- read.table('test/x_test.txt'); 
y_Test       <- read.table('test/y_test.txt');

#Get Features and activities
features     <- read.table('features.txt', colClasses = c("character") );
activityType <- read.table('activity_labels.txt',col.names = c("Id", "Activity"));

#Step 2 Merge training and test data to create on data set

training_data <- cbind(x_Train, subject_train);
training_data <-cbind(training_data,y_train)

test_data <- cbind(x_Test, subjectTest);
test_data<- cbind(test_data, y_Test)

sensor_data <- rbind(training_data, test_data);
names(sensor_data)<-rbind(rbind(features, c(562, "Subject")), c(563, "Id"))[,2]

#Step 3 Extract the measurement for mean and standard deviation for each measurement
sensor_data_final <- sensor_data[,grepl("mean|std|Subject|ID", names(sensor_data))]

finalData <- join(sensor_data_final, activityType, by = "Id", match = "first");
finalData <- finalData[,-1]


#Step 4 correct the improve the column names of the final data
names(sensor_data_final) <- gsub('\\(|\\)',"",names(sensor_data_final), perl = TRUE)
names(sensor_data_final) <- make.names(names(sensor_data_final))
names(sensor_data_final) <- gsub('GyroJerk',"AngAcceleration",names(sensor_data_final))
names(sensor_data_final) <- gsub('Acc',"Acceleration",names(sensor_data_final))
names(sensor_data_final) <- gsub('Gyro',"AnguSpeed",names(sensor_data_final))
names(sensor_data_final) <- gsub('Mag',"Magnitude",names(sensor_data_final))
names(sensor_data_final) <- gsub('^t',"Time_Dom.",names(sensor_data_final))
names(sensor_data_final) <- gsub('^f',"Frequency_Dom.",names(sensor_data_final))
names(sensor_data_final) <- gsub('\\.mean',".Mean",names(sensor_data_final))
names(sensor_data_final) <- gsub('\\.std',".Standard_Deviation",names(sensor_data_final))
names(sensor_data_final) <- gsub('Freq$',"Frequency.",names(sensor_data_final))


#Step 5 Write to a clean file

Clean_Data_File<-ddply(sensor_data_final, c("Subject","Activity"), numcolwise(mean))
write.table(Clean_Data_File, file = "Clean_data.txt")
