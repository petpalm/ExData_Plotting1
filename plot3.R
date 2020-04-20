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
submeter1 <- as.numeric(homePowerFiltered$Sub_metering_1)
submeter2 <- as.numeric(homePowerFiltered$Sub_metering_2)
submeter3 <- as.numeric(homePowerFiltered$Sub_metering_3)

plot(dateChange, submeter1, type='l', xlab="", ylab="Energy sub metering")
lines(dateChange, submeter2, type="l", col="red")
lines(dateChange, submeter3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.copy(png, file="plot3.png")
dev.off()


