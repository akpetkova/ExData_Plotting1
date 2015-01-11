# Author: apetkova

plot_line2 <- function(){
        
        #---------Downloading & Reading Date---------------------------------
        library(lubridate)
        
#         if(!file.exists("data"))
#                 dir.create("data")
#         
#         
#         fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#         download.file(fileUrl, destfile = "./data/exdata-data-household_power_consumption.zip")
#         unzip("./data/exdata-data-household_power_consumption.zip")
#         
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
        # Generate the plot and copy to a PNG device
        png(filename="./data/plot3.png", width = 480, height = 480, units="px", bg="transparent")
        plot(data$datetime, data$submetering1, type="l", ylab = "Energy sub metering", xlab = "", col="black")
        lines(data$datetime, data$submetering2, type="l", xlab = "", col="red")
        lines(data$datetime, data$submetering3, type="l", xlab = "", col="blue")
        legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
        par(bg="transparent")  
           
        dev.off()       # close the device
}
