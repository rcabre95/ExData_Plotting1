# setwd("~/Downloads/")
# data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
## The above comment is how I read the data into R from my 
## local drive. However, below is a general method of loading
## this data.
data <- read.table(file.choose(), header = TRUE, sep = ";", stringsAsFactors = FALSE)
#



# clean data
data[,1] <- as.Date(data[,1], "%d/%m/%Y")
for (i in 3:9){
    data[,i] <- as.numeric(data[,i])
}
data <- subset(data, data[,1] >= as.Date("2007-02-01"))
data <- subset(data, data[,1] < as.Date("2007-02-03"))
# 

# Create plot
attach(data)
png("plot1.png")
hist(as.numeric(Global_active_power),
     main = "Global Active Power",
     xlab = "Global Avtive Power (kilowatts)",
     ylab = "Frequency",
     nclass = 12,
     col = "orangered1"
     )
dev.off()
#

# clean up
rm(list = ls())
#