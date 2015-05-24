# -------------------------------------------------------------------
# FILE: plot1.R
# Course: Exploratory Data Analysis
# Project: 2
#
# R script to generate the first plot for the project.
#
# To run this script you will need to have the project data files 
# Source_Classification_Code.rds and summarySCC_PM25.rds in your 
# working directory and have your working directory set properly. 
# Setting the working_dir variable should be the only change needed. 
# The plot generated, plot1.png, too will be in the working directory.
#
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

#
# Read summarySCC_PM25 data file
#
NEI <- readRDS("summarySCC_PM25.rds")

# compute total annual emissions
totalEmissions <- aggregate(Emissions ~ year, NEI, sum)

#
# generate PNG plot
#
# open graphics device
png("plot1.png",
    width = 480,
    height = 480)

# generate the plot
# to avoid getting PM2.5 expressed in scientific notation,
# divide by 1,000,000 and round to 1 digit
plot(totalEmissions$year,
     # express PM2.5 in millions of tons
     round(totalEmissions$Emissions/1000000, digits = 1),
     type = "b",
     pch = 19,
     col = "blue",
     ylim = c(3.0,8.0),
     xlab = "Year",
     ylab = "Total PM2.5 Emissions (millons of tons)",
     main = "Total PM2.5 Emissions in United States\nAnnually from 1999 to 2008",
     panel.first = grid()
)

# close graphics device
dev.off()
