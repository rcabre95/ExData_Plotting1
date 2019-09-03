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


png("plot4.png")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) # set parameters

## 1st plot
plot(y = Global_active_power, x = as.character(Time),
     main = NULL,
     ylab = "Global Active Power",
     xaxt= "n",
     type = "l",
     xlab = " "
)
axis(side=1, at= xtick, labels = xlabs)

## 2nd plot
plot(y = Voltage, x = Time,
     xlab = "datetime",
     xaxt = "n",
     ylab = "Voltage",
     type = "l"
     )
axis(side=1, at= xtick, labels = xlabs)

## 3rd plot
plot(x=Time,y=Sub_metering_1,
     ylab = "Energy sub metering",
     xlab = " ",
     xaxt = "n",
     col = "Black",
     type = "l"
)
lines(x=Time,y=Sub_metering_2,
      col = "Red"
)
lines(x=Time,y=Sub_metering_3,
      col = "Blue"
)
legend(x = 1000, y = 39,
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("Black","Red","Blue"),
       lty = 1,
       cex = 1.0,
       bty = "n"
)
axis(side=1, at= xtick, labels = xlabs)

# 4th plot
plot(y=Global_reactive_power,x=Time,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n",
     type = "l"
     )
axis(side=1, at= xtick, labels = xlabs)
dev.off()
#

# clean up
rm(list = ls())
#