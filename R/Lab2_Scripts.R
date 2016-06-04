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
######## Lab 2 Examples
######## June 1, 2016
######################################################################
######################################################################

######################################################################
######## Regression
######################################################################

######## Simple Linear Regression

install.packages("astrodatR")
library(astrodatR)
data(HIP)
attach(HIP)

#add some filters
filter1 <- (RA>50 & RA<100 & Dec>0 & Dec<25)
filter2 <- (pmRA>90 & pmRA<130 & pmDE>-60 & pmDE< -10) 
filter  <- filter1 & filter2 & (e_Plx<5) 
sum(filter)

#visualise the data
mainseqhyades <- filter & (Vmag>4 | B.V<0.2)
logL <- (15-Vmag-5 * log10(Plx)) / 2.5
x <- logL[mainseqhyades]
y <- B.V[mainseqhyades]
plot(x,y)

#fit a simple linear regression
regline <- lm(y~x)   
abline(regline,lwd=2,col=2)
summary(regline)

#get the value of y at x=1
predict(regline, newdata = data.frame(x=1))
#names
names(regline)
#the coefficients b0 and b1
regline$coefficients

points(mean(x),mean(y),col=3,pch=20,cex=3)

plot(x,y)
#instead of a line, fit an exp but multiplying matrix coeffs
newx <- exp(-x/4)
regline2 <- lm(y~newx)
xseq <- seq(min(x),max(x),len=250)
lines(xseq,regline2$coef%*%rbind(1,exp(-xseq/4)),
      lwd=2,col=3)


# read data from website
loc <- "http://astrostatistics.psu.edu/datasets/"
grb <- read.table(paste(loc,"GRB_afterglow.dat",sep=""), 
                  header=T,skip=1)
dim(grb)
plot(grb[,1:2],xlab="time",ylab="flux")

x <- log(grb[,1])
y <- log(grb[,2])
plot(x,y,xlab="log time",ylab="log flux")

#checking the data
cor.test(x,y)

plot(x,y,xlab="log time",ylab="log flux")
model1 <- lm(y~x)
abline(model1,col=2,lwd=2)
model1 #Same as print(model1)
summary(model1)

names(model1)

######## Confidence Ellipses

install.packages("car")
library(car)

#Ellipses around mean values
confidenceEllipse(model1)

#confidence intervals within the line
source(paste("http://www.stat.psu.edu/~dhunter/R/",
             "confidence.band.r",sep=""))
confidence.band(model1)

#On simulated data
set.seed(100)
tmpx <- 1:10
tmpy <- 1:10+rnorm(10) #Add random Gaussian noise
confidence.band(lm(tmpy~tmpx))

#one point represents 25 observations
tmpx25 <- rep(tmpx,25)
tmpy25 <- rep(tmpy,25)
confidence.band(lm(tmpy25~tmpx25))

#prediction interval and confidence interval
confidence.band(lm(tmpy~tmpx))
PI <- predict(lm(tmpy~tmpx),data.frame(tmpx=7), 
              interval="prediction")
text(c(7,7,7),as.numeric(PI),"P",col=4)
CI <- predict(lm(tmpy~tmpx),data.frame(tmpx=7), 
              interval="confidence")
text(c(7,7,7),as.numeric(CI),"C",col=5)

######## Polynomial Regression

plot(x,y,xlab="log time",ylab="log flux")
model2 <- lm(y~x+I(x^2))
summary(model2)

X <- cbind(1, x, x^2) #Create nx3 X matrix
#beta = (X^T X^-1) X^T Y
solve(t(X) %*% X) %*% t(X) %*% y #Compare to earlier output

abline(model1,col=2,lwd=2)
xx <- seq(min(x),max(x),len=200)
yy <- model2$coef %*% rbind(1,xx,xx^2)
lines(xx,yy,lwd=2,col=3)

######## Some Regression Diagnostics

plot(model1,which=1:2)

plot(model2,which=1:2)

rstu <- rstudent(model2)
plot(model2$fit,rstu)

#studentized residuals
rsta <- rstandard(model2)
points(model2$fit,rsta,col=2,pch=3)

?"influence.measures"

#look for multiculineary
#Variance Inflation Factors
vif(model2)

plot(x,x^2) #Note the highly linear-looking plot

centered.x <- x-mean(x)
model2.2 <- lm(y~centered.x+I(centered.x^2))

plot(x,y,xlab="log time",ylab="log flux")
yy2 <- model2.2$coef%*%rbind(1,xx-mean(x),(xx-mean(x))^2)
lines(xx,yy,lwd=2,col=2)
lines(xx,yy2,lwd=2,col=3,lty=2)


?plotmath

######## Nonlinear Regression

data("ell_gal_profile")
NGC4472 <- subset(ell_gal_profile,galaxy=="NGC.4472",select=2:3)
NGC4406 <- subset(ell_gal_profile,galaxy=="NGC.4406",select=2:3)
NGC4551 <- subset(ell_gal_profile,galaxy=="NGC.4551",select=2:3)
###NGC 4472
names(NGC4472)
NGC4472.fit <- nls(surf_mag~-2.5*log10(I.e*
                   10^(-(0.868*n-0.142)*((radius/r.e)^{1/n}-
                   1)))+26,data=NGC4472,start=list(
                   I.e=20.,r.e=120.,n=4.),model=T,trace=T)
plot(NGC4472.fit$model$radius,NGC4472.fit$model$surf_mag, 
     pch=20,xlab="r  (arcsec)",ylab=expression(mu ~~ 
     (mag/sq.arcsec)),ylim=c(16,28),cex.lab=1.5,cex.axis=1.5)
lines(NGC4472.fit$model$radius,fitted(NGC4472.fit))
###NGC 4406
NGC4406.fit <- nls(surf_mag~-2.5*log10(I.e*
                   10^(-(0.868*n-0.142)*((radius/r.e)^{1/n}-
                   1)))+32,data=NGC4406,start=list(
                   I.e=20.,r.e=120.,n=4.),model=T,trace=T)
points(NGC4406.fit$model$radius,NGC4406.fit$model$surf_mag,
       pch=3,col=2)
lines(NGC4406.fit$model$radius,fitted(NGC4406.fit),col=2)
###NGC 4551
NGC4551.fit <- nls(surf_mag~-2.5*log10(I.e*
                   10^(-(0.868*n-0.142)*((radius/r.e)^{1/n}-
                   1)))+26,data=NGC4551,start=list(
                   I.e=20.,r.e=15.,n=4.),model=T,trace=T)
points(NGC4551.fit$model$radius,NGC4551.fit$model$surf_mag,
       pch=5,col=3)
lines(NGC4551.fit$model$radius,fitted(NGC4551.fit),col=3)
legend(500,20,c("NGC 4472","NGC 4406","NGC 4551"), 
       pch=c(20,3,5),col=1:3,text.col=1:3)

summary(NGC4472.fit)
summary(NGC4406.fit)
summary(NGC4551.fit)

par(mfrow=c(1,3))
qqnorm(residuals(NGC4472.fit)/summary(NGC4472.fit)$sigma) 
abline(a=0,b=1)
shapiro.test(residuals(NGC4472.fit)/
               summary(NGC4472.fit)$sigma)
qqnorm(residuals(NGC4406.fit)/summary(NGC4406.fit)$sigma) 
abline(a=0,b=1)
shapiro.test(residuals(NGC4406.fit)/
               summary(NGC4406.fit)$sigma)
qqnorm(residuals(NGC4551.fit)/summary(NGC4551.fit)$sigma) 
abline(a=0,b=1)
shapiro.test(residuals(NGC4551.fit)/
               summary(NGC4551.fit)$sigma)

######################################################################
######## Bootstrapping
######################################################################

######## Nonparametric Bootstrapping

x <- logL[mainseqhyades]
y <- B.V[mainseqhyades]
par(mfrow=c(1,1))
plot(x,y)
regline <- lm(y~x)   
abline(regline,lwd=2,col=2)

library(boot)
library(MASS)
#Resistant Regression
mystat <- function(a,b){
  lqs(a[b,2]~a[b,1])$coef}
set.seed(100)
model2B.2  <- boot(cbind(x,y),mystat,200)
names(model2B.2)

model2B.2$t

cov(model2B.2$t)
sqrt(diag(cov(model2B.2$t)))

model2B.2
plot(model2B.2)

######## Parametric Bootstrapping

x <- Dec[filter]
y <- pmDE[filter]
plot(x,y,pch=20)
model1 <- lm(y ~ x)
abline(model1,lwd=2,col=2)

summary(model1)

y <- 0.747-0.407*x+0.0649*rnorm(92)

H <- B.V[filter]
nH <- B.V[!filter & !is.na(B.V)]
tlist2 <- NULL
all <- c(H,nH)
set.seed(100)
for(i in 1:5000) {
  s <- sample(2586,92) #Choose a sample
  tlist2 <- c(tlist2,t.test(all[s],all[-s],
                            var.eq=T)$stat) #Add t-stat to list
}

plot(qnorm((2*(1:5000)-1)/10000),sort(tlist2))
abline(0,1,col=2)
ks.test(tlist2,"pnorm")

plot(qnorm((2*(1:5000)-1)/10000),sort(tlist2)-mean(tlist2))
abline(0,1,col=2)
ks.test(tlist2-mean(tlist2),"pnorm")

obs.ksstat <- ks.test(tlist2-mean(tlist2),
                      "pnorm")$stat

random.ksstat <- NULL
for(i in 1:1000) {
  x <- rnorm(5000)
  random.ksstat <- c(random.ksstat,
                     ks.test(x,pnorm,mean=mean(x))$stat)
}

hist(random.ksstat,nclass=40)
abline(v=obs.ksstat,lty=2,col=2)
mean(random.ksstat>=obs.ksstat)

######################################################################
######## Model Selection
######################################################################

######## AIC and BIC

x <- logL[mainseqhyades]
y <- B.V[mainseqhyades]
plot(x,y)

model1 <- lm(y~x)
model2 <- lm(y~x+I(x^2))
model3 <- lm(y~x+I(x^2)+I(x^3))
model4 <- lm(y~x+I(x^2)+I(x^3)+I(x^4))
model5 <- lm(y~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))
model6 <- lm(y~x+I(x^2)+I(x^3)+I(x^4)+I(x^5)+I(x^6))

library(stats4) #Necessary for the BIC function
AIC.m <- c(AIC(model1),AIC(model2),AIC(model3),
           AIC(model4),AIC(model5),AIC(model6))
BIC.m <- c(BIC(model1),BIC(model2),BIC(model3),
           BIC(model4),BIC(model5),BIC(model6))
plot(1:6,AIC.m,ylim=c(-280,-220),pch=19,xlab="Order",
     ylab="AIC/BIC Value")
lines(1:6,AIC.m)
points(1:6,BIC.m,pch=21,col=2)
lines(1:6,BIC.m,col=2)
legend("topright",legend=c("AIC","BIC"),col=1:2,
       text.col=1:2,pch=c(19,21))
which.min(AIC.m)
which.min(BIC.m)

########R^2 and Adjusted-R^2

r.sq <- c(summary(model1)[[8]],summary(model2)[[8]],
          summary(model3)[[8]],summary(model4)[[8]],
          summary(model5)[[8]],summary(model6)[[8]])
adj.r.sq <- c(summary(model1)[[9]],summary(model2)[[9]],
              summary(model3)[[9]],summary(model4)[[9]],
              summary(model5)[[9]],summary(model6)[[9]])
r.sq
adj.r.sq
which.max(r.sq)
which.max(adj.r.sq)

