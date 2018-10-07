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

#plot the first graph and copy to png
hist(as.numeric(as.character(powerSelect$Global_active_power,rm.na=TRUE)),col="red",main="Global Active Power",xlab = "Global Active Power(kilowatts)")
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()
