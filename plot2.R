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
data[,2] <- rep(0, 2880)
for (i in 2:2880){
    data[i,2] <- data[i-1,2]+1
}
# 

# plot data
attach(data)

xtick = c(0,1440,2880)
xlabs = c("Thu", "Fri", "Sat")

png("plot2.png")
plot(y = Global_active_power, x = as.character(Time),
     main = NULL,
     ylab = "Global Active Power (kilowatts)",
     xaxt= "n",
     type = "l",
     xlab = " "
)
axis(side=1, at= xtick, labels = xlabs)
dev.off()
#

# clean up
rm(list = ls())
#