library("data.table")

setwd("/Users/Dilson/Documents/Cursos/Coursera/Data Science/04_ExploratoryDataAnalysis/")

data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data_sub<-subset(data,data$Date=="1/2/2007" | data$Date == "2/2/2007")

data_sub[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
data_sub[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

png("plot4.png", width=480, height=480)

curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")

par(mfrow=c(2,2))

plot(data_sub[, dateTime], 
     data_sub[, Global_active_power], 
     type="l", 
     xlab="", 
     ylab="Global Active Power")

plot(data_sub[, dateTime],
    data_sub[, Voltage], 
    type="l", 
    xlab="datetime", 
    ylab="Voltage")

plot(data_sub[, dateTime], 
     data_sub[, Sub_metering_1], 
     type="l", 
     xlab="", 
     ylab="Energy sub metering")
     
lines(data_sub[, dateTime], 
      data_sub[, Sub_metering_2], 
      col="red")
      
lines(data_sub[, dateTime], 
      data_sub[, Sub_metering_3],
      col="blue")
      
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

plot(data_sub[, dateTime], 
     data_sub[,Global_reactive_power], 
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()

Sys.setlocale("LC_TIME",curr_locale)
