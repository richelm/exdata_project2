# -------------------------------------------------------------------
# FILE: plot3.R
# Course: Exploratory Data Analysis
# Project: 2
#
# R script to generate the third plot for the project.
#
# To run this script you will need to have the project data files 
# Source_Classification_Code.rds and summarySCC_PM25.rds in your 
# working directory and have your working directory set properly. 
# Setting the working_dir variable should be the only change needed. 
# The plot generated, plot2.png, too will be in the working directory.
#
# Required packages: dplyr
#
# -------------------------------------------------------------------
# CHANGELOG:
#   2015-05-20 File created.
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

#
# Read summarySCC_PM25 data file
#
NEI <- readRDS("summarySCC_PM25.rds")

# filter out Baltimore City, Maryland (fips == "24510")
baltimore <- filter(NEI, fips == "24510")

# compute total annual emissions
totalEmissions <- aggregate(Emissions ~ year + type, baltimore, sum)

#
# generate PNG plot
#
# open graphics device
png("plot3.png",
    width = 480,
    height = 480)

# generate the plot
plot(totalEmissions$year,
     totalEmissions$Emissions,
     type = "b",
     pch = 19,
     col = "blue",
     xlab = "Year",
     ylim = c(1500,3500),
     ylab = "Total PM2.5 Emissions (tons)",
     main = "Total PM2.5 Emissions in Baltimore City, Maryland\nAnnually from 1999 to 2008")

# close graphics device
dev.off()
