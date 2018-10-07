#set working directory
setwd("c:/Users/yii/Desktop/R code/")

#download and unzip the .zip file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destUrl<-"c:/Users/yii/Desktop/R code/power.zip"
download.file(fileUrl,destUrl)
unzip("power.zip") 

#read the file into R
file="household_power_consumption.txt"
power<-read.table(file=file, sep = ";",header=TRUE, na.strings = '?',colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
power$Date <- as.Date(power$Date, "%d/%m/%Y")

#subset the data set that needed
power1<-subset(power,Date=="2007-2-1")
power2<-subset(power,Date=="2007-2-2")
powerSelect<-rbind(power1,power2)

#for the second, third, and forth plot
#combine Date and Time
DateTime<-with (powerSelect,paste(Date,Time))
library(dplyr)
rest<-select(powerSelect,Global_active_power:Sub_metering_3)
plot2Data<-cbind(DateTime,rest)
plot2Data$DateTime <- as.POSIXct(DateTime)

#for the forth plot
#topleft plot
par(mfrow=c(2,2))
plot(plot2Data$DateTime,plot2Data$Global_active_power,type='l',ylab="Global Active Power",xlab="")

#topright plot
plot(plot2Data$DateTime,plot2Data$Voltage,type='l',xlab="DateTime",ylab="Voltage")

#bottomleft plot
with(plot2Data,plot(DateTime,Sub_metering_1,type='l',ylab="Energy sub metering",xlab=""))
lines(plot2Data$DateTime,plot2Data$Sub_metering_2,col="red")
lines(plot2Data$DateTime,plot2Data$Sub_metering_3,col="blue")
legend("topright",lty=c(1,1,1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"))

#bottomright plot
plot(plot2Data$DateTime,plot2Data$Global_reactive_power,type='l',xlab="DateTime",ylab="Global_reactive_power")
dev.copy(png,file="plot4.png",width=480, height=480)
dev.off()




