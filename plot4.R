# -------------------------------------------------------------------
# FILE: plot4.R
# Course: Exploratory Data Analysis
# Project: 2
#
# R script to generate the forth plot for the project.
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
library(ggplot2)

#
# Read summarySCC_PM25 data file
#
NEI <- readRDS("summarySCC_PM25.rds")

#
# Read source classification codes
SCC <- readRDS("Source_Classification_Code.rds")

# use EI.Sector column to determine coal combustion-related sources
SCC <- filter(SCC, grepl("Coal", EI.Sector))
coal_scc <- unique(as.character(SCC$SCC))

# filter out coal source in NEI data
NEI <- filter(NEI, SCC %in% coal_scc)

coalEmissions <- aggregate(Emissions ~ year, NEI, sum)

#
# generate PNG plot
#
plot4 <- qplot(data=coalEmissions,
      x = year,
      y = Emissions, 
      geom = c("point","line"),
      ylab = "Emissions (tons)", 
      main = "Emissions from Coal Combustion-Related Sources in US\nFor years 1999 to 2008")

# save it to file
ggsave(plot4,file="plot4.png", width = 6.7, height = 6.7, dpi = 72)
