# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# load libraries
library(dplyr)
library(ggplot2)

# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset SCC data to find coal-combustion codes
coalcodesdf <- filter(SCC, EI.Sector == "Fuel Comb - Comm/Institutional - Coal" | 
        EI.Sector == "Fuel Comb - Electric Generation - Coal" | 
        EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal")

# store SCCs for coal-combustion
scclist <- coalcodesdf$SCC

# subset NEI data on coal-combustion codes
dat <- filter(NEI, SCC %in% scclist)

# # Sum emissions by year, save to df, and rename columns
df <- aggregate(dat$Emissions, by=list(dat$year), FUN=sum)
colnames(df) <- c("year", "emissions")

# Create plot and save to png file
png(file = "plot4.png")
with(df, plot(year, emissions, main = "US PM2.5 Coal Emissions Over Time", 
        xlab = "Year", ylab = "Total PM2.5 Coal Emissions (tons)"))
lines(df$year, df$emissions, type = "l")
dev.off()