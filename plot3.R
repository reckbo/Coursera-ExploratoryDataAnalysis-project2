source('setup.R')
library(dplyr)

if (!exists('NEI')) {
    NEI <- readRDS("summarySCC_PM25.rds")
}

fips.baltimore <- "24510"

emissions <- NEI %>% 
        filter(fips==fips.baltimore) %>% 
        group_by(year, type) %>% 
        summarize(tot=sum(Emissions))

g <- ggplot(emissions, aes(x=year, y=tot)) + 
    facet_grid(. ~ type) + 
    geom_point(shape=16, size=4) + 
    geom_line() +
    ylab('Total Emissions (tons)') + 
    xlab('Year') + 
    ggtitle(expression('Baltimore PM'[2.5]*' Emissions For Each Type'))
ggsave(filename='plot3.png', plot=g, h=7, w=7, dpi=100)
