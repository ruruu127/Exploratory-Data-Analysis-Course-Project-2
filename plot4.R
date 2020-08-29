library(dplyr)
library(ggplot2)

# Read in data
d1 <- readRDS("Source_Classification_Code.rds")
d2 <- readRDS("summarySCC_PM25.rds")

# Plot 4: Emissions from coal combustion-related sources
png("plot4.png", width = 600)
coal.combustion <- grepl("Fuel Comb.*Coal", d1$EI.Sector)
coal.combustion.source <- d1[coal.combustion,]
emission.coal <- d2[(d2$SCC %in% coal.combustion.source$SCC),]
emission.coal.related <- summarise(group_by(emission.coal, year), Emissions = sum(Emissions))
ggplot(emission.coal.related, 
       aes(x = factor(year), y = Emissions/1000, fill = factor(year), 
           label = round(Emissions/1000,2))) + 
  geom_bar(stat = "identity") + 
  labs(x = "Year", y = "Total PM2.5 Emissions (kilotons)", 
       title = "Emissions from coal combustion-related sources in kilotons") + 
  geom_text(aes(label = round(Emissions/1000, 2)), vjust = -1.0) +
  theme(legend.position = "none") +
  ylim(0, 650) +
  scale_fill_brewer(palette = "Dark2")
dev.off()
