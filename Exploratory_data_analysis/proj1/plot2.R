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

## Plot2
plot(data$Global_active_power ~ data$datetime, type = "l", 
     ylab = "Global Active Power (Kilowatts)")

## Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()