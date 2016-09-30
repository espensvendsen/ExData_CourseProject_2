source("downloadNEIData.R")

# Read data source to data sframes
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 5. How have emissions from motor vehicle sources changed from 1999???2008 in Baltimore City?
SCC_motor <- SCC[grepl("motor|vehicle", SCC$EI.Sector, ignore.case=TRUE), ]
NEI_balt_motor <- NEI[NEI$fips == 24510 & NEI$SCC %in% SCC_motor$SCC, ]
year <- unique(NEI_balt_motor$year)
total <- with(NEI_balt_motor, tapply(Emissions, year, sum, na.rm=T))

# Plot
png("plot5.png", width=480, height=480, units="px", bg="transparent")
barplot(total, names.arg=year, xlab="Year", ylab="PM2.5 (Tons)",
        main="PM2.5 Emissions by Motor Vehicles, Baltimore City")
dev.off()
