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
  hist(power$Global_active_power,col='red',breaks=15,
       xlab='Global Active Power (kilowatts)',main='Global Active Power')
  dev.copy(png,file='Plot1.png')
  dev.off()