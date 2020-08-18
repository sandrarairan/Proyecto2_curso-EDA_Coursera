
## library
library(dplyr)
library(ggplot2)

## read data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## name columnas
colnames(NEI)


baltimorecity <- filter(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
## hacer un vector de emisiones
totalemission <- tapply(baltimorecity$Emissions, baltimorecity$year, sum) 

## convertir el vector a data frame
df <- data.frame(year=names(totalemission),sum=totalemission)
df

## plot
g<-ggplot(aes(year, sum),fill=year,data=df)
g+geom_bar(stat="identity", width=0.75,col = "blue", fill=df$year) +
        ylab("Emissions") +
        ggtitle("  Emissions from motor vehicle sources 
        changed from 1999–2008 in Baltimore City")+
        theme(
                plot.title = element_text(color="black", size=14, face="bold.italic"),
                panel.grid = element_blank(),
                axis.text.y = element_text(size=10),
                axis.ticks.y = element_blank(),
                legend.direction = "horizontal",
                legend.position="top",
                legend.justification = "center")+
        theme(plot.background = element_rect(fill = "gray"))



## plot png
dev.copy(png, file = "plot5.png", width=480, height=480)
dev.off()
