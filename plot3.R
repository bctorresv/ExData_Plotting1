# EDA course
# Project 1
# Plot 3
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

plot3.dat <- power.dat %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

dim(plot3.dat) 

# ***********************************
# Making the plot
# ***********************************

with(plot3.dat, plot(Sub_metering_1 ~ Date.Time, type="l", 
                     xlab= "", 
                     ylab="Energy Sub Metering",
                     ylim = c(0, 37.5)))
with(plot3.dat,lines(Sub_metering_2 ~ Date.Time, col = "Red"))
with(plot3.dat,lines(Sub_metering_3 ~ Date.Time, col = "Blue"))
legend("topright", inset=0,
       lty=1, lwd =3, 
       col=c("black","red","blue") ,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       box.col="black", y.intersp = 0.6,
       cex=1, 
       x.intersp=0.1)
dev.copy(png, file="plot3.png")
dev.off 


