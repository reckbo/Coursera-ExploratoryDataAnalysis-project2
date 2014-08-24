source('setup.R')
library(dplyr)

if (!exists('NEI')) {
    NEI <- readRDS("summarySCC_PM25.rds")
}

fips.baltimore <- "24510"

emissions <- NEI %>% 
        filter(fips==fips.baltimore) %>% 
        group_by(year) %>% 
        summarize(tot=sum(Emissions))

png(filename='plot2.png')
plot(emissions, 
     xlab='Year', 
     ylab=expression('Total PM'[2.5]*' Emissions (tons)'), 
     main=expression('Baltimore Total PM'[2.5]*' Emissions'),
     type='l')
points(emissions, pch=16, cex=2)
dev.off()
