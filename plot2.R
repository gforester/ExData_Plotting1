
# Generates Plot 2 for Exploratory Data Analysis Project 1 Assignment
library(data.table)
library(lubridate)

# Download and read in file -----------------------------------------------

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
# add colunm names and change date and time fields to R date-time classes
setnames(hpc,names) 
hpc$DateTime <- dmy_hms(paste(hpc$Date, hpc$Time))
 
# Create Plot -------------------------------------------------------------       
# Plot 2
png("plot2.png", width=480, height=480, units ="px" ) 
plot(Global_active_power ~ DateTime, data=hpc, type="n", xlab="",
     ylab="Global Active Power (kilowatts)")
lines(Global_active_power ~ DateTime, data=hpc, col="black")
dev.off()



