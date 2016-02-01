# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# load libraries
library(dplyr)
library(ggplot2)

# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data - select only readings from Baltimore, MD (fips == "24510")
baltdf <- filter(NEI, fips == "24510")

# Sum emissions by year and type, save to df, and rename columns
df <- aggregate(baltdf$Emissions, by=list(baltdf$year, baltdf$type), FUN=sum)
colnames(df) <- c("year", "type", "emissions")

# create plot and save to png file
png(file = "plot3.png")
        qplot(year, emissions, data = df, facets = .~type, geom = c("point", "line"), 
                main = "Emissions by Type and Time", xlab = "Year", ylab = "Total PM2.5 Emissions")
dev.off()