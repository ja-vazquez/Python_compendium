



########################################
########## Data management


manager <- c(1,2,3,4,5)
date <- c("10/24/08","10/28/08","10/1/08","10/12/08","5/1/09")
gender <- c("M","F","F","M","F")
age <- c(32,45,25,39,99)
q1 <- c(5,3,3,3,2)
q2 <- c(4,5,5,3,2)
q3 <- c(5,2,5,4,1)
q4 <- c(5,5,5,NA,2)
q5 <- c(5,5,2,NA,1)

leadership <- data.frame(manager,date,gender,age,q1,q2,q3,q4,q5, stringsAsFactors=FALSE)
leadership

mydata<-data.frame(x1 = c(2, 2, 6, 4), x2 = c(3, 4, 2, 8))

mydata$sumx <- mydata$x1 + mydata$x2

#or could be
attach(mydata)
mydata$sumx <- x1 + x2
detach(mydata)

#or 
mydata <- transform(mydata, sumx=x1 + x2)



#### Recoding variables
leadership <- within(leadership, {
              agecat <- NA
              agecat[age > 75]               <- 'Elder'
              agecat[age >= 55 & age <= 75]  <- 'Middle age'
              agecat[age < 55]               <- 'Young'
              })
leadership

#Rename some variables
names(leadership)[2] <- 'testDate'
names(leadership)


# or we can use the plyr package

#install.packages("plyr")
library(plyr)

leadership <- rename(leadership, c(manager="managerID", testDate='testDate2'))
leadership


########## Missing values 

y <- c(1,2,3, NA)
is.na(y)

x <- c(1, 2, NA, 3)
y <- x[1]+ x[2]+ x[3]+ x[4]
sum(x); y
sum(x, na.rm = TRUE)  #removes missing data


#na.omits deletes any rows with missing data
leadership
newdata <- na.omit(leadership)
newdata


########## Date values

mydates <- as.Date(c("2007-06-22", "2004-02-13"))

#to conver the character data to dates
strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y")
dates

# Today's date
today <- Sys.Date()
format(today, format="%B %d %Y")
format(today, format="%A")   #day name's name

# Operations with dates
startdate <- as.Date("2004-02-13")
enddate   <- as.Date("2011-01-22")
days      <- enddate - startdate
days

# in weeks
difftime(enddate, startdate, units='weeks')

# for type convertions use (same for different types)
a <- c(1, 2, 3)
as.character(a)


########## Sorting data

attach(leadership)
newdata <- leadership[order(gender, -age), ]
newdata
detach(leadership)


########## Merging datasets

total <- merge(dataframeA, dataframeB, by= "ID")

#Horizontal concatenation
total <- cbind(A, B)

#Join two frames vertically
total <- rbind(dataframeA, dataframeB)



########## Subsetting datasets

newdata <- leadership[, c(6:10)]
newdata

myvars <- c("q1", "q2", "q3", "q4", "q5")
newdata <- leadership[myvars]



#Excluding variables

myvars <- names(leadership) %in% c("q3", "q4")
newdata <- leadership[!myvars]

#or 
newdata <- leadership[c(-8, -9)]

#Selecting observations

attach(leadership)
newdata <- leadership[gender == 'M' & age > 30, ]
detach(leadership)


#The subset() function

newdata <- subset(leadership, age >= 35 | age <24, 
                  select = c(q1, q2, q3, q4))




