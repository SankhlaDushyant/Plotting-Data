# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?
url <- "h
ttps://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
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
baltimore_MotorNEI$city <- "Baltimore City"

# Subset the Motor NEI data to Los Angeles's fip
losAngeles_MotorNEI <- MotorNEI[MotorNEI$fips=="06037",]
losAngeles_MotorNEI$city <- "LosAngeles City"

Combination_MotorNEI <- rbind(baltimore_MotorNEI,losAngeles_MotorNEI)

png("plot6.png")
ggp <- ggplot(Combination_MotorNEI,aes(factor(year),Emissions,fill = city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(.~city,scales = "free",space="free") + 
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
print(ggp)
dev.off()