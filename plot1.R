# Generates Plot 1 for Exploratory Data Analysis Project 1 Assignment
library(data.table)
 
# download zip file and unzip. Files are written to your current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
if(!file.exists("household_power_consumption.txt")) {
        download.file(fileUrl, destfile= "household_power_consumption.zip", method="curl")
        unzip("household_power_consumption.zip","household_power_consumption.txt", overwrite=TRUE)
        unlink("household_power_consumption.zip")  # deletes the zip file
}

#  quick read to create column names
initial <- read.table("household_power_consumption.txt", nrows = 5, sep=";",
                      stringsAsFactors=FALSE,header=TRUE)
names <- colnames(initial) # vector for col.names

hpc <- fread(input= "household_power_consumption.txt", 
             na.strings="?", skip="1/2/2007",nrows=2880,
             colClasses=c("character","character","numeric",
                          "numeric","numeric","numeric","numeric",
                          "numeric","numeric"))
setnames(hpc,names) 
 
# Plot 1

png("plot1.png", width=480, height=480, units ="px" )
hist(hpc$Global_active_power,col="Red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()

