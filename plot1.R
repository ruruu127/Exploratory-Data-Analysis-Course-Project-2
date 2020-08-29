library(dplyr)

# Read in data
d <- readRDS("summarySCC_PM25.rds")

# Plot 1: Total emissions in the US
png("plot1.png", width = 480, height = 480)
tot.Emission <- summarise(group_by(d, year), Emissions=sum(Emissions))
tot.Emission$Emissions <- tot.Emission$Emissions/1000
colors <- as.character(rainbow(4))
p1 <- barplot(tot.Emission$Emissions, names.arg = tot.Emission$year, 
             col = colors, xlab = "Year", 
             ylab = "Total Emissions (kilotons)",
             main = "Total PM2.5 Emissions in the US", ylim = c(0,8000))
text(x = p1, y = tot.Emission$Emissions, 
     label = round(tot.Emission$Emissions, 3),
     pos = 3, cex = 0.8, col = "black")
dev.off()
