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
# The plot generated, plot3.png, too will be in the working directory.
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
baltimore <- filter(NEI, fips == "24510")

# compute total annual emissions
totalEmissions <- aggregate(Emissions ~ year + type, baltimore, sum)

# generate the plot
plot3 <- qplot(data=totalEmissions,
      x = year,
      y = Emissions,
      color = type,
      facets = ~type,
      geom = c("point","line"),
      ylab = "Emissions (tons)",
      main = "Emissions from the Four Types of Sources in Baltmore City, MD\nFor years 1999 to 2008")

# save it to file
ggsave(plot3,file="plot3.png", width = 6.7, height = 6.7, dpi = 72)
