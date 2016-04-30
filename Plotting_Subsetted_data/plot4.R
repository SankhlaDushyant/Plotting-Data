#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"a.zip",method = "curl")
unzip("a.zip")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# Subset coal and combustion related NEI data
CombustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
CoalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
CoalCombustion <- union(CombustionRelated,CoalRelated)
CombustionSCC <- SCC[CoalCombustion,]$SCC
CombustionNEI <- NEI[NEI$SCC %in% CombustionSCC,]

png("plot4.png")

ggp <- ggplot(CombustionNEI,aes(factor(year),Emissions/10^6)) +
       geom_bar(stat="identity",fill="grey",width=0.75) +
       theme_bw() +  guides(fill=FALSE) +
       labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^6 Tons)")) + 
       labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
print(ggp)
dev.off()

