# Get and set my working directory:
getwd()
setwd("C:\\Users\\masantos\\Desktop\\R\\curso4")


# Download the Dataset: Electric power consumption

fileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileURL,".\\EPC_Dataset")

List_files <- unz(".\\EPC_Dataset","household_power_consumption.txt") # Unzip file


# Read data with date between 2007-02-01 and 2007-02-02

data <- read.table(text = grep("^[1,2]/2/2007", readLines(List_files), value = TRUE), 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
                                 "Voltage", "Global_intensity", "Sub_metering_1",
                                 "Sub_metering_2", "Sub_metering_3"), sep = ";", 
                   header = FALSE, na.strings = "?")


# Checking for NA values:

summary(data)

# There are no NA values so there is no need to subset the missing values: data <- data[complete.cases(data),]


# Creating a column with the data and time:

data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")


# Changing my system local to English because the plot legent (X's) comes in portuguese:

## preserve the existing locale
my_locale <- Sys.getlocale("LC_ALL")

## change locale to English
Sys.setlocale("LC_ALL", "English")


# Create plot 3


png(file = "plot3.png", width = 480, height = 480, units = "px") ## Open PNG device; create "plot3.png" in my working directory
with (data, {
  plot(Datetime, Sub_metering_1, type = "l", ylab = "Global Active Power (kilowatts)", 
       xlab = "")
  lines(Datetime, Sub_metering_2, col = "red")
  lines(Datetime, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))})

dev.off() ## Close the PNG file device


## restore local
Sys.setlocale("LC_ALL", my_locale)
