###PLOT 1

##histogram
hist(trial_1$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save file and close device
#dev.copy(png,"trial_1.png", width=480, height=480)
#dev.off()