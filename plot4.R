source('setup.R')
library(dplyr)

if (!exists('NEI')) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}


# When deciding how to filter for fuel combustion, I used a helpful link
# provided by the discussion forums: 
# http://www.epa.gov/ttn/chief/net/2011nei/2011_nei_tsdv1_draft2_june2014.pdf
emissions <- left_join(NEI, SCC, by='SCC') %>% 
        filter(grepl('fuel comb', EI.Sector, ignore.case=T)) %>% 
        filter(grepl('coal', EI.Sector, ignore.case=T)) %>%
        group_by(year) %>% 
        summarize(tot=sum(year))

g <- ggplot(emissions, aes(x=year, y=tot)) + 
    geom_point(shape=16, size=4) + 
    geom_line() + 
    ylab('Total Emissions (tons)') + 
    xlab('Year') + 
    ggtitle(expression('US PM'[2.5]*' Emissions From Coal'))
ggsave(filename='plot4.png', plot=g, h=7, w=7, dpi=100)
