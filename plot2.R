library(dplyr)
library(tidyverse)
period          <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?", colClasses = c(rep("character",2),rep("numeric",7)))
names(period)   <- c("Date", "Time", "GlobalActivePower","GlobalReactivePower","Voltage","Intensity", "SubMetering1", "SubMetering2","SubMetering3")
period          <- mutate(period, DateTime=paste(Date,Time))
period$DateTime <- strptime(period$DateTime, format='%d/%m/%Y  %H:%M:%S')
period$DateTime <- as.POSIXct(period$DateTime)
my_period <- as_tibble(period)
my_period <- my_period %>% filter(Date %in% c("1/2/2007","2/2/2007"))

par(col="black")
png("plot2.png", width = 480, height = 480, res = 72)
plot(my_period$DateTime, my_period$GlobalActivePower, 
     type = "l", ylab = "Global Active Power (kilowatts)",
     xlab = "Date Time")
##dev.copy(png, file="plot2.png")
dev.off()
