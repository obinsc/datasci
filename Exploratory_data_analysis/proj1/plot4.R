## installed sqldf package
##install.packages("sqldf")

##open sqldf library
##library(sqldf)

##read data for given date
file <- c("household_power_consumption.txt")
data <- read.csv.sql(file, sql = "select * from file WHERE Date IN ('1/2/2007','2/2/2007')",
                     colClasses = c(rep("character",2),rep("numeric",7)), sep = ";")
##close connection
closeAllConnections()

##concatenated date time
data$datetime <- paste(as.Date(data$Date, format="%d/%m/%Y"), data$Time)
## convert to calendar date time format
data$datetime <- as.POSIXct(data$datetime)

## Plot4
par(mfrow = c(2,2))
with(data, { plot(data$Global_active_power ~ data$datetime, type = "l", 
                  ylab = "Global Active Power (Kilowatts)", xlab = "")
             plot(data$Voltage ~ data$datetime, type = "l", 
                  ylab = "Voltage", xlab = "datetime")
{
                 plot(data$Sub_metering_1 ~ data$datetime, type = "l",
                      ylab = "Energy sub metering", xlab = "")
                 lines(data$Sub_metering_2 ~ data$datetime, col = "red")
                 lines(data$Sub_metering_3 ~ data$datetime, col = "blue")
             }
plot(data$Global_reactive_power ~ data$datetime, type = "l", 
     ylab = "Global Active Power (Kilowatts)", xlab = "datetime")
}
)

## Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()