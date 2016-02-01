# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# load libraries
library(dplyr)
library(ggplot2)

# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data - select readings from Baltimore (fips == "24510")and LA (fips == "06037")
dat <- filter(NEI, fips == "24510" | fips =="06037")

#Replace city code with string names
city1 <- sub("24510", "Baltimore", dat$fips)
city2 <- sub("06037", "Los Angeles", city1)

# Add city vector column to data frame
dat$city <- city2

# Sum emissions by year and city, save to df, and rename columns
df <- aggregate(dat$Emissions, by=list(dat$year, dat$city), FUN=sum)
colnames(df) <- c("year", "city", "emissions")

# create plot and save to png file
png(file = "plot6.png")
qplot(year, emissions, data = df, facets = .~city, geom = c("point", "line"), 
      main = "Emissions by City and Time", xlab = "Year", ylab = "Total PM2.5 Emissions")
dev.off()