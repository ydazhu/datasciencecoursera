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
     par(mfcol=c(2,2))
     # Plot 
     plot(DateTime,power$Global_active_power,type='l',
          xlab='',ylab='Global Active Power (kilowatts)')
     # Plot
     plot(DateTime,power$Sub_metering_1,type='l',col='black',
          ylab='Energy Sub Metering',xlab='')
     lines(DateTime,power$Sub_metering_2,type='l',col='red')
     lines(DateTime,power$Sub_metering_3,type='l',col='blue')
     legend('topright',legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
            lwd=1,col=c('black','red','blue'))
     # Plot
     plot(DateTime,power$Voltage,type='l',xlab='',ylab='Voltage')
     # Plot
     plot(DateTime,power$Global_reactive_power,type='l',
          xlab='',ylab='Global Reactive Power')
     dev.copy(png,file='Plot4.png')
     dev.off()
     par(mfcol=c(1,1))
     