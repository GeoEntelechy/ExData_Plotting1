#plot2 in EDA course, project 1

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
dfsub = df[df$Date %in% c("2/2/2007","1/2/2007"),]

#Create dates object vector
dates = with(dfsub,strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))

#Create the plot
png(filename="./plots/plot2.png",width=480,height=480)
par(fg="black",mar=c(3,4,2,2))
plot(dates,dfsub$Global_active_power,type="l",ylab="Global Active Power (killowatts)",xlab="")
dev.off()
