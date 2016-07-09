

########################################
########## Introduction to R

### Getting help

help.start()

help(sd) # or ?sd
example(sd)

#Don't run
#save.image("Foo.RData")

#Don't run
#load("Foo.RData")

install.packages('vcd')
help(package="vcd")
library(vcd)
help("Arthritis")
example("Arthritis")

### The workspace

#current directory
getwd()
setwd("mydirectory")
ls()


########################################
########## Data structures


########## Vectors
a <- c("k", "j", "h", "a", "c", "m")
b <- c(1, 2, 3, 4, 5)

# Slicing on vectors
a[3]
a[c(1,3,5)]
a[2:6]


vec1 <- c(1,9,3,-10,pi); vec1

vec2 <- 1:50; vec2
vec3 <- seq(from=-2*pi, to=2*pi, length=50); vec3

#minus position, removes that element (not like python)
vec2[-1] 
length(vec2[-1])

#to select the last element 
tail(vec2, 2)

#element-wise operations
(vec2+vec3)^2
vec2-10

#Mathematical functions
exp(1)
sqrt(16)
log10(100)
log(100)
cos(2*pi)

#comparing vectors
a <- c(1,2); b <- c(1,3)
a==b
#compare the full vector
identical(a,b)

#Boolean functions
a <- c(TRUE,TRUE,FALSE,FALSE)
b <- c(TRUE,FALSE,TRUE,FALSE)
!a
a & b
a | b
xor(a,b)

#dealing with missing data
na.vec <- c(1:3,NA,5:7,NaN)
3*na.vec

#to eliminate NA, use na.rm
mean(na.vec, na.rm=T)

0/0
Inf-Inf


########## Matrices

y <- matrix(1:20, nrow=5, ncol=4)


#a more elaborated matrix; filled in by row
cells <- c(1, 26, 24, 68)
rnames <- c("R1", "R2")
cnames <- c("C1", "C2")

mymatrix <- matrix(cells, nrow=2, ncol=2, byrow=TRUE,
                   dimnames=list(rnames, cnames))
mymatrix
#if filled by columns, use byrow=FALSE


## Usiing matrix subscripts

x <- matrix(1:10, nrow = 2)
x

x[,2]
x[1,4]
x[1, c(4, 5)]   #first row and the forth and fifth columns

tmp <- 1:4
mat1 <- matrix(tmp, nrow=2, ncol=2)
mat1

#Maths with matrices (element-wise)
mat1 + mat1

# curv product
mat1 %*% mat1 

#and element-wise
mat1 * mat1


########## Arrays

# are similar to matrices, but can have more than two dimensions.
# myarray <- array(vector, dimensions, dimnames)

dim1 <- c("A1", "A2")
dim2 <- c("B1", "B2", "B3")
dim3 <- c("C1", "C2", "C3", "C4")

#dimensions 2,3,4
z <- array(1:24, c(2, 3, 4), dimnames=list(dim1, dim2, dim3))
z



########## Data Frames

# different columns can contain different modes of data
# mydata <- data.frame(col1, col2, col3, ...)

patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)

patientdata[1:2]
patientdata[c("diabetes", "status")]
patientdata$age

table(patientdata$diabetes, patientdata$status)



########## Attach, Detach and With

# instead of using $ everytime, as
summary(mtcars$mpg)
plot(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$wt)


#can also be written as follows:
attach(mtcars)
  summary(mpg)
  plot(mpg, disp)
  plot(mpg, wt)
detach(mtcars)
  
#or alternatively
with (mtcars, {
  print(summary(mpg))
  plot(mpg, disp)
  plot(mpg, wt)
})


########## Factors
# are categorical (nominal) and ordered categorical (ordinal) variables


patientID <- c(1, 2, 3, 4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")

diabetes <- factor(diabetes)          #will store a vector ordered [1,2,1,1]
status <- factor(status, order=TRUE)  #will order from poor to excellent, and group by

patientdata <- data.frame(patientID, age, diabetes, status)

summary(patientdata)


########## Lists

# is an ordered collection of objects (components)

g <- "My first list"
h <- c(25, 26, 18, 39)
j <- matrix(1:10, nrow=5)
k <- c("one", "two", "three")
mylist <- list(title=g, ages= h, j, k)
mylist


list1 <- list(V1=vec1, V2=vec2, M1=mat1)
list1


# access to the list
list1$M1

#element-wise functions
lapply(list1, FUN=sum)

#a user-friendly version and wrapper of lapply
sapply(list1, FUN=sum)

#defining functions
ratio <- function(x,y) x**2/y

ratio(3,6)



########################################
########## Data input

#The edit() function in R invokes a text editor that lets you
# enter data manually


mydata <- data.frame(age= numeric(0), weight=numeric(0))
mydata <- edit(mydata)


## Importing data from a delimited text file
#   mydataframe <- read.table(file, options)

setwd("/Users/josevazquezgonzalez/Desktop/Programs/Python_compendium/data")

message <- read.table("ex5.csv", header = TRUE, sep=',', row.names="something")
message
str(message)


# including the option stringsAsFactors=FALSE turns off character behaviour


message <- read.table("ex5.csv", header = TRUE, sep=',',
            row.names="something", 
            colClasses = c("character", "numeric", "numeric", "numeric", "numeric", "character"))
message
str(message)


####### Import data from Excel

library(xlsx)
workbook <- "c:/myworkbook.xlsx"
mydataframe <- read.xlsx(workbook, 1)


########## Accessing database managements systems (DBMSs)
## RMySQL

install.packages("RMySQL")
library(RMySQL)
??RMySQL

## Connecting to MySQL:
mydb = dbConnect(MySQL(), user='root', password='pwd', dbname='countries', host='localhost')

## Listing Tables and Fields:
dbListTables(mydb)
dbListFields(mydb, 'classics')


## Running Queries:
rs = dbSendQuery(mydb, 'SELECT * FROM country')

# n = number of records to retrieve
data = dbFetch(rs, n=-1)
data

dbDisconnect(mydb)


