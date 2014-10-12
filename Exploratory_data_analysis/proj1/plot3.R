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

## Plot3
with(data, { plot(data$Sub_metering_1 ~ data$datetime, type = "l",
                  ylab = "Energy sub metering", xlab = "")
             lines(data$Sub_metering_2 ~ data$datetime, col = "red")
             lines(data$Sub_metering_3 ~ data$datetime, col = "blue")
}
)
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"), lty = 1, lwd = 1)

## Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()