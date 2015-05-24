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
# The plot generated, plot6.png, too will be in the working directory.
#
# Required packages: dplyr
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

#
# Read summarySCC_PM25 data file
#
NEI <- readRDS("summarySCC_PM25.rds")

# filter out Baltimore City, Maryland (fips == "24510")
#   and Los Angeles County, California (fips == "06037")
#   and motor vehicle sources (type == "ON-ROAD")
baltimore <- NEI %>% filter(fips == "24510", type == "ON-ROAD")
la_county <- NEI %>% filter(fips == "06037", type == "ON-ROAD")

# compute total annual emissions
# for baltimore
tae_baltimore  <- aggregate(Emissions ~ year, baltimore, sum)
# for la county
tae_la_county  <- aggregate(Emissions ~ year, la_county, sum)

#
# generate the plots for baltimore and la county each in a 
# separate graph stacked vertically. add regression lines to
# visually illustrate the amount of change for each.
#
# open PNG graphics device
png("plot6.png",
    width = 480,
    height = 720)

# place plots vertically
par(mfcol = c(2,1))

# plot data for Baltimore City, MD
x <- tae_baltimore$year
y <- tae_baltimore$Emissions
plot(x,y,
     xlab = "Year",
     ylab = "Emissions (tons)",
     main = "Motor Vehicle Emissions for Baltimore, MD",
     pch = 15,
     col = "blue",
     panel.first = grid()
)
# add regression line
line.fit <- lm(y ~ x)
summary(line.fit)
abline(line.fit)

# plot data for Los Angeles County, CA
x <- tae_la_county$year
y <- tae_la_county$Emissions

plot(x,y,
     xlab = "Year",
     ylab = "Emissions (tons)",
     main = "Motor Vehicle Emissions for Los Angeles County, CA",
     pch = 15,
     col = "blue",
     panel.first = grid()
)
# add regression line
line.fit <- lm(y ~ x)
summary(line.fit)
abline(line.fit)

# close graphics device
dev.off()
