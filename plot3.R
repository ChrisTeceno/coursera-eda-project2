# plot3
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four 
# sources have seen decreases in emissions from 1999–2008 for 
# Baltimore City? Which have seen increases in emissions from 
# 1999–2008? Use the ggplot2 plotting system to make a plot answer 
# this question.

# read the files if not already done
# NEI = National Emissions Inventory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
# SCC = Source Classification Code
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# pull in ggplot2
library(ggplot2)

# subset where the fips == baltimore's
baltimore  <- NEI[NEI$fips=="24510", ]

baltTotal <- aggregate(Emissions ~ year + type, baltimore, sum)


png("plot3.png", width=640, height=480)
g <- ggplot(baltTotal, aes(year, Emissions, color = type))
g <- g + geom_line(lwd=1.5) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions (tons)")) +
  ggtitle('Total Emissions by type in Baltimore (1999-2008)')
print(g)
dev.off()