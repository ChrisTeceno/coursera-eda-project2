# plot 6
# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# California (\color{red}{\verb|fips == "06037"|}fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle 
# emissions?

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

# subset where the fips == baltimore's or LA's
baltimore_LA  <- NEISCC[(NEISCC$fips=="24510"|NEISCC$fips=="06037"), ]

# get all obs where mobile listed 
mobileMatches  <- grepl("mobile", baltimore_LA$EI.Sector, ignore.case=TRUE)
mobileBaltimore_LA <- baltimore_LA[mobileMatches, ]

# sum by year
mobilePerYear <- aggregate(Emissions ~ year +fips,mobileBaltimore_LA, sum)
mobilePerYear$fips[mobilePerYear$fips=="24510"] <- "Baltimore, MD"
mobilePerYear$fips[mobilePerYear$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=640, height=480)
g <- ggplot(mobilePerYear, aes(year, Emissions, color = fips))
g <- g + geom_line(lwd=3) +
  geom_smooth(method='lm', se = FALSE) + # add linear regression
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions (tons)")) +
  ggtitle('Baltimore vs LA: Motor Vehicle (Mobile) Emissions (1999-2008)')
print(g)
dev.off()