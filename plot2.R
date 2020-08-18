
## library
library(dplyr)

## read data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## name columnas
colnames(NEI)

## filtrar
subnei <- filter(NEI, NEI$year == 1999 | NEI$year == 2002 | 
                         NEI$year == 2005 | NEI$year == 2008   
)

baltimorecity <- filter(subnei, subnei$fips == "24510")

## hacer un vector de emisiones
totalemission <- tapply(baltimorecity$Emissions , baltimorecity$year , sum)

## convertir el vector a data frame
df <- data.frame(year=names(totalemission),sum=totalemission)

## plot
plot(df$year, df$sum , type = "b",col="blue",lty=1,lwd=4,pch=8,
     xlab = "Year", ylab = "Total Emissions baltimore city",
     main = "Total Emissions baltimore City by Year")

## plot png
dev.copy(png, file = "plot2.png", width=480, height=480)
dev.off()
