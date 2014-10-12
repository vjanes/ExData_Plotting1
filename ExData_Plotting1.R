Sys.setlocale("LC_TIME", "English")
setwd("D:/USERS/Vincent/Documents/R/ExData_Plotting1")

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

##loading data
alldata<-read.csv("household_power_consumption.txt", 
              header = TRUE, sep = ";",
              colClasses=c('myDate','character',rep('numeric',7)),na.strings="?")

tstamp<-as.POSIXct(paste(alldata$Date,alldata$Time), format="%Y-%m-%d %H:%M:%S")
alldata<<-cbind(alldata,tstamp)

##subsetting data
gdata<-subset(alldata,as.POSIXct(alldata$tstamp)>=as.POSIXct("2007-02-01") & as.POSIXct(alldata$tstamp)<as.POSIXct("2007-02-03") )

##Plotting graphs

##Plot1: histogram
png(filename = "plot1.png", width = 480, height = 480)
hist(gdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatt)")
dev.off()

##Plot2: curve
png(filename = "plot2.png", width = 480, height = 480)
plot(gdata$tstamp,gdata$Global_active_power,type='l',xlab="",ylab="Global Active Power")
dev.off()

##Plot3: multicurves
png(filename = "plot3.png", width = 480, height = 480)
plot(gdata$tstamp,gdata$Sub_metering_1,type='l',xlab="",ylab="Energy metering")
lines(gdata$tstamp,gdata$Sub_metering_2,col="red")
lines(gdata$tstamp,gdata$Sub_metering_3,col="blue")
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))
dev.off()

##Plot4: multiple plots
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(gdata,{
plot(gdata$tstamp,gdata$Global_active_power,type='l',xlab="",ylab="Global Active Power")

plot(gdata$tstamp,gdata$Voltage,type='l',xlab="datetime",ylab="Voltage")

plot(gdata$tstamp,gdata$Sub_metering_1,type='l',xlab="",ylab="Energy metering")
lines(gdata$tstamp,gdata$Sub_metering_2,col="red")
lines(gdata$tstamp,gdata$Sub_metering_3,col="blue")
legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))

plot(gdata$tstamp,gdata$Global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")

})
dev.off()
