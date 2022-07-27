# plot1
# Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot 
# showing the total PM2.5 emission from all sources for each of 
# the years 1999, 2002, 2005, and 2008.

# read the files if not already done
# NEI = National Emissions Inventory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
# SCC = Source Classification Code
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
# aggregate emissions by year using sum
totals <- aggregate(Emissions ~ year, NEI, sum)

#create graphics device
png('plot1.png')
#create bar plot
par(bg = "#f7f7f7") #set background to light grey
barplot(height=totals$Emissions, 
        names.arg=totals$year, 
        xlab="Year", 
        ylab=expression('Total PM'[2.5]*' emissions (tons)'),
        main=expression('Total PM'[2.5]*' emissions per year'),
        col = "red") #change bars to red
dev.off()