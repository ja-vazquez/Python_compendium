

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
