# Exploratory Data Analysis
# COURSE PROJECT 1
# Source to generate plot1.png
# Submitted by  : Dar�o Martinez Batlle

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

# Using as.Date() I convert the textdate into a valid date.
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")

# Creating the first plot in screen, so I can verify it works.
# First the histogram, where I set the bar colors to red using the 'col' 
# parameter, the title using the 'main' parameter and the x-axis label
# using the 'xlab' parameter.
hist(dataset$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# As everything looks good, I now open the PNG graphic device
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 14,
    bg = "white",  res = NA)

# ...and just repeat the hist() command to save the histogram as a PNG image.
hist(dataset$Global_active_power, col="red", main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

# Finally, I need to close the PNG graphic device, using dev.off().
dev.off()
