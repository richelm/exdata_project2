#!/bin/sh

# remove all existing plots
rm *.png

# create each plot
R -f plot1.R
R -f plot2.R
R -f plot3.R
R -f plot4.R
R -f plot5.R
R -f plot6.R
