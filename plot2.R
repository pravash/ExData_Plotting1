## plot2
## Fluctuations of Global Active Power during the week 

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

# convert dates. NB capital "Y" because year=yyyy
proj1$Date <- as.Date(proj1$Date, "%d/%m/%Y")
#convert to "date time" string to be later converted as.POSIXct
tmp <- paste(as.character(proj1$Date), proj1$Time, sep=" ")

# plot data in "plot2.png" file
png("plot2.png")
plot(as.POSIXct(tmp), proj1$Global_active_power, 
     xlab="", type="l", ylab="Global Active Power (kilowatts)")
dev.off()
