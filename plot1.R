## Read Raw Data ==========================
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Plot =============================================
data_out = aggregate(Emissions ~ year, NEI, sum) # sum by years

# adjust color
order_e = order(data_out$Emissions,decreasing = T)
pal <- colorRampPalette(c("#FF0000", "#FFAAAA"))

png("plot1.png", width=480, height=480)
barplot(height=data_out$Emissions, names.arg=data_out$year, 
        xlab="years", ylab=expression('total PM'[2.5]*' emission (tons)'),
        main=expression('Total PM'[2.5]*' Emissions by Years'),
        col=pal(4)[order_e])
dev.off()

