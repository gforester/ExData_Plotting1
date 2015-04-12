# Generates Plot 4 for Exploratory Data Analysis Project 1 Assignment

 

# Download and read in file -----------------------------------------------

# download zip file and unzip. Files are written to your current working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
if(!file.exists("household_power_consumption.txt")) {
        download.file(fileUrl, destfile= "household_power_consumption.zip", method="curl")
        unzip("household_power_consumption.zip","household_power_consumption.txt", overwrite=TRUE)
        unlink("household_power_consumption.zip")  # deletes the zip file
}

# read initial 100 rows to determine column class
initial <- read.table("household_power_consumption.txt", nrows = 50, sep=";",
                      stringsAsFactors=FALSE,header=TRUE)
classes <- sapply(initial, class)
names <- colnames(initial) # vector for col.names in read.table

# determine skip and nrow parameters for read.table
timeframe <- grep("(^1/2/2007)|(^2/2/2007)", readLines("household_power_consumption.txt"))

hpc <- read.table(file="household_power_consumption.txt",
                  colClasses=classes, header=FALSE, sep=";", 
                  na.string="?", stringsAsFactors=FALSE, col.names=names,
                  ,skip=min(timeframe),nrows=max(timeframe)-min(timeframe)+1)
hpc$DateTime <- paste(hpc$Date, hpc$Time)
 
hpc$DateTime <- strptime(hpc$DateTime, "%d/%m/%Y %H:%M:%S")


# Create Plot -------------------------------------------------------------


#Plot 4

png("plot4.png", width=480, height=480, units ="px" ) 
par(mfrow = c(2,2))

plot(Global_active_power ~ as.POSIXct(DateTime), data=hpc, type="n", xlab="",
     ylab="Global Active Power")
lines(Global_active_power ~ as.POSIXct(DateTime), data=hpc, col="black")

plot(Voltage ~ as.POSIXct(DateTime), data=hpc, type="n", xlab="datetime", ylab="Voltage")
lines(Voltage ~ as.POSIXct(DateTime), data=hpc, col="black")

plot(Sub_metering_1 ~ as.POSIXct(DateTime), data = hpc, type="n", ylab="Energy sub metering", xlab="")
lines(Sub_metering_1 ~ as.POSIXct(DateTime), data=hpc, col ="black") 
lines(Sub_metering_2 ~ as.POSIXct(DateTime), data=hpc, col="red")
lines(Sub_metering_3 ~ as.POSIXct(DateTime), data=hpc, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=1,col=c("black","red","blue"), bty="n")

plot(Global_reactive_power ~ as.POSIXct(DateTime), data=hpc, type="n",xlab="datetime")
lines(Global_reactive_power ~ as.POSIXct(DateTime), data=hpc, col="black")
dev.off()
