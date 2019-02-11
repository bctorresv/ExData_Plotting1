# EDA course
# Project 1
# Plot 2
# Author: Brenda C. Torres-Velasquez

# Working directory: this is my working directory
#setwd("C:/Users/BrendaCarolina/Desktop/Coursera/EDACourse")

# *******************************
# Libraries
# *******************************
library("dplyr", lib.loc="~/R/win-library/3.4")

# *******************************
# Reading the data
# ******************************

temp.file <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp.file)
unzip(temp.file)
list.files()
#[1] "EDACourse.Rproj"                            
#[2] "exdata_data_household_power_consumption.zip"
#[3] "household_power_consumption.txt"            
#[4] "lectures"                                   
#[5] "plot1.R" 

power.dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
class(power.dat) #[1] "data.frame"
dim(power.dat) #[1] 2075259       9

# Variables in dataframe 
colnames(power.dat)
#[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"               "Global_intensity"     
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3" 

# Creating variable of interest
power.dat$Date.Time <- with(power.dat, as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# *********************************** 
#  Filtering according request
# "We will only be using data from the dates 2007-02-01 and 2007-02-02"
# ***********************************
power.dat$Date <- as.Date(power.dat$Date, format = "%d/%m/%Y")

plot2.dat <- power.dat %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

dim(plot2.dat) #[1] 2880   10

# ***********************************
# Making the plot
# ***********************************

with(plot2.dat,
     plot(Global_active_power ~ Date.Time, type="l", xlab= "", ylab="Global Active power (kilowatts)"))
dev.copy(png, file="plot2.png")
dev.off 

