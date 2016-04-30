# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland(fips == "24510") from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"a.zip",method = "curl")
unzip("a.zip")
NEI <- readRDS("summarySCC_PM25.rds")

# aggregate : Splits the data into subsets, computes summary statistics for each, and returns the result in a convenient form.
PerYear_Baltimore<- aggregate(Emissions[NEI$fips=="24510"] ~ year[NEI$fips=="24510"], NEI, sum)
# barplot(height, width = 1, space = NULL,names.arg = NULL...)
png("plot2.png")
barplot(PerYear_Baltimore$Emissions, names.arg = PerYear_Baltimore$year, xlab="Year", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*'Emissions From all Baltimore City Sources'))
dev.off()
