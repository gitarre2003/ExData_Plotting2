library(ggplot2)

## Read Raw Data ==========================
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Plot =============================================
# subset of data
data_in = NEI[which(NEI$fips=='24510'),]
scc_idx = SCC[grepl("Vehicles", SCC$Short.Name, ignore.case=TRUE),1]
data_in = data_in[which(data_in$SCC %in% scc_idx),]

# sum by years
data_out = aggregate(Emissions ~ year, data_in, sum) 

png("plot5.png", width=480, height=480)
g = ggplot(data_out, aes(factor(year), Emissions, fill=Emissions)) + 
  geom_bar(stat = "identity")+
  scale_fill_gradient(low="#FF8888",high="#FF0000") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" emissions (tons)")) +
  ggtitle('Total Emissions from Motor Vehicles in Baltimore City from 1999 to 2008')
print(g)
dev.off()

