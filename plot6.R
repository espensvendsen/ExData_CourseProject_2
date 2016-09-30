source("downloadNEIData.R")

# Read data source to data sframes
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor 
#    vehicle sources in Los Angeles County, California (fips == "06037").
#     Which city has seen greater changes over time in motor vehicle emissions?

# Subset data sets
SCC_motor <- SCC[grepl("motor|vehicle", SCC$EI.Sector, ignore.case=TRUE), ]
NEI_motor <- NEI[NEI$SCC %in% SCC_motor$SCC & NEI$fips %in% c("24510", "06037"), ]
NEI_motor$city <- ifelse(NEI_motor$fips == "24510", "Baltimore", "California") 

# Plot
png("plot6.png", width=480, height=480, units="px", bg="transparent")

library(ggplot2)
ggp <- ggplot(NEI_motor, aes(factor(year), Emissions, fill = city)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ city) +
  guides(fill = FALSE) +
  labs(x="Year", y = "PM2.5 Emission (Tons)") + 
  labs(title="PM2.5 Emission in Baltimore and Los Angeles")

print(ggp)
dev.off()