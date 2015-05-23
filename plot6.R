# -------------------------------------------------------------------
# FILE: plot6.R
# Course: Exploratory Data Analysis
# Project: 2
#
# R script to generate the sixth plot for the project.
#
# To run this script you will need to have the project data files
# Source_Classification_Code.rds and summarySCC_PM25.rds in your
# working directory and have your working directory set properly.
# Setting the working_dir variable should be the only change needed.
# The plot generated, plot2.png, too will be in the working directory.
#
# Required packages: dplyr and ggplot2
#
# -------------------------------------------------------------------
# CHANGELOG:
# 2015-05-20 File created.
# -------------------------------------------------------------------
#
# Initializations
#
# set working_dir variable
working_dir <- "~/Documents/courses/exploratory_data_analysis/exdata_project2"

# set working directory
setwd(working_dir)

# libraries
library(dplyr)
library(ggplot2)

#
# Read summarySCC_PM25 data file
#
NEI <- readRDS("summarySCC_PM25.rds")

# filter out Baltimore City, Maryland (fips == "24510")
#   and motor vehicle sources (type == "ON-ROAD")
la_baltimore <- NEI %>% 
  filter(fips %in% c("24510","06037"),type == "ON-ROAD")

la_baltimore$fips <- gsub("06037","Los Angeles County, CA",la_baltimore$fips)
la_baltimore$fips <- gsub("24510","Baltimore City, MD",la_baltimore$fips)
colnames(la_baltimore)[1] <- "Location"

# compute total annual emissions
totalEmissions <- aggregate(Emissions ~ year + Location, la_baltimore, sum)

# LA data is approximately 10 time greater than Baltimore, so multiple every
#  year of data by 10 to make better comparison 
ind <- totalEmissions[,"Location"] == "Baltimore City, MD"
totalEmissions[ind,"Emissions"] <- totalEmissions[ind,"Emissions"] * 10

#
# generate PNG plot
#
plot6 <- qplot(data=totalEmissions,
               x = year,
               y = Emissions,
               color = Location,
               facets = ~Location,
               geom = c("point","line"),
               ylab = "Emissions (tons)",
               main = "Motor Vehicle Emission in LA County and Baltimore\nFor years 1999 to 2008")

# save it to file
ggsave(plot6,file="plot6.png", width = 6.7, height = 6.7, dpi = 72)
