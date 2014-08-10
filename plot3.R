## plot3
## Energy submetering

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

# open .txt file for reading
tmp1 <- file(dataName, "r")

# find the lines with dates 1/2/2007 through 2/2/2007, save as "proj1.txt"
cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(tmp1), value=TRUE), sep="\n", file="proj1.txt")
close(tmp1)
# read the selected data into memory
proj1 <- fread("proj1.txt", sep=";", header=TRUE, na.strings="?")

# convert dates. NB capital "Y" because year=yyyy
proj1$Date <- as.Date(proj1$Date, "%d/%m/%Y")
#convert to "date time" string to be later converted as.POSIXct
tmp <- paste(as.character(proj1$Date), proj1$Time, sep=" ")

# plot data in "plot2.png" file
png("plot3.png")
plot(as.POSIXct(tmp),proj1$Sub_metering_1, 
     xlab="", type="l", ylab="Energy sub metering")
# add more lines to the same plot
lines(as.POSIXct(tmp),proj1$Sub_metering_2,col="red")
lines(as.POSIXct(tmp),proj1$Sub_metering_3,col="blue") 
# add a legend 
legend("topright", cex=1, col=c("black", "red", "blue"), 
       lwd=1,y.intersp=1,xjust=1,text.width = strwidth("Sub_metering_1"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()