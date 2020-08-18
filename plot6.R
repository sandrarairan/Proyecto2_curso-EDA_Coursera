
## library
library(dplyr)
library(ggplot2)

## read data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## name columnas
colnames(NEI)


baltlosngelesmotors <- subset(NEI, NEI$fips %in% c("24510","06037") & NEI$type == "ON-ROAD")

totaldatamotors <- aggregate(Emissions ~ year + fips, baltlosngelesmotors, sum)

totaldatamotors <- totaldatamotors %>%  mutate(city= ifelse( fips == "06037",
                                                  "Los Angeles County",
                                                  "Baltimore City"))

## plot
g<-ggplot(aes(year, Emissions),fill=city,data=totaldatamotors)
g+geom_bar(stat="identity", width=0.75,col = "blue", fill=totaldatamotors$year) +
        facet_wrap(. ~city)+
        ylab("Emissions") +
        ggtitle("  Compare emissions from motor vehicle sources in Baltimore 
                and  Los Angeles")+
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
dev.copy(png, file = "plot6.png", width=480, height=480)
dev.off()
