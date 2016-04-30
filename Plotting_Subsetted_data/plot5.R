# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"a.zip",method = "curl")
unzip("a.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
library(ggplot2)

# Gather the subset of the NEI data which corresponds to Motor vehicles
Motor <- grep("vehicle", SCC$EI.Sector, ignore.case=TRUE)
MotorSCC <- SCC[Motor,]$SCC
MotorNEI <- NEI[NEI$SCC %in% MotorSCC,]

# Subset the Motor NEI data to Baltimore's fip
baltimore_MotorNEI <- MotorNEI[MotorNEI$fips=="24510",]


png("plot5.png")
ggp <- ggplot(baltimore_MotorNEI,aes(factor(year),Emissions,fill = factor(year))) +
       geom_bar(stat="identity") +
       labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
       labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
print(ggp)
dev.off()