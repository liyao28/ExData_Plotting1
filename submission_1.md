trial_1 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Formatting date to Type Date
trial_1$Date <- as.Date(trial_1$Date, "%d/%m/%Y")

## Set date filter from Feb. 1, 2007 to Feb. 2, 2007
trial_1 <- subset(trial_1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete
trial_1 <- trial_1[complete.cases(trial_1),]

## Combine Date and Time
dateTime <- paste(trial_1$Date, trial_1$Time)
 
## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time
trial_1 <- trial_1[ ,!(names(trial_1) %in% c("Date","Time"))]

## Add DateTime column
trial_1 <- cbind(dateTime, trial_1)

## Format dateTime Column
trial_1$dateTime <- as.POSIXct(dateTime)

###PLOT 1

##histogram
hist(trial_1$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
#dev.copy(png,"trial_1.png", width=480, height=480)
#dev.off()

## Plot 2
plot(trial_1$Global_active_power~trial_1$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

#dev.copy(png,"graph2.png", width=480, height=480)
#dev.off()

## 3
with(trial_1, {
          plot(Sub_metering_1~dateTime, type="l",
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~dateTime,col='Red')
     lines(Sub_metering_3~dateTime,col='Blue')
 })
 legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
#dev.copy(png, file="plot3.png", height=480, width=480)
#dev.off()

## Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(trial_1, {
     plot(Global_active_power~dateTime, type="l", 
          ylab="Global Active Power (kilowatts)", xlab="")
     plot(Voltage~dateTime, type="l", 
          ylab="Voltage (volt)", xlab="")
     plot(Sub_metering_1~dateTime, type="l", 
          ylab="Global Active Power (kilowatts)", xlab="")
     lines(Sub_metering_2~dateTime,col='Red')
     lines(Sub_metering_3~dateTime,col='Blue')
     legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
            legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power~dateTime, type="l", 
          ylab="Global Rective Power (kilowatts)",xlab="")
 })

## Saving to file
#dev.copy(png, file="plot4.png", height=480, width=480)
#dev.off()