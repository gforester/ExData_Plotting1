# Generates Plot 1 for Exploratory Data Analysis Project 1 Assignment
 
# download zip file and unzip. Files are written to your current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
if(!file.exists("household_power_consumption.txt")) {
        download.file(fileUrl, destfile= "household_power_consumption.zip", method="curl")
        unzip("household_power_consumption.zip","household_power_consumption.txt", overwrite=TRUE)
        unlink("household_power_consumption.zip")  # deletes the zip file
}

# read initial 100 rows to determine column class
initial <- read.table("household_power_consumption.txt", nrows = 100, sep=";",
                      stringsAsFactors=FALSE,header=TRUE)
classes <- sapply(initial, class)
names <- colnames(initial) # vector for col.names in read.table

# determine skip and nrow parameters for read.table
timeframe=grep("(^1/2/2007)|(^2/2/2007)", readLines("household_power_consumption.txt"))

hpc <- read.table(file="household_power_consumption.txt",
                  colClasses=classes, header=FALSE, sep=";", 
                  na.string="?", stringsAsFactors=FALSE, col.names=names,
                  ,skip=min(timeframe),nrows=max(timeframe)-min(timeframe)+1)
 
# Plot 1

png("plot1.png", width=480, height=480, units ="px" )
hist(hpc$Global_active_power,col="Red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()

