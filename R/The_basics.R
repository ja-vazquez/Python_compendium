######################################################################
######## R Syntax


#Highlight this line and click "Run" at the top of the RStudio window.

# Asking for help (Standard Deviation)
?sd #You can also type ?"sd"

example(sd)


########### Vectors
vec1 <- c(1,9,3,-10,pi); vec1

vec2 <- 1:50; vec2
vec3 <- seq(from=-2*pi, to=2*pi, length=50); vec3

# Slicing on vectors
vec2[3]
vec3[4:7]
vec3[c(1,4,9)]

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

########################################################
########## Matrices
tmp <- 1:4
mat1 <- matrix(tmp, nrow=2, ncol=2)
mat1

#Maths with matrices (element-wise)
mat1 + mat1

# curv product
mat1 %*% mat1 

#and element-wise
mat1 * mat1

########################################################
########## Stats

#transpose
t(mat1)
det(mat1)
solve(mat1)

# to save some memory, vectorize matrices
vec4 <- c(mat1)
object.size(mat1)
object.size(vec4)

########################################################
########## Data frames 
#like in pandas!

x <- 1:10
y <- pi+1i*x #i lets us work with complex numbers.
z <- letters[1:10]
tmp.frame <- data.frame(x,y,z)
tmp.frame

########################################################
########## Lists
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


################################################################
######## R Workspace Basics

getwd() 
#working directory

#Don't run
#save.image("Foo.RData")

#Don't run
#load("Foo.RData")

install.packages("car")
library(car)

help(package="car")


######################################################################
######## Probability Distributions



?"Distributions"

#dnorm gives the density, pnorm gives the distribution function, 
#qnorm gives the quantile function, and rnorm generates random deviates.

dnorm(4,mean=0,sd=3)
pnorm(4,mean=0,sd=3)

qnorm(seq(0.1,0.9,by=0.1), mean=0, sd=3)

x <- rnorm(10, mean=0, sd=3)
x

#fix the seed
set.seed(100)
x <- rnorm(10,mean=0,sd=3)
x


#simple plot of density
# Exponential Distribution
xdens <- seq(0,5,0.02)
plot(xdens,dexp(xdens,rate=0.5),type='l',ylim=c(0,1.5), 
     xlab='x',ylab='Exponential p.d.f.',lty=1)
lines(xdens,dexp(xdens,rate=1),type='l',lty=2,col=2)
lines(xdens,dexp(xdens,rate=1.5),type='l',lty=3,col=3)
legend("topright",legend=c(expression(lambda==0.5),expression(lambda==1.0),
                           expression(lambda==1.5)),col=1:3,lty=1:3)

