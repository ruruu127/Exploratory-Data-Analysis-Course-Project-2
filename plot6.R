library(dplyr)

# Read in data
d1 <- readRDS("Source_Classification_Code.rds")
d2 <- readRDS("summarySCC_PM25.rds")

# Plot 6: Comparison of emissions from motor vehicle sources between Baltimore City with Los Angeles County
png("plot6.png", width = 600)
baltimore <- summarise(group_by(filter(d2, fips == "24510" & type == "ON-ROAD"), year), Emissions = sum(Emissions))
losangeles <- summarise(group_by(filter(d2, fips == "06037" & type == "ON-ROAD"), year), Emissions = sum(Emissions))
baltimore$County <- "Baltimore City, MD"
losangeles$County <- "Los Angeles County, CA"
baltimore.losangeles <- rbind(baltimore, losangeles)
ggplot(baltimore.losangeles, 
       aes(x = factor(year), y = Emissions, fill = County, 
           label = round(Emissions, 2))) + 
  geom_bar(stat = "identity") + 
  facet_grid(County ~ ., scales = "free_y") + 
  labs(x = "Year", y = "Total PM2.5 Emission (tons)", 
       title = "Motor vehicle emission variation in Baltimore and Los Angeles in tons") + 
  geom_text(aes(label = round(Emissions, 2)), vjust = 1.5)
dev.off()
