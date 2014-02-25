library(dplyr)
library(tidyverse)
period          <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))
names(period)   <- c("Date", "Time", "GlobalActivePower","GlobalReactivePower","Voltage","Intensity", "SubMetering1", "SubMetering2","SubMetering3")
period          <- mutate(period, DateTime=paste(Date,Time))
period$DateTime <- strptime(period$DateTime, format='%d/%m/%Y  %H:%M:%S')
period$DateTime <- as.POSIXct(period$DateTime)
my_period <- as_tibble(period)
my_period <- my_period %>% filter(Date %in% c("1/2/2007","2/2/2007"))

png("plot4.png", width = 480, height = 480, res = 72)
par(mfrow=c(2,2))

## 1st plot
plot(my_period$DateTime, my_period$GlobalActivePower, 
     type = "l", ylab = "Global Active Power", 
     xlab = "Date Time")

## 2nd plot
plot(my_period$DateTime, my_period$Voltage, 
     type = "l", ylab = "Voltage", 
     xlab = "Date Time")


## 3rd plot
plot(my_period$DateTime, my_period$SubMetering1, 
     type = "l", ylab = "Energy sub metering", 
     xlab = "Date Time")
lines(my_period$DateTime, my_period$SubMetering2, type='l', col = "red")
lines(my_period$DateTime, my_period$SubMetering3, type='l', col = "blue")
legend("topright", pch = "____" , col = c("black", "red", "blue"), 
       legend = c("Sub metering1", "Sub metering2", "Sub metering3"),
       cex = 0.75)

## 4th plot

plot(my_period$DateTime, my_period$GlobalReactivePower, 
     type = "l", ylab = "Global Reactive Power", 
     xlab = "Date Time")

dev.off()
