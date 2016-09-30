source("downloadNEIData.R")

# Read data source to data frames
NEI <- readRDS("summarySCC_PM25.rds")  
SCC <- readRDS("Source_Classification_Code.rds")

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#    which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? 
#    Which have seen increases in emissions from 1999???2008? 

NEI_baltimore <- subset(NEI, fips == "24510")
NEI_baltimore$type <- factor(NEI_baltimore$type, levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))

# Plot
png("plot3.png", width=840, height=480, units="px", bg="transparent")

library(ggplot2)
ggp <- ggplot(NEI_baltimore, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  guides(fill = FALSE) +
  labs(x="Year", y = "PM2.5 Emission (Tons)") + 
  labs(title="PM2.5 Emission in Baltimore City by source type")

print(ggp)
dev.off()