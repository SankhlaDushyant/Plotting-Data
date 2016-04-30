if(!file.exists("exdata-data-household_power_consumption.zip")) {
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,destfile="./Ds.zip",method="curl")
  file<-unzip(zipfile="./Ds.zip")}
a<-fread(file,na.strings = "?",stringsAsFactors = FALSE)

a$Date <- as.Date(a$Date, format="%d/%m/%Y")
a<- a[(a$Date=="2007-02-01") | (a$Date=="2007-02-02"),]
datetime <- paste(as.Date(a$Date), a$Time)
a$Datetime <- as.POSIXct(datetime)

plot(a$Datetime,a$Sub_metering_1, type="l",ylab="Energy sub metering", xlab="")
  lines(a$Datetime,a$Sub_metering_2,col='Red')
  lines(a$Datetime,a$Sub_metering_3,col='Blue')

legend("topright", col=c("black", "red", "blue"),c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()