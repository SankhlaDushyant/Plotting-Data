if(!file.exists("exdata-data-household_power_consumption.zip")) {
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url,destfile="./Ds.zip",method="curl")
file<-unzip(zipfile="./Ds.zip")}
a<-fread(file,na.strings = "?",stringsAsFactors = FALSE)
a$Date<-as.Date(a$Date,"%d/%m/%Y")
b<- a[(a$Date=="2007-02-01") | (a$Date=="2007-02-02"),]
hist(b$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png", width=480, height=480)
dev.off()