source('setup.R')
library(dplyr)

if (!exists('NEI')) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

fips.baltimore <- "24510"
fips.LA <- "06037"

emissions <- left_join(NEI, SCC, by='SCC') %>% 
    filter(grepl('vehicle', EI.Sector, ignore.case=T)) %>%
    filter(fips == fips.LA | fips == fips.baltimore) %>% 
    group_by(year, fips) %>% 
    summarize(tot=sum(Emissions)) %>%
    mutate(county=factor(fips, labels=c('Los Angeles', 'Baltimore')))

g <- ggplot(emissions, aes(x=year, y=tot)) + 
    geom_point(shape=16, size=4) + 
    geom_line() + 
    facet_grid(. ~ county) +
    ylab('Total Emissions (tons)') + 
    xlab('Year') + 
    ggtitle(expression('PM'[2.5]*' Emissions From Motor Vehicles'))
ggsave(filename='plot6.png', plot=g, h=7, w=7, dpi=100)
