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

###### Plot 1
png("Plot 1.png", width =480 , height = 480)
hist(February$Global_active_power, col = "red", main="Global active power",
     xlab = "Global active power (kilowatts)")
dev.off()
