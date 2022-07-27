# plot4
# How have emissions from motor vehicle sources changed from 
# 1999–2008 in Baltimore City?

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

# subset where the fips == baltimore's 
baltimore <- NEISCC[NEISCC$fips=="24510", ]

# get all obs where mobile listed 
mobileMatches  <- grepl("mobile", baltimore$EI.Sector, ignore.case=TRUE)
mobileBaltimore <- baltimore[mobileMatches, ]

# sum by year
mobilePerYear <- aggregate(Emissions ~ year,mobileBaltimore, sum)

png("plot5.png", width=640, height=480)
g <- ggplot(mobilePerYear, aes(year, Emissions))
g <- g + geom_line(lwd=1.5) +
  xlab("Year") +
  ylab(expression('Total PM'[2.5]*" Emissions (tons)")) +
  ggtitle('Baltimore Motor Vehicle (Mobile) Emissions (1999-2008)')
print(g)
dev.off()