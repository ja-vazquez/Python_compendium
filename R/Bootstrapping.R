


######################################################################
######## Bootstrapping


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
