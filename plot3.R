plot3 <- function() {

## Show a message on screen to wait up to end of process
message("The script is running, Please wait...")  
message("  ")  

  
## Create EDACP1 folder for data as abbrivation of Exploratory Data Analysis Course Project 1
if(!file.exists("./EDACP1")){ 
  dir.create("./EDACP1") 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "EDACP1/dataset.zip") 
  data.downloaded = date()
  unzip("EDACP1/dataset.zip", exdir = "EDACP1")
}
## set "EDACP1" as current working directory if it's not.
if (!grepl("/EDACP1", getwd())) {
  setwd("./EDACP1")  
}


## A rough estimate of how much memory the dataset will require in memory before reading into R.
## The dataset has 2,075,259 rows and 9 columns. 
## 8 bytes estimated per value 
## 2^20 is 1 MB 
## As a result, The total memory which is needed is about 143MB
memory_needed <- (2075259 * 9 * 8) / (2^20)
message("Free RAM requirments: ",round(memory_needed), " MB")  
message("  ")
message("Processing...")
message("  ")


## Reading DataSet 
All_Rows <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";")


## seperating dates 2007-02-01 and 2007-02-02
subSetRows <- All_Rows[All_Rows$Date %in% c("1/2/2007","2/2/2007") ,]



## Generate Plot and Lines
plot(strptime(paste(subSetRows$Date, subSetRows$Time, sep=" "), "%d/%m/%Y %H:%M:%S"), 
     as.numeric(as.character(subSetRows$Sub_metering_1)), type="l", ylab="Energy Submetering", xlab="")
lines(strptime(paste(subSetRows$Date, subSetRows$Time, sep=" "), "%d/%m/%Y %H:%M:%S"), 
      as.numeric(as.character(subSetRows$Sub_metering_2)), type="l", col="red")
lines(strptime(paste(subSetRows$Date, subSetRows$Time, sep=" "), "%d/%m/%Y %H:%M:%S"), 
      as.numeric(as.character(subSetRows$Sub_metering_3)), type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=1.5, col=c("black", "red", "blue"))


## Saving to file plot3.png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()


## Go back to Home directory
setwd("../")


## Process is finished.
message("The process of script is finished and plot3.png is created.")  

}
