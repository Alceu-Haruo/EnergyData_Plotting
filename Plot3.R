##Exploratory analysis - assignment week 1
library(lubridate)
library(dplyr)


##download and unzip the data
setwd("D:/Coursera/EnergyData_Plotting")
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "energydata.zip")
unzip("energydata.zip")

##load the dataset
energydatafull <- read.table("household_power_consumption.txt", sep = ";", header = T)

##filter the dataset for days 2007-02-01 and 2007-02-02; create a single column with date and time
energydata <- energydatafull %>% 
    filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
    mutate(DateTimeTxt = paste(Date, Time, sep = " "), DateTime = dmy_hms(DateTimeTxt)) %>%
    mutate(Global_active_power = as.numeric(Global_active_power), 
           Global_reactive_power = as.numeric(Global_reactive_power), 
           Voltage = as.numeric(Voltage), 
           Global_intensity = as.numeric(Global_intensity), 
           Sub_metering_1 = as.numeric(Sub_metering_1),
           Sub_metering_2 = as.numeric(Sub_metering_2),        
           Sub_metering_3 = as.numeric(Sub_metering_3))        


##Plot 3 - Sub_metering by DateTime
png(filename = "Plot3.png", width = 480, height = 480)
plot(energydata$DateTime, energydata$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab = "Datetime") 
lines(energydata$DateTime, energydata$Sub_metering_2, type = "l", col = "red")
lines(energydata$DateTime, energydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = 19, col = c("black", "red", "blue")  , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()