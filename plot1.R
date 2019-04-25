library("data.table")

setwd("/Users/Dilson/Documents/Cursos/Coursera/Data Science/04_ExploratoryDataAnalysis/")

data <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
data_sub<-subset(data,data$Date=="1/2/2007" | data$Date == "2/2/2007")

data_sub[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
data_sub[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

png("plot1.png", width=480, height=480)

curr_locale <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME","en_US.UTF-8")

hist(data_sub[, Global_active_power], 
	 main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

dev.off()

Sys.setlocale("LC_TIME",curr_locale)
