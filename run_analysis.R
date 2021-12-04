run_analysis <- function(folder, opt = "test"){
  
  ## Extract Data from the fi
  merge_data(folder) %>%
  
    ## Make column Names More Friendly
    descriptive_variable_names() -> Data
  
  
  ## Group the Data according to subject and activity and then find mean of eachg column 
  group_by(Data, subject, activityname) %>%
    summarise_if(is.numeric, mean) -> SummaryTable
  
  return(SummaryTable)
  
  
}



extract_data <- function(folder, opt = "test"){
  
  ## Take the input folder and find the sub directories
  list.dirs(folder) -> subfolders
  
  ## Create regex to select correct folder
  regex <- paste(opt,"$", sep = "")
  
  ##Find the test or train folders
  newdir <- subfolders[grep(regex, subfolders)]
  
  ## Read the main data
  filename <- create_filename("X_", opt, di = newdir)
  Data <- read.table(filename)
  
  
  ## Open features file and extract features
  filename <- paste(folder,"features.txt", sep = "/")
  features <- read.table(filename)[["V2"]] # only interested in second column
  
  ##Open the Activities file and extract activities
  
  
  ## Rename the columns
  colnames(Data) <- features
  
  
  ## Extract Data where column name is either std or mean.
  Data <- Data[grep("std|mean", names(Data))]
  
  
  ## Add the subject to the table
  filename <- create_filename("subject_", opt, di = newdir)
  #print(filename)
  Subjects <- read.table(filename, col.names = "subject")
  
  
  ## Add activities to the table
  filename <- create_filename("y_", opt, di = newdir)
  Activites <- read.table(filename, col.names = "activity")
  
  
  ##Open the Activity names file and extract activity names
  filename <- paste(folder,"activity_labels.txt", sep = "/")
  ActNames <-read.table(filename)[["V2"]]
  
  
  Activites <- mutate(Activites, activityname = ActNames[Activites$activity])
  
  
  ## Combine all the data
  Data <- bind_cols(Data, Subjects, Activites)
  
}


merge_data <- function(folder){
  
  # Merge the test and train data
  D1 <- extract_data(folder, "test")
  D2 <- extract_data(folder, "train")
  
  Data <- bind_rows(D1, D2)
  
}

create_filename <- function(pre, opt, suf = ".txt", di = NA){
  ## Used to create filenames for opening
  Name <- paste(pre, opt, suf, sep = "")
  
  if(!is.na(di)){
    
    Name <- paste(di, Name, sep = "/")
  }
  
  return(Name)
}

descriptive_variable_names <- function(Data){
  ## Expands Variable names to make them more descriptive
  regex = c("^t", "^f", "Acc", "Gyro", "std")
  replacement = c("Time", "Frequency", "Accelerometer","Gyroscope", "StandardDeviation")
  
  for(i in 1:length(regex)){
    #print(regex[i])
    names(Data) <- gsub(regex[i], replacement[i], names(Data))
  }
  return(Data)
}

