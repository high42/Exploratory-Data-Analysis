#import libraries
library(readr)
library(dplyr)

#Check if directory exists and creates it it's missing
if(!file.exists("./data")){
  dir.create("./data")
}

#download dataFile
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFileName <- "./data/electric_power_comsumption.zip"
download.file(fileURL,  destfile = destFileName, method="curl")

#extract zip file
unzip(zipfile = destFileName, 
      list = FALSE,
      overwrite = TRUE,
      exdir = "./data")

readFileName <- "./data/household_power_consumption.txt"
myData <- read_delim(readFileName, ";", col_names = TRUE)
myData <- tbl_df(myData)
myData <- myData %>%
            filter(Date == "1/2/2007" | 
                   Date == "2/2/2007") %>%
            mutate(Date = as.POSIXct(paste(Date, Time), format =  "%d/%m/%Y %H:%M:%S")) %>%
            mutate(Global_active_power = as.numeric(Global_active_power))

#Plot1
png("plot1.png", width=480, height=480)
hist(myData$Global_active_power,
     main= "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")
dev.off()

#Plot2
png("plot2.png", width=480, height=480)
plot(x = myData$Date,
     y = myData$Global_active_power,
     type = "l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.off()

#Plot3
png("plot3.png", width=480, height=480)
plot(x = myData$Date, 
     y = myData$Sub_metering_1, 
     type="l",
     xlab="",
     ylab="Energy sub metering")

lines(x = myData$Date, 
      y = myData$Sub_metering_2,
      col="red")

lines(x = myData$Date, 
      y = myData$Sub_metering_3,
      col = "blue")

legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"),
       lty =c(1,1),
       lwd =c(1,1))
 dev.off()
 
 #Plot4
 
 png("plot4.png", width=480, height=480)
 par(mfrow=c(2,2))
 #A
 with(myData,
      plot(Date, Global_active_power, type = "l", xlab="", ylab="Global Active Power")
      )
 #B
 with(myData,
      plot(Date, Voltage, type = "l", xlab="datetime", ylab="Voltage")
 )
 #C
 plot(x = myData$Date, 
      y = myData$Sub_metering_1, 
      type="l",
      xlab="",
      ylab="Energy sub metering")
 
 lines(x = myData$Date, 
       y = myData$Sub_metering_2,
       col="red")
 
 lines(x = myData$Date, 
       y = myData$Sub_metering_3,
       col = "blue")
 
 legend("topright",
        col = c("black", "red", "blue"),
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_1"),
        lty =c(1,1),
        lwd =c(1,1))
 #D
 with(myData,
      plot(Date, Global_reactive_power, type = "l", xlab="datetime", ylab="Global Reactive Power")
 )
 dev.off()
 
