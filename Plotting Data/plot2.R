if(!file.exists("exdata-data-household_power_consumption.zip")) {
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url,destfile="./Ds.zip",method="curl")
file<-unzip(zipfile="./Ds.zip")}
a<-fread(file,na.strings = "?",stringsAsFactors = FALSE)

a$Date <- as.Date(a$Date, format="%d/%m/%Y")
a<- a[(a$Date=="2007-02-01") | (a$Date=="2007-02-02"),]
datetime <- paste(as.Date(a$Date), a$Time)
a$Datetime <- as.POSIXct(datetime)
plot(a$Datetime,a$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()