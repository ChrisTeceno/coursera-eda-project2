# plot4
# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?

# read the files if not already done
# NEI = National Emissions Inventory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
# SCC = Source Classification Code
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
# merge the data by source (SCC)
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

# pull in ggplot2
library(ggplot2)

# get all obs where coal listed 
coalMatches  <- grepl("coal", NEISCC$EI.Sector, ignore.case=TRUE)
coalPolution <- NEISCC[coalMatches, ]

# sum by year
coalPerYear <- aggregate(Emissions ~ year, coalPolution, sum)

png("plot4.png", width=640, height=480)
g <- ggplot(coalPerYear, aes(year, Emissions))
g <- g + geom_line(lwd=1.5) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions (tons)")) +
  ggtitle('US Coal Emissions (1999-2008)')
print(g)
dev.off()
