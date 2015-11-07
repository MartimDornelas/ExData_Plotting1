
# Get and set my working directory:
getwd()
setwd("C:\\Users\\masantos\\Desktop\\R")

# Read data with date between 2007-02-01 and 2007-02-02

List_files <- unz("exdata_data_household_power_consumption.zip","household_power_consumption.txt")

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

#data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#data$Time <- chron(times = data$Time)

#datatable <- tbl_df(data)
#datatable



# Subset data: date between 2007-02-01 and 2007-02-02
# datatable <- filter(datatable, Date >= "2007-02-01", Date <= "2007-02-02")

# Changing my system local to English because the plot legent (X's) comes in portuguese:

## preserve the existing locale
my_locale <- Sys.getlocale("LC_ALL")

## change locale to English
Sys.setlocale("LC_ALL", "English")


# Create plot 1


variable.names(data)

png(file = "plot1.png", width = 480, height = 480, units = "px") ## Open PNG device; create "plot1.png" in my working directory
plot1 <- hist(data$Global_active_power, col = "red", main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)")
dev.off() ## Close the PNG file device


# Create plot 2


png(file = "plot2.png", width = 480, height = 480, units = "px") ## Open PNG device; create "plot2.png" in my working directory
plot(data$Datetime, data$Global_active_power, type = "l", main = "", 
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off() ## Close the PNG file device


# Create plot 3


png(file = "plot3.png", width = 480, height = 480, units = "px") ## Open PNG device; create "plot3.png" in my working directory
with (data, {
  plot(Datetime, Sub_metering_1, type = "l", ylab = "Global Active Power (kilowatts)", 
       xlab = "")
  lines(Datetime, Sub_metering_2, col = "red")
  lines(Datetime, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))})

legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off() ## Close the PNG file device


# Create plot 4


png(file = "plot4.png", width = 480, height = 480, units = "px") ## Open PNG device; create "plot4.png" in my working directory
par(mfrow = c(2, 2),mar = c(4,4,2,1), oma = c(0,0,2,0))
with(data, {
 plot(data$Datetime, data$Global_active_power, type = "l", main = "", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
 plot(Datetime, Voltage, type = "l", main = "",xlab = "datetime", ylab = "Voltage")
 plot(Datetime, Sub_metering_1, type = "l", ylab = "Global Active Power (kilowatts)", 
      xlab = "")
 lines(Datetime, Sub_metering_2, col = "red")
 lines(Datetime, Sub_metering_3, col = "blue")
 legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n",
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 plot(Datetime, Global_reactive_power, type = "l", main = "",xlab = "datetime", 
      ylab = "Global_reactive_power")
})
dev.off() ## Close the PNG file device


## restore local
Sys.setlocale("LC_ALL", my_locale)

#??bty



png(file = "plot4.png") ## Open PDF device; create 'myplot.pdf' in my working directory
## Create plot and send to a file (no plot appears on screen)
with(faithful, plot(eruptions, waiting))
title(main = "Old Faithful Geyser data") ## Annotate plot; still nothing on screen
dev.off() ## Close the PDF file device
## Now you can view the file 'myplot.pdf' on your computer


# png(filename = "Rplot%03d.png",
#    width = 480, height = 480, units = "px", pointsize = 12,
#    bg = "white",  res = NA, ...,
#    type = c("cairo", "cairo-png", "Xlib", "quartz"), antialias)



## restore locale
Sys.setlocale("LC_ALL", my_locale)
