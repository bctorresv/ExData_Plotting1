# EDA course
# Project 1
# Plot 4
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

plot4.dat <- power.dat %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

dim(plot4.dat) 

# ***********************************
# Making the plot
# ***********************************
par(mfrow=c(2,2))
# Plot 1
with(plot4.dat, plot(Global_active_power ~ Date.Time, 
                     type="l", 
                     xlab="",
                     ylab="Global active power"))

# Plot 2
with(plot4.dat, plot(Voltage ~ Date.Time, type="l", xlab="datetime"))

#Plot 3
with(plot4.dat, plot(Sub_metering_1 ~ Date.Time, type="l", 
                     xlab= "", 
                     ylab="Energy Sub Metering",
                     ylim = c(0, 37.5)))
with(plot4.dat,lines(Sub_metering_2 ~ Date.Time, col = "Red"))
with(plot4.dat,lines(Sub_metering_3 ~ Date.Time, col = "Blue"))
legend("topright", inset=0,
       lty=1, lwd =2, 
       col=c("black","red","blue") ,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       y.intersp = 0.6,
       cex=0.8, 
       x.intersp=0.1)

# Plot 4
with(plot4.dat, plot(Global_reactive_power ~ Date.Time, 
                     type="l",
                     xlab="datetime"))

dev.copy(png, file="plot4.png")
dev.off 

