# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# load libraries
library(dplyr)
library(ggplot2)

# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset SCC data to find motor vehicle codes
motorcodesdf <- filter(SCC, EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles" | 
        EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | 
        EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" |
        EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles")

# store SCCs for motor vehicle combustion
scclist <- motorcodesdf$SCC

# subset NEI data on motor vehicle combustion codes and for city of Baltimare
dat <- filter(NEI, SCC %in% scclist & fips == "24510")

# # Sum emissions by year, save to df, and rename columns
df <- aggregate(dat$Emissions, by=list(dat$year), FUN=sum)
colnames(df) <- c("year", "emissions")

# Create plot and save to png file
png(file = "plot5.png")
with(df, plot(year, emissions, main = "Baltimore PM2.5 Motor Vehicle Emissions", 
              xlab = "Year", ylab = "Total PM2.5 Motor Vehicle Emissions (tons)"))
lines(df$year, df$emissions, type = "l")
dev.off()