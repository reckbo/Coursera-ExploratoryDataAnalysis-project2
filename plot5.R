source('setup.R')
library(dplyr)

if (!exists('NEI')) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

fips.baltimore <- "24510"

# I confirmed that subsetting by `type=='ON-ROAD'` is equivalent to subsetting with
# `grepl('vehicle', EI.Sector, ignore.case=T)`, and I will interpret motor
# vehicles this way, according to the helfpul link provided by a post in the discussion 
# forums: http://www.epa.gov/ttn/chief/net/2008neiv3/2008_neiv3_tsd_draft.pdf

emissions <- left_join(NEI, SCC, by='SCC') %>% 
    filter(grepl('vehicle', EI.Sector, ignore.case=T)  & fips == fips.baltimore) %>% 
    group_by(year) %>% 
    summarize(tot=sum(Emissions))

g <- ggplot(emissions, aes(x=year, y=tot)) + 
    geom_point(shape=16, size=4) + 
    geom_line() + 
    ylab('Total Emissions (tons)') + 
    xlab('Year') + 
    ggtitle(expression('Baltimore PM'[2.5]*' Emissions From Motor Vehicles'))
ggsave(filename='plot5.png', plot=g, h=7, w=7, dpi=100)
