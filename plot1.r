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
png(file="plot1.png", width=480, height=480, unit="px")

#Plot1
hist(plotpower$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")
dev.off()