# Plots the first plot in the exercise
# 
# Author: Tejaswi Redkar
###############################################################################

#Start clean by deleting all the environment variables
rm(list=ls(all=TRUE)) 
# Set the working directory to where the R file is and where the download and output files will be located.
setwd("/Users/Tej/Documents/ExData_Plotting1")
#Load the routine that was created to download the data
source("downloaddata.R")

plot1 <- paste(getwd(), "/charts/plot1.png", sep = "")
if(!file.exists(plot1)){
  #load the PNG device
	png("charts/plot1.png", width = 480, height = 480)
  #Build a histogram 
	hist(electricpowerds$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
	dev.off()
	print(paste("Created chart ", plot1, sep=""))
} else {
  print("Chart already exists in the folder, so loading on the default device.")
	hist(electricpowerds$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")
}


