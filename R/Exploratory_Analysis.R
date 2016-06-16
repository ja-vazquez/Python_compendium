


######## Descriptive Statistics & Exploratory Data Analysis


install.packages("astrodatR")
library(astrodatR)

#Hipparchos stars
data(HIP)

######## Numerical Summaries

# description of the data
dim(HIP)
names(HIP) 
HIP[1,]
#also with $ sign to access columns
HIP$RA

class(HIP[,1])
class(HIP$RA)

names(HIP[7])
HIP[1:20,7]
sum(HIP[,3])

HIP[9]

#get some stats
for(i in 1:ncol(HIP)){
  print(c(max(HIP[,i]),min(HIP[,i]), 
          median(HIP[,i]),mad(HIP[,i]))) 
}

# for rows use 1 : apply(HIP,1,max)
apply(HIP,2,max) 
apply(HIP,2,min) 
apply(HIP,2,median) 
apply(HIP,2,mad)

# how many and where are NA
sum(is.na(HIP[,9]))
which(is.na(HIP[,9]))

# omit NA and run same loop
y <- na.omit(HIP)
for(i in 1:ncol(y)) {
  print(c(max(y[,i]),min(y[,i]), 
          median(y[,i]),mad(y[,i]))) 
}

# or do the same for each function
for(i in 1:ncol(HIP)) {
  print(c(max(HIP[,i],na.rm=T),min(HIP[,i],na.rm=T), 
          median(HIP[,i],na.rm=T),mad(HIP[,i],na.rm=T))) 
}

sort(HIP[1:10,3])
#sort all columns based on col 3
HIP[order(HIP[1:10,3]),]

#work on column names
names(HIP)
attach(HIP)

#Summary function will do the job
summary(Vmag)
summary(B.V)