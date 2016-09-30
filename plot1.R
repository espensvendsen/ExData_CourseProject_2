source("downloadNEIData.R")

# Read data source to data frames
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
year <- unique(NEI$year)
total <- with(NEI, tapply(Emissions, year, sum, na.rm=T))

png("plot1.png", width=480, height=480, units="px", bg="transparent")

barplot(total/10^6, names.arg=year, xlab="Year", ylab="PM2.5 (10^6 Tons)",
  main="PM2.5 Emissions in US")

dev.off()
