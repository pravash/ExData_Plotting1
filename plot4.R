## plot4
## Different energy categories

# will use fread from "data.table"
library(data.table) 
library(ggplot2)

## open file connection and donwload .zip file
tmp<- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",tmp)

## get the .txt filename
dataName <- unzip(tmp, list=TRUE)$Name

# remove link to temp
unlink(tmp)

# find the lines with dates 1/2/2007 through 2/2/2007, save as "proj1.txt"
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(dataName), value=TRUE), sep="\n", file="proj1.txt")

# read the selected data into memory
proj1 <- fread("proj1.txt", sep=";", header=TRUE, na.strings="?")

# convert dates. NB capital "Y" because year=yyyy
proj1$Date <- as.Date(proj1$Date, "%d/%m/%Y")
#convert to "date time" string to be later converted as.POSIXct
datetime <- as.POSIXct(paste(as.character(proj1$Date), proj1$Time, sep=" "))

# plot data in "plot4.png" file
png("plot4.png")
par(mfrow=c(2,2))
# plot topleft
with(proj1, plot(datetime, Global_active_power, 
     xlab="", type="l", ylab="Global Active Power"))
# plot topright
with(proj1, plot(datetime,Voltage, type="l")
# plot bottom left
with(proj1, plot(datetime,Sub_metering_1, 
     xlab="", type="l", ylab="Energy sub metering"))
with(proj1,lines(datetime,Sub_metering_2,col="red"))
with(proj1,lines(datetime,Sub_metering_3,col="blue") 
legend("topright", cex=1, col=c("black", "red", "blue"),lwd=2,bty="n",
       y.intersp=0.8,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# plot bottomright
with(proj1, plot(datetime, Global_reactive_power, type="l"))
dev.off()