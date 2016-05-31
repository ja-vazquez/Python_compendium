######################################################################
######################################################################
######################################################################
######## Summer School in Statistics for Astronomers XII: R Labs
######## Code by Derek Young
######################################################################
######################################################################
######################################################################

######################################################################
######################################################################
######## Lab 1 Examples
######## May 31, 2016
######################################################################
######################################################################

######################################################################
######## R Syntax
######################################################################

#Highlight this line and click "Run" at the top of the RStudio window.

?sd #You can also type ?"sd"

example(sd)

vec1 <- c(1,9,3,-10,pi); vec1

vec2 <- 1:50; vec2
vec3 <- seq(from=-2*pi,to=2*pi,length=50); vec3

vec2[3]
vec3[4:7]
vec3[c(1,4,9)]

#minus position, removes that element 
vec2[-1] 

#to select the last element 
tail(vec2, 1)

(vec2+vec3)^2
vec2-10

exp(1)
sqrt(16)
log10(100)
log(100)
cos(2*pi)

a <- c(1,2); b <- c(1,3)
a==b
identical(a,b)

a <- c(TRUE,TRUE,FALSE,FALSE)
b <- c(TRUE,FALSE,TRUE,FALSE)
!a
a & b
a | b
xor(a,b)

na.vec <- c(1:3,NA,5:7)
3*na.vec

0/0
Inf-Inf

tmp <- 1:4
mat1 <- matrix(tmp,nrow=2,ncol=2)

mat1 + mat1
mat1 %*% mat1
t(mat1)
det(mat1)
solve(mat1)

vec4 <- c(mat1)
object.size(mat1)
object.size(vec4)

x <- 1:10
y <- pi+1i*x #i lets us work with complex numbers.
z <- letters[1:10]
tmp.frame <- data.frame(x,y,z)
tmp.frame

list1 <- list(V1=vec1,V2=vec2,M1=mat1)
list1

list1$M1

lapply(list1,FUN=sum)

sapply(list1,FUN=sum)

ratio <- function(x,y) x/y

ratio(3,6)

######################################################################
######## R Workspace Basics
######################################################################

getwd() #Note: We will not all have the same 
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
######################################################################

dnorm(4,mean=0,sd=3)
pnorm(4,mean=0,sd=3)

qnorm(seq(0.1,0.9,by=0.1),mean=0,sd=3)

x <- rnorm(10,mean=0,sd=3)
x

set.seed(100)
x <- rnorm(10,mean=0,sd=3)
x

xdens <- seq(0,5,0.02)
plot(xdens,dexp(xdens,rate=0.5),type='l',ylim=c(0,1.5), 
     xlab='x',ylab='Exponential p.d.f.',lty=1)
lines(xdens,dexp(xdens,rate=1),type='l',lty=2,col=2)
lines(xdens,dexp(xdens,rate=1.5),type='l',lty=3,col=3)
legend("topright",legend=c(expression(lambda==0.5),expression(lambda==1.0),
                           expression(lambda==1.5)),col=1:3,lty=1:3)

######################################################################
######## Descriptive Statistics & Exploratory Data Analysis
######################################################################

install.packages("astrodatR")
library(astrodatR)

data(HIP)

######## Numerical Summaries

dim(HIP)
names(HIP) 
HIP[1,]
HIP[1:20,7]
sum(HIP[,3])

for(i in 1:ncol(HIP)){
  print(c(max(HIP[,i]),min(HIP[,i]), 
          median(HIP[,i]),mad(HIP[,i]))) 
}
apply(HIP,2,max) 
apply(HIP,2,min) 
apply(HIP,2,median) 
apply(HIP,2,mad)

sum(is.na(HIP[,9]))
which(is.na(HIP[,9]))

y <- na.omit(HIP)
for(i in 1:ncol(y)) {
  print(c(max(y[,i]),min(y[,i]), 
          median(y[,i]),mad(y[,i]))) 
}

for(i in 1:ncol(HIP)) {
  print(c(max(HIP[,i],na.rm=T),min(HIP[,i],na.rm=T), 
          median(HIP[,i],na.rm=T),mad(HIP[,i],na.rm=T))) 
}

sort(HIP[1:10,3])
HIP[order(HIP[1:10,3]),]

names(HIP)
attach(HIP)

summary(Vmag)
summary(B.V)

######## Basic Data Visualization

dotchart(B.V)

hist(B.V,prob=T)
d <- density(B.V,na.rm=T)
lines(d,col=2,lwd=2,lty=2)

stem(sample(B.V,100))

boxplot(HIP[,c(4,6,7,9)])

par(mfrow=c(2,2))
for(i in c(4,6,7,9)) 
  boxplot(HIP[,i],main=names(HIP)[i])

par(mfrow=c(1,1))
b <- boxplot(HIP[,c(4,6,7,9)])
names(b)

b$names[2]
b$out[b$group==2]

boxplot(Vmag~cut(B.V,breaks=(-1:6)/2),
        notch=T,varwidth=T,las=1,tcl=.5,
        xlab=expression("B minus V"),
        ylab=expression("V magnitude"),
        main="Can you find the red giants?",
        cex=1,cex.lab=1.4,cex.axis=.8,cex.main=1)
axis(2,labels=F,at=0:12,tcl=-.25)
axis(4,at=3*(0:4))

plot(Vmag,B.V)

plot(Vmag,B.V,pch=".")

plot(RA,Dec,pch=".")
rect(50,0,100,25,border=2)

filter1 <- (RA>50 & RA<100 & Dec>0 & Dec<25)

plot(pmRA[filter1],pmDE[filter1],pch=20)
rect(0,-150,200,50,border=2)

plot(pmRA[filter1],pmDE[filter1],pch=20,xlim=c(0,200),
     ylim=c(-150,50))
rect(90,-60,130,-10,border=2)
filter2 <- (pmRA>90 & pmRA<130 & pmDE>-60 & pmDE< -10) 
# Space in 'pmDE< -10' is necessary!
filter  <-  filter1 & filter2

pairs(HIP[filter,-c(3,5)],pch=20)

filter <- filter & (e_Plx<5)
pairs(HIP[filter,-c(3,5)],pch=20)

sum(filter)

plot(Vmag,B.V,pch=c(46,20)[1+filter],col=1+filter,
     xlim=range(Vmag[filter]),ylim=range(B.V[filter]))

install.packages("rgl")
library(rgl)

data("Shapley_galaxy")
attach(Shapley_galaxy)
rgl.open()
rgl.points(scale(R.A.),scale(Dec.),scale(Vel))
rgl.bbox()

tmp.V <- data.frame(Vmag,B.V)[!is.na(B.V),]
tmp.V <- tmp.V[order(tmp.V[,1]),]
plot(Vmag,B.V,pch=19)
out.loess <- loess(B.V~Vmag,data=tmp.V)
lines(out.loess$x,out.loess$fitted,col=2,lwd=4)

install.packages("ggplot2")
library(ggplot2)

z <- ggplot(tmp.V, aes(Vmag,B.V))
z+geom_point()
z+geom_point()+stat_smooth(method="loess",size=1.4,fill="grey50",alpha=0.5,level=0.99,colour="red")

######################################################################
######## Statistical Inference
######################################################################

######## Normality Testing

data("GlobClus_mag")
GC_MWG <- subset(GlobClus_mag,Sample=="MWG",select=2:3)
GC_M31 <- subset(GlobClus_mag,Sample=="M31",select=2:3)
KGC_MWG <- GC_MWG[,2]  
KGC_M31 <- GC_M31[,2]-24.44
kseq <- seq(-15.0,-5.0,0.25)

library(MASS)
par(mfrow=c(1,2))
hist(KGC_MWG,breaks=kseq,ylim=c(0,10),main='Milky Way', 
     xlab='K mag',ylab='N',col=gray(0.5))
normfit_MWG <- fitdistr(KGC_MWG,'normal')
normfit_MWG 
lines(kseq,dnorm(kseq,mean=normfit_MWG$estimate[[1]], 
                 sd=normfit_MWG$estimate[[2]]) * normfit_MWG$n*0.25,lwd=2)
hist(KGC_M31,breaks=kseq,ylim=c(0,50),main='M 31',
     xlab='K mag',ylab='N',col=gray(0.5))
normfit_M31 <- fitdistr(KGC_M31,'normal') 
normfit_M31
lines(kseq,dnorm(kseq,mean=normfit_M31$estimate[[1]], 
                 sd=normfit_M31$estimate[[2]]) * normfit_M31$n*0.25, 
      lwd=2)

shapiro.test(KGC_MWG)
shapiro.test(KGC_M31)

par(mfrow=c(1,2))
plot(ecdf(KGC_MWG))
plot(ecdf(KGC_M31))

ks.test(KGC_MWG,KGC_M31)

######## t-test

color <- B.V
par(mfrow=c(1,1))
boxplot(color~filter,notch=T)

H <- color[filter]
nH <- color[!filter & !is.na(color)]

t.test(H,nH)

v1 <- var(H)/92
v2 <- var(nH)/2586
c(var(H),var(nH))

tstat <- (mean(H)-mean(nH))/sqrt(v1+v2)
tstat

sw.v <- (v1+v2)^2 / (v1^2/91+v2^2/2585); sw.v

2*pt(tstat,sw.v)

t.test(H,nH,var.equal=T)

######## Chi-Squared Tests for Categorical Data

bvcat <- cut(color,breaks=c(-Inf,.5,.75,1,Inf))
boxplot(Vmag~bvcat,varwidth=T,
        ylim=c(max(Vmag),min(Vmag)), 
        xlab=expression("B minus V"),
        ylab=expression("V magnitude"), 
        cex.lab=1.4,cex.axis=.8)

table(bvcat,filter)

chisq.test(bvcat,filter)

chisq.test(bvcat,filter,sim=T,B=50000)
