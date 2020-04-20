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


histogram <- as.numeric(homePowerFiltered$Global_active_power)

hist(histogram, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()
