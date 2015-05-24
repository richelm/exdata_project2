# -------------------------------------------------------------------
# FILE: plot5.R
# Course: Exploratory Data Analysis
# Project: 2
#
# R script to generate the fifth plot for the project.
#
# To run this script you will need to have the project data files
# Source_Classification_Code.rds and summarySCC_PM25.rds in your
# working directory and have your working directory set properly.
# Setting the working_dir variable should be the only change needed.
# The plot generated, plot5.png, too will be in the working directory.
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
baltimore <- NEI %>% 
             filter(fips == "24510",type == "ON-ROAD")

# compute total annual emissions
totalEmissions <- aggregate(Emissions ~ year, baltimore, sum)

#
# generate PNG plot
#
plot5 <- qplot(data=totalEmissions,
               x = year,
               y = Emissions,
               geom = c("point","line"),
               ylab = "Emissions (tons)",
               main = "Motor Vehicle Emissions Baltmore City, MD\nFor years 1999 to 2008")

# save it to file
ggsave(plot5,file="plot5.png", width = 6.7, height = 6.7, dpi = 72)
