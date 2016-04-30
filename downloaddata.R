# This files consists of code for downloading the electric power consumtion dataset from 
# UC Irvine Machine Learning Repository
# Electric power consumption: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# 
# Author: Tejaswi Redkar
###############################################################################

#Start clean by deleting all the environment variables
rm(list=ls(all=TRUE)) 
# Set the working directory to where the R file is and where the download and output files will be located.
setwd("/Users/Tej/Documents/ExData_Plotting1")

library(httr) 
#Url of the dataset
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#Folder name where the file will ne downloaded to
downloadfolder <- "dataset"
if(!file.exists(downloadfolder)){
  print(paste("Creating folder ", downloadfolder, sep=""))
	dir.create(downloadfolder)
} else
{
  print(paste("Folder ", downloadfolder, " already exists. Please delete.", sep=""))
}
#Folder name where charts will be saved
charts <- "charts" 
if(!file.exists(charts)){
  print(paste("Creating folder ", charts, sep=""))
	dir.create(charts)
}else
{
  print(paste("Folder ", charts, " already exists. Please delete.", sep=""))
}
#Name of the file after downloading
downloadarchive <- paste(getwd(), paste("/", downloadfolder, "/household_power_consumption.zip", sep = ""), sep="")
if(!file.exists(downloadarchive)){
  print("Downloading file...")
	download.file(url, downloadarchive, method="curl", mode="wb")
	print("Download complete.")
}else
{
  print(paste("File ", downloadarchive, " already exists. Please delete.", sep=""))
}

downloadfilename <- paste(getwd(), paste("/", downloadfolder, "/household_power_consumption.txt", sep=""), sep = "")
if(!file.exists(downloadfilename)){
  #unzip the archive
  print("Extracting archive...")
	unzip(downloadarchive, list = FALSE, overwrite = FALSE, exdir = downloadfolder)
	print("Extraction complete.")
}else
{
  print(paste("File ", downloadfilename, " already exists. Please delete to extract the archive.", sep=""))
}

#load the data and save a serialized copy in the form of RDS dataset
serializeddataset <- paste(getwd(), paste("/", downloadfolder,"/serializeddataset.rds", sep=""), sep = "")
if(!file.exists(serializeddataset)){
  
	dataset <- paste(downloadfolder, "/household_power_consumption.txt", sep="")
	print(paste("Reading file ", dataset, sep=""))
	electricpowerds <- read.table(dataset, header=TRUE, sep=";", colClasses=c("character", "character", rep("numeric",7)), na="?")
	electricpowerds$Time <- strptime(paste(electricpowerds$Date, electricpowerds$Time), "%d/%m/%Y %H:%M:%S")
	electricpowerds$Date <- as.Date(electricpowerds$Date, "%d/%m/%Y")
	dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
	electricpowerds <- subset(electricpowerds, Date %in% dates)
	serializeddataset <- paste(getwd(), "/", downloadfolder, "/", "serializeddataset", ".rds", sep="")
	print(paste("Saving serialized file ", serializeddataset, sep=""))
	saveRDS(electricpowerds, serializeddataset)
	print(paste("Saved ", serializeddataset, sep=""))
} else {
  print("Serialized dataset already exists. So reading...")
	dataset <- paste(downloadfolder,"/serializeddataset.rds", sep="")
	electricpowerds <- readRDS(dataset)
	print("Read successful.")
}

