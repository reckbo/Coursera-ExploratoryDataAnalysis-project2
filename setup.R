archive <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
datafiles <- c('Source_Classification_Code.rds',
               'summarySCC_PM25.rds')

if(!all(file.exists(datafiles))) {
    download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', 
                  destfile='data.zip', 
                  method='curl')
    unzip('data.zip')
}
