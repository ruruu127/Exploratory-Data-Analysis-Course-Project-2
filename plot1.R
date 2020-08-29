library(dplyr)

# Read in data
d <- readRDS("summarySCC_PM25.rds")

# Plot 2: Total emissions in Baltimore City
png("plot2.png", width = 480, height = 480)
baltimore.emission <- summarise(group_by(filter(d, fips == "24510"), year), 
                                Emissions=sum(Emissions))
colors <- as.character(rainbow(4))
p2 <- barplot(baltimore.emission$Emissions, 
              names.arg = baltimore.emission$year, 
              col = colors, xlab = "Year", 
              ylab = "Total Emissions (kilotons)",
              main = "Total PM2.5 Emissions in Baltimore City, Maryland", 
              ylim = c(0,4000))
text(x = p2, y = baltimore.emission$Emissions, 
     label = round(baltimore.emission$Emissions, 3),
     pos = 3, cex = 0.8, col = "black")
dev.off()
