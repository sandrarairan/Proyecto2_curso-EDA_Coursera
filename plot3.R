
## library
library(dplyr)
library(ggplot2)
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
baltimore <- aggregate(Emissions ~ year + type, baltimorecity, sum)


## plot
g <- ggplot(baltimore, aes(year, Emissions, col = type,shape=type)) 
g+  geom_line() +
  geom_point() +
  xlab("Year") +
  ggtitle("Emissions for Baltimore City by Type and Year")+
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
dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()
