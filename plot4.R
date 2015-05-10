# Exploratory Data Analysis
# COURSE PROJECT 1
# Source to generate plot3.png
# Submitted by  : Darío Martinez Batlle

# Let's read the file subsetting the dates while reading, insted of reading 
# the whole thing into memory. For this, I use grep and a simple regex to filter
# days 1 and 2 of February.

setwd('~/R/data')
datafile <- file("household_power_consumption.txt")
dataset <- read.table(text = grep("^[1,2]/2/2007", readLines(datafile),
           value = TRUE), col.names = c("Date", "Time", "Global_active_power",
           "Global_reactive_power", "Voltage", "Global_intensity",
           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           sep = ";", header = TRUE, na.strings = "?")

# Using as.Date() I convert the textdate into a valid date,
# and create a new variable, 'datetime', to hold the full timestamp.
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
Datetime <- paste(as.Date(dataset$Date), dataset$Time)
dataset$Datetime <- as.POSIXct(Datetime)

# Creating the fourth plot in screen, so I can verify it works.
# For this, I needed to tweak the par() function in order to accomodate
# four plots in the graphic device. The par() function is really handy!
# The first parameter, mfrow() indicates I want 2 plots horizontally and
# 2 plots vertically. mar() sets the "inside margins" for each plot as
# well as oma() sets the external margins of the plots. 
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# Now the four plots. First thing is using the 'with()' command.
with(dataset, {
  # The topleft plot is basically the same of plot2.R, so I copied it here.
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  # The topright plot is new, but a piece of cake.
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  # The bottomright plot is the same of plot3.R, so I copied it here, too
  # (just changing the y-axis label).
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # The bottomright plot is also new, and also a piece of cake.
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

# As everything looks good, I now open the PNG graphic device
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

# ...and just repeat the plot() command to save the line chart as a PNG image.
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dataset, {
  # The topleft plot is basically the same of plot2.R, so I copied it here.
  plot(Global_active_power ~ Datetime, type = "l", 
       ylab = "Global Active Power", xlab = "")
  # The topright plot is new, but a piece of cake.
  plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
  # The bottomright plot is the same of plot3.R, so I copied it here, too
  # (just changing the y-axis label).
  plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  # The bottomright plot is also new, and also a piece of cake.
  plot(Global_reactive_power ~ Datetime, type = "l", 
       ylab = "Global_rective_power", xlab = "datetime")
})

# Finally, I need to close the PNG graphic device, using dev.off().
dev.off()
