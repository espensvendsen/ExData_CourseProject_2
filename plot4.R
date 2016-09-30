source("downloadNEIData.R")

# Read data source to data frames
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 4. Across the United States, how have emissions from coal combustion-related sources changed from
#    1999???2008?

# Find coal combustion-related sources from lookup table
SCC_coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE), ]
SCC_comb <- SCC[grepl("comb", SCC$Short.Name, ignore.case=TRUE), ]
SCC_mrg <- merge(SCC_coal, SCC_comb, by = "SCC")

# Aggregate coal combustion-related sources
NEI_coal_comb <- NEI[NEI$SCC %in% SCC_mrg$SCC, ]
year <- unique(NEI_coal_comb$year)
total <- with(NEI_coal_comb, tapply(Emissions, year, sum, na.rm=TRUE))

# Plot
png("plot4.png", width=480, height=480, units="px", bg="transparent")
barplot(total/10^3, names.arg=year, xlab="Year", ylab="PM2.5 (10^3 Tons)",
        main="PM2.5 Coal Combustion Source Emissions in US")
dev.off()
