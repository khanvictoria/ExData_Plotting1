#######################################################################
#### Identifying column classes, finding the indices for the rows 
#### that correspond to relevant dates and loading the subset of data of 
#### electricity consumption during Feb 1 and 2 2007
#######################################################################
path = "./exdata_data_household_power_consumption/household_power_consumption.txt"
sapply(read.table(path, header = T,sep = ";", nrows = 5), class) -> classes
read.table(path, header = T,sep = ";", colClasses = c("factor", rep("NULL", 8))) -> Data 
Data %>% filter(Date == "1/2/2007" | Date =="2/2/2007") %>% nrow() -> nrow
skip_start = min(grep("^1/2/2007", Data$Date))
read.table(path, sep=";", colClasses = classes, col.names = names(classes), 
           skip = skip_start, nrows = nrow) -> February

###### Converting Date to date format using as.Date()
February$Date=as.Date(February$Date, "%d/%m/%Y")

#### Plot 4
png("Plot 4.png", width=480, height=480)
par(mfrow=c(2,2))
plot(February$Global_active_power, type="l", 
     ylab = "Global Active Power", xlab = "", xaxt="n")
axis(1, at= c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

plot(February$Voltage, type="l", 
     ylab = "Voltage", xlab = "datetime", 
     xaxt = "n")
axis(1, at= c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

plot(February$Sub_metering_1, ylab= "Energy sub metering", type = "l", 
     xaxt = "n", xlab = " ")
lines(February$Sub_metering_2, col = "red", type="l")
lines(February$Sub_metering_3, col="blue", type="l")
axis(1, at= c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty = 1,cex=0.8,
       x.intersp = 0.9, y.intersp = 1, text.width = 1000)

plot(February$Global_reactive_power, type="l", 
     ylab = "Global reactive power", xaxt="n", xlab = "datetime")
axis(1, at= c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))

dev.off()
