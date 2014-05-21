acs=read.csv("getdata-data-ss06pid.csv")

4. Data off a webpage

con = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode=readLines(con)
close(con)

head(htmlCode)
nchar(htmlCode[c(10,20,30,100)])

5. For -file


data=read.fwf("getdata-wksst8110.for", widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), stringsAsFactors = FALSE)
#or data2=read.fwf("getdata-wksst8110.for", widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip=4)
#ohterwise transforms data into factors

head(data)
str(data)
dim(data)

col4=as.numeric(data[5:1258,4])
sum(col4)

