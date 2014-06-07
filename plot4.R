#plot4 in EDA course, project 1

setwd("/Users/yakich/vrygit/eda")

library(data.table)

#Prepare the directory structure, if not already created
if(!file.exists("./project1")){
    dir.create("./project1")
}
setwd("./project1/")
if(!file.exists("./data")){
    dir.create("./data")
}
if(!file.exists("./plots")){
    dir.create("./plots")
}

#Download and unzip data, if not already available
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfilepath = "./data/electric_power_consumption.zip"
unzipfilepath = "./data/household_power_consumption.txt"
if(!file.exists(zipfilepath)){
    download.file(fileUrl,destfile=zipfilepath,method="curl")
}
if(!file.exists(unzipfilepath)){
    unzip(zipfilepath,exdir="./data")
}

#Load data
df = read.table(unzipfilepath,header=TRUE,sep=";",na.strings="?")

#Filter to the two days we care about
dfsub = df[df$Date %in% c("1/2/2007","2/2/2007"),]

#set up 4x4 frame and open the file device
png(filename="./plots/plot4.png",width=480,height=480)
par(mfcol=c(2,2),mar=c(4,4,4,2))

#Create dates object vector
dates = with(dfsub,strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))

#TOP LEFT - Same as plot 2, except for ylabel and margins
    par(fg="black")
    plot(dates,dfsub$Global_active_power,type="l",
         ylab="Global Active Power",xlab="")

#LOWER LEFT - Same as plot 3, except for the margin and the border around the legend
    #Create the plot
    par(fg="black")
    plot(dates,dfsub$Sub_metering_1,type="n",ylab="Energy sub metering",xlab="")
    lines(dates,dfsub$Sub_metering_1,col="black")
    lines(dates,dfsub$Sub_metering_2,col="red")
    lines(dates,dfsub$Sub_metering_3,col="blue")
    legend("topright",col=c("black","red","blue"),
           lwd=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
           box.col="transparent",box.lwd=0,bg="transparent")

#TOP RIGHT - Similar to top left, but for Voltage and adding xlabel
    par(fg="black")
    plot(dates,dfsub$Voltage,type="l",
         ylab="Voltage",xlab="datetime")

#TOP RIGHT - Similar to top right, but for Global_reactive_power
    par(fg="black")
    plot(dates,dfsub$Global_reactive_power,type="l",
         ylab="Global_reactive_power",xlab="datetime")


#close the file device
dev.off()