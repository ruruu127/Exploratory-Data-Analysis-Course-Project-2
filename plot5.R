library(dplyr)

# Read in data
d1 <- readRDS("Source_Classification_Code.rds")
d2 <- readRDS("summarySCC_PM25.rds")

# Plot 5: Emissions from motor vehicle sources in Baltimore City, Maryland
png("plot5.png", width = 600)
baltimore.emission <- d2[(d2$fips=="24510") & (d2$type=="ON-ROAD"),]
baltimore.emission.year <- summarise(group_by(baltimore.emission, year), Emissions=sum(Emissions))
ggplot(baltimore.emission.year, 
       aes(x=factor(year), y=Emissions, fill=factor(year), 
           label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  labs(x = "Year", y = "Total PM2.5 Emissions in tons",
       title = "Emissions from motor vehicle sources in Baltimore City") +
  geom_text(aes(label = round(Emissions, 2)), vjust = -1.0) +
  theme(legend.position = "none") +
  ylim(c(0,400))
dev.off()
