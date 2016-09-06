library(ggplot2)

## Read Raw Data ==========================
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Plot =============================================
data_in = NEI[which(NEI$fips=='24510'),]
data_out = aggregate(Emissions ~ year+type, data_in, sum) # sum by years

png("plot3.png", width=480, height=480)
g <- ggplot(data_out, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" emissions (tons)")) +
  ggtitle('Total Emissions in Baltimore City from Various Types from 1999 to 2008')
print(g)
dev.off()

