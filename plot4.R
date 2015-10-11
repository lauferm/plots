# set directory to where the file was downloaded
setwd("./Downloads")

# store the name of the file for ease of use
pow<-"household_power_consumption.txt"

# read in the file
power<-read.table(pow,head=TRUE,sep=";",stringsAsFactors = FALSE)

# a little late but review the GB (not bytes)
object.size(power)/(2^20)/1000

# set one variable x to the date+time based on 2 string columns
# store the date variable in a vector "powdte"
dates<-power[,1]
times<-power[,2]
x<-paste(dates,times)
powdte<-strptime(x,"%d/%m/%Y %H:%M:%S")
power$dtime<-powdte

# filter on appropriate dates
goodDate<-c("1/2/2007","2/2/2007")
gooddteIndex<-dates %in% goodDate
samp<-power[gooddteIndex,]

# UP TO HERE ALL SHARE

# create fourth plot and store in filename

png(filename="plot4.png")
par(mfrow=c(2,2))

# one
# numeric GAP with na
gap<-as.numeric(samp$Global_active_power,na.omit)

plot(samp$dtime,gap,ylab="Global Active Power (kilowatts)",xlab="",type="ljoin")

# two

# numeric GAP with na
volt<-as.numeric(samp$Voltage,na.omit)

plot(samp$dtime,volt,ylab="Voltage",xlab="datetime",type="ljoin")

# three
esm1<-as.numeric(samp$Sub_metering_1,na.omit)
esm2<-as.numeric(samp$Sub_metering_2,na.omit)
esm3<-as.numeric(samp$Sub_metering_3,na.omit)
par(cex=.8) # text size
plot(samp$dtime,esm1,ylab="Energy sub metering",xlab="",type="ljoin")
lines(samp$dtime,esm2,type="ljoin",col="red")
lines(samp$dtime,esm3,type="ljoin",col="blue")
#par(cex=.9)
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),lwd=c(2.5,2.5,2.5),col=c("black","red","blue"))

# four
grp<-as.numeric(samp$Global_reactive_power,na.omit)

plot(samp$dtime,grp,xlab="datetime",ylab="Global_reactive_power",type="ljoin")

#savePlot("plot4.png")
#dev.copy(png,"plot4.png")
dev.off()

