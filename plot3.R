library(dplyr)
library(ggplot2)

# Read in data
d <- readRDS("summarySCC_PM25.rds")

# Plot 3: Emissions based on type
png("plot3.png", width = 800)
baltimore.emission.type <- summarise(group_by(filter(d, fips == "24510"), 
                                              year, type), 
                                Emissions=sum(Emissions))
ggplot(baltimore.emission.type, 
       aes(x = factor(year), y = Emissions, fill = type, 
           label = round(Emissions,3))) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_grid(. ~ type) +
  labs(x = "Year", y = "Total PM2.5 Emission in tons", 
       title = "PM2.5 Emissions in Baltimore", 
       subtitle = "Based on various source types") +
  geom_text(aes(label = round(Emissions, 2)), vjust = -1.0)
dev.off()
