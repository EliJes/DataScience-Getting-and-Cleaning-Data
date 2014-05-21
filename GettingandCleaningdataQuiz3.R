Quiz3

Q1.

data=read.csv("getdata-data-ss06hid.csv")

agricultureLogical = which(data$ACR==3 & data$AGS==6)

head(agricultureLogical)

#125, 238, 262

Q2.

install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "photo.jpg", mode="wb")
img=readJPEG("photo.jpg", native=TRUE)
quantile(img, probs = seq(0, 1, 0.1))

# -15259150 -10575416

Q3.

edstats= read.csv("getdata-data-EDSTATS_Country.csv", stringsAsFactors = FALSE)
gdp=read.csv("getdata-data-GDP.csv", stringsAsFactors = FALSE)
head(edstats)
head(gdp,20)
dim(gdp)
str(gdp)

#Match the data based on the country shortcode. How many of the IDs match?

data = merge(edstats, gdp[which(gdp$Gross.domestic.product.2012!=""),], by.x = "CountryCode", by.y = "X")
length(data$CountryCode)
# 189

# Sort the data frame in descending order by GDP rank. 
# What is the 13th country in the resulting data frame? 

data$Gross.domestic.product.2012=as.numeric(data$Gross.domestic.product.2012)
sort_data=data[order(data$Gross.domestic.product.2012, decreasing = TRUE),]
str(sort_data)
sort_data$Short.Name[13]
# St. Kitts and Nevis

Q4.
#What is the average GDP ranking for the "High income: OECD" and 
#"High income: nonOECD" group?

data$Gross.domestic.product.2012=as.numeric(data$Gross.domestic.product.2012)
df=na.omit(data[,c("Income.Group", "Gross.domestic.product.2012")])
aggregate(df$Gross.domestic.product.2012, by=list(df$Income.Group), FUN =mean)

#1 High income: nonOECD  91.91304
#2 High income: OECD  32.96667

Q5.
#Cut the GDP ranking into 5 separate quantile groups. 
#Make a table versus Income.Group. 
#How many countries are Lower middle income,
#but among the 38 nations with highest GDP?

data$quant=cut(data$Gross.domestic.product.2012, breaks=quantile(data$Gross.domestic.product.2012, probs = seq(0, 1, 0.2), na.rm=TRUE))
table(data$quant, data$Income.Group)
