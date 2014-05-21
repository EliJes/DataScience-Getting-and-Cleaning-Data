# 1.
data=read.csv("getdata-data-ss06hid.csv")
head(data)

data2=subset(data, data$VAL==24)
length(data2)
dim(data2)
str(data2)

# 3. 
library(xlsx)

file="C:/Users/Elina/Dataa/getdata-data-DATA.gov_NGAP.xlsx"
data=read.xlsx(file,sheetIndex=1, header=TRUE, startColumn=7, endColumn=15, startRow=18, endRow=23, colClasses=rep("numeric", 9)) 
sum(data$Zip*data$Ext,na.rm=T)
str(data)
head(data)

# 4.

library(XML)
require(RCurl)
fileUrl= "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"

doc = xmlParse(fileUrl, useInternal=TRUE) #If this doesn't work (gives errors), try:

#download.file(fileUrl,"restaurants.xml") 
#doc = xmlParse("restaurants.xml")

rootNode = xmlRoot(doc) #The "wrapper" of the document
names(rootNode)
rootNode[[1]][[1]]

out = getNodeSet(doc, "//zipcode")
zipit= xmlToDataFrame(out)
length(zipit[zipit[,1]=="21231",]) #ne rivit, joilla sarakkeen 1 arvo on 21231

# 5.

fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,"housing.xml") 

library(data.table)

DT=data.table(fread("housing.xml"))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))            
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))           
system.time(rowMeans(DT)[DT$SEX==1])+system.time(rowMeans(DT)[DT$SEX==2]) 
system.time(mean(DT[DT$SEX==1,]$pwgtp15))+system.time(mean(DT[DT$SEX==2,]$pwgtp15))            
system.time(DT[,mean(pwgtp15),by=SEX])            

## searching for a difference between alternatives 2 ("mean...") and 3 ("sapply...")
# 2 ("mean...")
data(DT)
trial_size <- 200
collected_results <- numeric(trial_size)
for (i in 1:trial_size){
  single_function_time <- system.time(mean(DT$pwgtp15,by=DT$SEX))
  collected_results[i] <- single_function_time[1]
}
print(mean(collected_results))

3 ("sapply...")
data(DT)
trial_size <- 200
collected_results <- numeric(trial_size)
for (i in 1:trial_size){
  single_function_time <- system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
  collected_results[i] <- single_function_time[1]
}
print(mean(collected_results))

## With microbenchmark

library(microbenchmark)

f1 <- function(DT) {tapply(DT$pwgtp15,DT$SEX,mean)}
f2 <- function(DT) {mean(DT$pwgtp15,by=DT$SEX)}
f3 <- function(DT) {sapply(split(DT$pwgtp15,DT$SEX),mean)}
#f4 <- function(DT) {rowMeans(DT)[DT$SEX==1]}
f5 <- function(DT) {mean(DT[DT$SEX==1,]$pwgtp15)}
f6 <- function(DT) {DT[,mean(pwgtp15),by=SEX]}

res <- microbenchmark(
  mean(DT), 
  f1(DT),
  f2(DT), 
  f3(DT),
  #f4(DT),
  f5(DT), 
  f6(DT),
  times=1000L)

print(res)
