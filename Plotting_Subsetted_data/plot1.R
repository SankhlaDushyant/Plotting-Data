# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"a.zip",method = "curl")
unzip("a.zip")
NEI <- readRDS("summarySCC_PM25.rds")

# aggregate : Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.
PerYear <- aggregate(Emissions ~ year, NEI, sum)

# barplot(height, width = 1, space = NULL,names.arg = NULL...)
png("plot1.png")
barplot(PerYear$Emissions/10^6, names.arg = PerYear$year, xlab="Year", ylab=expression('total PM'[2.5]*' emission(10^6)'),main=expression('Total PM'[2.5]*' emissions at various years'))
dev.off()