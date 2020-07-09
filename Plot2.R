library('dplyr')
library('lubridate')
library('chron')

# Set the Data 
     setwd("~/Desktop/Data Science Class/datasciencecoursera")
     power<-read.table('household_power_consumption.txt',header=TRUE,sep=';')
     power$Date<-dmy(power$Date); power$Time<-times(power$Time)
     power<-power[power$Date=='2007-02-01'|power$Date=='2007-02-02',]
     power[,3:9]<-lapply(power[,3:9],as.numeric)

# Plot Commands
     DateTime<-as.POSIXct(paste(power$Date,power$Time))
     plot(DateTime,power$Global_active_power,type='l',
          xlab='',ylab='Global Active Power (kilowatts)')
     dev.copy(png,file='Plot2.png')
     dev.off()