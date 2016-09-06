library(ggplot2)
library(grid)
library(gridExtra)

## Read Raw Data ==========================
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Calculate =============================================
# subset of data
scc_idx = SCC[grepl("Vehicles", SCC$Short.Name, ignore.case=TRUE),1]
data_in = NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$SCC %in% scc_idx,]


# sum by years & city
data_out = aggregate(Emissions ~ year+fips, data_in, sum) 
data_out$fips = factor(data_out$fips)
levels(data_out$fips) = c('Los Angeles County','Baltimore City')

# calculate daily rate of change...
idx <- data_out$fips=='Los Angeles County'
set1 = data_out[idx,c(1,3)]
rate1 <- 100*diff(set1$Emissions)/set1[-nrow(set1),]$Emissions
rate1 = c(0,rate1)
data_out[idx,'rate']=rate1
idx <- data_out$fips=='Baltimore City'
set2 = data_out[idx,c(1,3)]
rate2 <- 100*diff(set2$Emissions)/set2[-nrow(set2),]$Emissions
rate2 = c(0,rate2)
data_out[idx,'rate']=rate2

## Plot =============================================
png("plot6.png", width=960, height=480)
g1=ggplot(data_out, aes(factor(year), Emissions, fill=Emissions)) + 
  facet_grid(. ~ fips) + 
  geom_bar(stat = "identity")+
  scale_fill_gradient(low="#FF8888",high="#FF0000") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" emissions (tons)")) +
  ggtitle('Total Emissions from Motor Vehicles in Two Cities from 1999 to 2008')

g2=ggplot(data_out, aes(factor(year), rate, color=fips,group = fips)) + 
  geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" emissions change rate (%)")) +
  ggtitle('Total Emissions Chang Rate from Motor Vehicles in Two Cities from 1999 to 2008')

grid.arrange(g1, g2, ncol = 1)
dev.off()


