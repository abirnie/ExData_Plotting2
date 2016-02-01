# Download and unzip the files from the following url into working directory 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip


# Read data into DFs

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum emissions by year, save to df, and rename columns
df <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)
colnames(df) <- c("year", "emissions")

# Create plot and save to png file
png(file = "plot1.png")
with(df, plot(year, emissions, main = "PM2.5 Emissions Over Time", xlab = "Year", ylab = "PM2.5 Emissions (tons)"))
lines(df$year, df$emissions, type = "l")
dev.off()


