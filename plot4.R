
## library
library(dplyr)

## read data
NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

## name columnas
colnames(NEI)

## encontrar coal y comb
scccombcoal<-SCC$Short.Name[grepl("\\<Coal\\>|\\<Comb\\>", SCC$Short.Name)]
CoalCombustion<-SCC[scccombcoal,]$SCC

datacombustion<-NEI[NEI$SCC %in% CoalCombustion,]

totaldatacombustion <- aggregate(Emissions ~ year + type, datacombustion, sum)


g <- ggplot(totaldatacombustion, aes(year, Emissions, col = type,shape=type)) 
g+  geom_line() +
        geom_point() +
        xlab("Year") +
        ggtitle("US Total Coal Emission by Type and Year")+
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
dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()

