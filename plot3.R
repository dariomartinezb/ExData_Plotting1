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

# Creating the third plot in screen, so I can verify it works.
# This is a tricky plot as it needs three lines. I had to understand how
# the 'with()' function works to make it happen. Basically, I need to plot
# the first line as usual, and then add the second and third lines using
# the 'lines()' function. Finally, the legend as added to the topright
# corner in a separate command using 'legend()'. Note that the y-axis label
# and the nulled x-axis label need to be added in the 'plot()' function as 
# parameters of the plot.
with(dataset, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# As everything looks good, I now open the PNG graphic device
png(filename = "plot3.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

# ...and just repeat the plot() command to save the line chart as a PNG image.
with(dataset, {
  plot(Sub_metering_1 ~ Datetime, type = "l", 
       ylab = "Global Active Power (kilowatts)", xlab = "")
  lines(Sub_metering_2 ~ Datetime, col = 'Red')
  lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Finally, I need to close the PNG graphic device, using dev.off().
dev.off()
