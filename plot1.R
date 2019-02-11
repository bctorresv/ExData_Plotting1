# EDA course
# Project 1
# Plot 1
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

# Preparing some variables
colnames(power.dat)
#[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"               "Global_intensity"     
#[7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3" 

# *********************************** 
# Preparing some variables
# *********************************** 
head(power.dat$Date, n=5) #[1] "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006"
power.dat$Date <- as.Date(power.dat$Date, format = "%d/%m/%Y")
head(power.dat$Date, n=5) #[1] "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16" "2006-12-16"

# *********************************** 
# Filtering according request
# "We will only be using data from the dates 2007-02-01 and 2007-02-02."
# ***********************************
power.dat <- power.dat %>%
            filter(Date >= "2007-02-01" & Date <= "2007-02-02")

dim(power.dat) #[1] 2880    9

# ************************
# Working with data
# ************************

# Global_active_power
class(power.dat$Global_active_power) #[1] "character"
power.dat$Global_active_power <- as.numeric(power.dat$Global_active_power)
class(power.dat$Global_active_power) #[1] "numeric"
summary(power.dat$Global_active_power)
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 0.220   0.320   1.060   1.213   1.688   7.482 

# ************************
# Making plot 1
# ************************
hist(power.dat$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     main="Global Active Power",
     ylim = c(0, 1250), 
     col = "red")
dev.copy(png, file="plot1.png")
dev.off  # Close de pdf device


