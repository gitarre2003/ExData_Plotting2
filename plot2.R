## Read Raw Data ==========================
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Plot =============================================
data_in = NEI[which(NEI$fips=='24510'),]
data_out = aggregate(Emissions ~ year, data_in, sum) # sum by years

# adjust color
order_e = order(data_out$Emissions,decreasing = T)
pal <- colorRampPalette(c("#FF0000", "#FFAAAA"))

png("plot2.png", width=480, height=480)
barplot(height=data_out$Emissions, names.arg=data_out$year, 
        xlab="years", ylab=expression('total PM'[2.5]*' emission (tons)'),
        main=expression('Total PM'[2.5]*' Emissions in Baltimore City by Years'),
        col=pal(4)[order_e])
dev.off()

