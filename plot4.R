install.packages("RCurl")
library(RCurl)

# Create a folder called elecpowcon in my working directory, if it doesnot exist already.
if (!file.exists("elecpowcon")){
  dir.create("elecpowcon")
}

# Assign the url to a handle; download the file in the directory created; give the file a name; 
# use approprite extension; check download date and list of files in folder; and check structure

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./elecpowcon/household_power_consumption.txt", method ="curl")

downloadDate <- date()
downloadDate
list.files("./elecpowcon")

homePower <- read.table("elecpowcon/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")  
head(homePower, n=2)
str(homePower)

# Create a new data frame based on subsetting by the dates 1/2/2007 and 2/2/2007; check the structure; 
# look at a few rows of the new data frame

homePowerFiltered <- subset(homePower,homePower$Date=="1/2/2007" | homePower$Date =="2/2/2007")
str(homePowerFiltered)
head(homePowerFiltered, n=2)


dateChange <- strptime(paste(homePowerFiltered$Date, homePowerFiltered$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

par(mfcol = c(2, 2)) 
par(mar = c(4,4,1,1)) 

# plot top left
plot(dateChange, line, type="l", xlab="", ylab="Global Active Power (kilowatts)") 

# plot bottom left
plot(dateChange, submeter1, type='l', xlab="", ylab="Energy sub metering")
lines(dateChange, submeter2, type="l", col="red")
lines(dateChange, submeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

# plot top right 
voltage <- as.numeric(homePowerFiltered$Voltage)    
plot(dateChange, voltage, type="l", xlab="datetime", ylab="Voltage")

# plot bottom right 
greactivepow <- as.numeric(homePowerFiltered$Global_reactive_power)  
plot(dateChange, greactivepow, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png")
dev.off()
