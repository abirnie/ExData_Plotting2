# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# load libraries
library(dplyr)

# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data - select only readings from Baltimore, MD (fips == "24510")

baltdf <- filter(NEI, fips == "24510")

# Sum emissions by year, save to df, and rename columns
df <- aggregate(baltdf$Emissions, by=list(baltdf$year), FUN=sum)
colnames(df) <- c("year", "emissions")

# Creat plot and save to png file
png(file = "plot2.png")
with(df, plot(year, emissions, main = "Baltimore, MD PM2.5 Emissions", xlab = "Year", ylab = "Baltimore PM2.5 Emissions (tons)"))
lines(df$year, df$emissions, type = "l")
dev.off()