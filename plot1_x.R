## plot1
## Global Active Power

# will use fread from "data.table"
library(data.table) 

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

# plot data into "plot1.png" file
png("plot1.png")
hist(proj1$Global_active_power, col="red", main="Global Active Power",
        xlab="Global Acitve Power (kilowatts)", ylab="Frequency")
dev.off()