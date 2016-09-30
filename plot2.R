source("downloadNEIData.R")

# Read data source to data frames
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips ==24510) 
#    from 1999 to 2008?
NEI_baltimore <- subset(NEI, fips == "24510")
year <- unique(NEI_baltimore$year)
total <- with(NEI_baltimore, tapply(Emissions, year, sum, na.rm=T))

png("plot2.png", width=480, height=480, units="px", bg="transparent")

barplot(total/10^3, names.arg=year, xlab="Year", ylab="PM2.5 (10^3 Tons)",
  main="PM2.5 Emissions in Baltimore City")

dev.off()
