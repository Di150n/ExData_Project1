library("data.table")

setwd("/Users/Dilson/Documents/Cursos/Coursera/Data Science/04_ExploratoryDataAnalysis/")

data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data_sub<-subset(data,data$Date=="1/2/2007" | data$Date == "2/2/2007")

data_sub[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
data_sub[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

png("plot2.png", width=480, height=480)

curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")

plot(x = data_sub[, dateTime], 
	 y = data_sub[, Global_active_power], 
	 type="l", 
	 xlab="", 
	 ylab="Global Active Power (kilowatts)")

dev.off()

Sys.setlocale("LC_TIME",curr_locale)
