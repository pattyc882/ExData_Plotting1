library(lubridate)
library(dplyr)
fileUrl<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(fileUrl, destfile = "./data/power.zip")
unzip("./data/power.zip", exdir="./data")
power<-read.table("./data/household_power_consumption.txt", sep=";", header = TRUE)
plotpower1<-power%>% filter(Date==c("1/2/2007"))
plotpower2<-power%>% filter(Date==c("2/2/2007"))
plotpower<-rbind(plotpower1, plotpower2)
plotpower$newdate<-strptime(plotpower$Date, "%d/%m/%Y")
plotpower$day<-weekdays(plotpower$newdate)
plotpower$datetime<-as.POSIXct(paste(plotpower$newdate, plotpower$Time))

plotpower$Global_active_power<-as.numeric(as.character(plotpower$Global_active_power))
png(file="plot4.png", width=480, height=480, unit="px")


#plot4

par(mfcol=c(2,2))

plot(plotpower$datetime, plotpower$Global_active_power, type="l", xlab="",ylab="Global Active Power (kilowatts)")

plot(plotpower$datetime, plotpower$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(plotpower$datetime, plotpower$Sub_metering_2, col="red")
lines(plotpower$datetime, plotpower$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)


plot(plotpower$datetime, plotpower$Voltage, type="l", xlab="datetime", ylab="Voltage")     
plot(plotpower$datetime, plotpower$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()