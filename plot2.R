# plot2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? Use the base 
# plotting system to make a plot answering this question.

# read the files if not already done
# NEI = National Emissions Inventory
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
# SCC = Source Classification Code
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# subset where the fips == baltimore's
baltimore  <- NEI[NEI$fips=="24510", ]

baltTotal <- aggregate(Emissions ~ year, baltimore, sum)

#create graphics device
png('plot2.png')
#create bar plot
par(bg = "#f7f7f7") #set background to light grey
barplot(height=baltTotal$Emissions, 
        names.arg=baltTotal$year, 
        xlab="Year", 
        ylab=expression('Total PM'[2.5]*' emissions (tons)'),
        main=expression('Baltimore emission per year'),
        col = "red") #change bars to red)
dev.off()