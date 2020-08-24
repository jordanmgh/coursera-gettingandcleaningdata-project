#### HAR Dataset Analysis Project Script  ####

##Created:    8/10/2020
##Creatd by:  Jordan Hyam
##Purpose:    reconstitute and summarize HAR dataset

## Load stringr package to make string manipulation easier ##
library(stringr)

## set base directory for input, feature name, and output files, add backslash so it can be used to build a path ##
base_dir <- paste(getwd(),"/",sep="")

## read in feature names for test, train files ##
df_features<- read.table(paste(base_dir, "features.txt", sep=""),header = FALSE)

#### SECTION 1: clean up feature names, based on tidy dataset definition (at least as I understand it) #####
##remove () from some features
df_features[,2] <- str_replace_all(df_features[,2],"\\(\\)","")
##replace individual parentheses and other special characters with underscore (which seems to be generally acceptable)
df_features[,2] <- str_replace_all(df_features[,2],"\\(","_")
df_features[,2] <- str_replace_all(df_features[,2],"\\)","_")
df_features[,2] <- str_replace_all(df_features[,2],"\\-","_")
df_features[,2] <- str_replace_all(df_features[,2],"\\,","")
df_features[,2] <- gsub("_$","",df_features[,2])
##make everything lowercase
df_features[,2] <- str_to_lower(df_features[,2])
##replace duplicates 
df_features[,2] <- str_replace_all(df_features[,2],"bodybody","body")
##replace t with time, f with freq
df_features[,2] <- gsub("^t","time_",df_features[,2])
df_features[,2] <- gsub("^f","freq_",df_features[,2])

#### SECTION 2: read in test + train data, label and subject ID files along with activity name file ####

## load test data and name feature variables, then load labels, subject IDs ##
df_test <- read.table(paste(base_dir,"test/X_test.txt",sep=""),header = FALSE)
colnames(df_test) <- as.vector(df_features[,2],mode="character")
df_test_label <- read.table(paste(base_dir,"test/y_test.txt",sep=""),header = FALSE)
df_test_subject <- read.table(paste(base_dir,"test/subject_test.txt",sep=""),header = FALSE)

## Load train data and name feature variables, then load labels and subject IDs##
df_train <- read.table(paste(base_dir,"train/X_train.txt",sep=""),header = FALSE)
colnames(df_train) <- as.vector(df_features[,2],mode="character")
df_train_label <- read.table(paste(base_dir,"train/y_train.txt",sep=""),header = FALSE)
df_train_subject <- read.table(paste(base_dir,"train/subject_train.txt",sep=""),header = FALSE)

##get activity labels
df_activity_labels <- read.table(paste(base_dir,"activity_labels.txt",sep=""),header = FALSE)
colnames(df_activity_labels)=c("activityid","activitylabel")


#### SECTION 3: Vertically merge test and train datasets, labels, and subjects to get combo dataset ####
df_combo <- rbind(df_test,df_train)
df_combo_label <- rbind(df_test_label,df_train_label)
df_combo_subject <- rbind(df_test_subject,df_train_subject)
df_combo <- cbind(df_combo_subject, df_combo_label, df_combo)


#### SECTION 4: Apply column names from feature list, then throw out features other than "...mean..." and "...std..." ####
colnames(df_combo) <- c("subject", "activityid", as.vector(df_features[,2],mode="character"))
df_combo <- df_combo[,grep("+mean|+std|+activityid|+subject",colnames(df_combo))]
df_combo <- merge(df_combo,df_activity_labels,by="activityid",all.x = TRUE)

#### SECTION 5: Finally use dplyr to summarize, then write to file
library(dplyr)
library(data.table)

dt_combo <- setDT(df_combo)
  
##summarize(df_combo,c("activityid","subject","activitylabel"),function(fld){if(class(fld)=="numeric"){mean(fld)}else{}})
df_final <- as.data.frame(df_combo %>% group_by(subject,activityid,activitylabel) %>%summarize_all(mean))

## write or print out sample of results ##
write.table(df_final,file=paste(base_dir,"dataset_summary.txt"),row.names=FALSE)










