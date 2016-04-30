# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?
# Use the ggplot2 plotting system to make a plot answer this question.

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"a.zip",method = "curl")
unzip("a.zip")
NEI <- readRDS("summarySCC_PM25.rds")

#Subset Baltimore area
baltimore<-subset(NEI, NEI$fips==24510)  

library(ggplot2)
png("plot3.png")
ggp <- ggplot(baltimore, aes(x=factor(year), y=Emissions, fill=type)) +    
       geom_bar(stat="identity") + 
       theme_bw() + guides(fill=FALSE)+
# separate panels based on type for better judgenment
       facet_grid(.~type,scales = "free",space="free") + 
       labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
       labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))
print(ggp)
dev.off()