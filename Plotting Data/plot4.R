if(!file.exists("exdata-data-household_power_consumption.zip")) {
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,destfile="./Ds.zip",method="curl")
  file<-unzip(zipfile="./Ds.zip")}
a<-fread(file,na.strings = "?",stringsAsFactors = FALSE)

a$Date <- as.Date(a$Date, format="%d/%m/%Y")
a<- a[(a$Date=="2007-02-01") | (a$Date=="2007-02-02"),]
datetime <- paste(as.Date(a$Date), a$Time)
a$Datetime <- as.POSIXct(datetime)

par(mfrow=c(2,2))
##PLOT 1
plot(a$Datetime,a$Global_active_power, type="l", xlab="", ylab="Global Active Power")
##PLOT 2
plot(a$Datetime,a$Voltage, type="l", xlab="datetime", ylab="Voltage")
##PLOT 3
plot(a$Datetime,a$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(a$Datetime,a$Sub_metering_2,col="red")
lines(a$Datetime,a$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
#PLOT 4
plot(a$Datetime,a$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
