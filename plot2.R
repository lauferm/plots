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



# create second plot and store in filename
png(filename="plot2.png",width=480,height = 480)
plot(samp$dtime,gap,ylab="Global Active Power (kilowatts)",xlab="",type="ljoin")
dev.off()
