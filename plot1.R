# Coursera Course #: exdata-008
# Author: apetkova

plot_hist <- function(){
        
        #---------Downloading & Reading Date---------------------------------
        library(lubridate)
        
        if(!file.exists("data"))
                dir.create("data")
        
        
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "./data/exdata-data-household_power_consumption.zip")
        unzip("./data/exdata-data-household_power_consumption.zip")
        
        # Load data into a data frame and assign labels to variables
        data <- read.table(pipe('grep "^[1-2]/2/2007" "./data/household_power_consumption.txt"'), sep = ";")
        names(data) <- c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2", "submetering3")
        
        # Convert the date column to the "Date" format
        data$date <- as.Date(data$date, format="%d/%m/%Y")
        # Combine the date and time columns into a single column
        date_time <- paste(data$date, data$time)
        
        # Convert the merget data to the POSIXlt format
        converted <- strptime(date_time, "%Y-%m-%d %H:%M:%S")
        
        # Delete the date and time columns and add converted time data as a column
        data <- subset(data, select = -c(date,time) )
        data$datetime <- converted
        
        
        #--------------PLOTTING-------------------
        # Generate the histogram
        hist(data$globalactivepower, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red", bg="transparent")

        # Copy to a PNG device
        dev.copy(png, file="./data/plot1.png", width = 480, height = 480)
        dev.off()       # close the device
}

