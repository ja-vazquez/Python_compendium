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
######## Lab 3 Examples
######## June 2, 2016
######################################################################
######################################################################

######################################################################
######## Multivariate Analysis
######################################################################

######## Generating Multivariate Normal Data

install.packages("mvtnorm")
library(mvtnorm)

mu <- c(1,0,3,-2)
Sigma <- rbind(c(2,-1,0.5,0.5),c(-1,2,0.5,0.5),
               c(0.5,0.5,2,-1),c(0.5,0.5,-1,2))
rho <- cov2cor(Sigma)
rho
set.seed(100)
X <- rmvnorm(100,mean=mu,sigma=Sigma)

m <- apply(X,2,mean); m
S <- var(X); S
r <- cor(X); r

m-mu
S-Sigma
r-rho

######## Principal Components Analysis & Multivariate Data Visualization

SVD <- svd(X)
names(SVD)
U <- SVD$u
V <- SVD$v
D <- diag(SVD$d)

t(U)%*%U
t(V)%*%V
max(abs(X-U%*%D%*%t(V)))

X.cent <- sweep(X,2,apply(X,2,mean))

apply(X.cent,2,mean)

SVD <- svd(X.cent)
U <- SVD$u
V <- SVD$v
D <- diag(SVD$d)   

pcscores <- U %*% D
plot(pcscores[,1:2],pch=19)

loc <- "http://astrostatistics.psu.edu/datasets/"
quasars <- read.table(paste(loc,"SDSS_quasar.dat",sep=""),
                      header=T)
dim(quasars)

quas <- quasars
quas[quas==0 | quas==-1 | quas==-9] <- NA
quas <- na.omit(quas)
dim(quas)

#a bunch of plots showing correlations
ind <- c(seq(5,13,2),17,19,21)
pairs(quas[,ind],pch=19,cex=0.5)
quas.cors <- cor(as.matrix(quas[,ind]))
quas.cors

library(MASS)
parcoord(quas[,-1])

#principal component analysis
pc <- princomp(quas[,-1])

names(pc)
?princomp

s <- cov(quas[,-1])
es <- eigen(s)

cor(quas[,-1])

apply(quas[,-1],2,sd)

#show variance of pca's
screeplot(pc)

loadings(pc)

pc$load[,1]

pc$load[,2]

pc2 <- princomp(quas[,-(1:3)])
screeplot(pc2)

loadings(pc2)

pairs(pc2$scores[,1:6],pch=".")

#plot all directions
biplot(pc2,choices=1:2,arrow.len=0,cex=.5)

######## Hotelling's T^2

T.2 <- function(X,mu0){
  n <- nrow(X)
  p <- ncol(X)
  D <- matrix((apply(X,2,mean)-mu0),ncol=1)
  S <- var(X)
  T2 <- t(D)%*%solve(S)%*%D
  p.value <- pf((n-p)*T2/((n-1)*p),df1=p,df2=n-p,
                lower.tail=FALSE) 
  out <- list("T-Squared"=T2,"p.value"=p.value)
  out
}

mag.X <- quas[,ind]
apply(mag.X,2,mean)

mu0 <- c(17,17,17,17,17,15,15,15)
T.2(mag.X,mu0)

######## Multivariate Multiple Linear Regression

out <- lm(cbind(u_mag,g_mag)~z+r_mag+
            i_mag+z_mag,data=quas)
summary(out)

cor.test(quas$u_mag,quas$g_mag)

m.out <- manova(out)
summary(m.out,test="Pillai")

summary(m.out,test="Wilks")
summary(m.out,test="Hotelling-Lawley")
summary(m.out,test="Roy")

######################################################################
######## Nonparametrics
######################################################################

######## Kernel Density Estimators

z <- quasars$z
par(mfrow=c(1,2))
hist(z,breaks="scott",main="",xlab="Redshift",col="black")
plot(quantile(z,seq(1,100,1)/100,na.rm=T),pch=20,cex=0.5, 
     xlab="Percentile",ylab="Redshift")
par(mfrow=c(1,1))

par(mfrow=c(1,2))
plot(density(z,kernel="gaussian",bw=bw.nrd(z)),
     main="Gaussian Kernel",xlab="Redshift",
     lwd=2)
lines(density(z,kernel="gaussian",bw=0.2),lty=2,col=2,
      lwd=2)
legend("topright",legend=c("Silverman's Rule","0.2"),
       title="Bandwidth Type",bty="n",lty=1:2,col=1:2,
       text.col=1:2)
plot(density(z,kernel="biweight",bw=bw.nrd(z)),
     main="Tukey's Biweight Kernel",xlab="Redshift",
     lwd=2)
lines(density(z,kernel="biweight",bw=0.2),lty=2,col=2,
      lwd=2)
legend("topright",legend=c("Silverman's Rule","0.2"),
       title="Bandwidth Type",bty="n",lty=1:2,col=1:2,
       text.col=1:2)

######## Nonparametric Regression

r_i <- quasars$r_mag-quasars$i_mag
par(mfrow=c(1,1))
plot(z,r_i,pch=19,cex=.7,xlab="Redshift",ylab="r-i")

install.packages("ash")
library(ash)

nbin <- c(500, 500) 
ab <- matrix(c(0.0,-0.5,5.5,2),2,2)
bins <- bin2(cbind(z,r_i),ab,nbin)
f <- ash2(bins,c(5,5)); attributes(f)
f$z <- log10(f$z)
image(f$x,f$y,f$z,col=gray(seq(0.5,0.2,by=-0.02)), 
      zlim=c(-2.0,0.2),main='',xlab="Redshift",ylab="r-i")
contour(f$x,f$y,f$z,levels=c(-1.0,-0.5,0.3,0.5),add=T,
        col=1,labcex=1.5)

install.packages("np")
library(np)

z1 <- sort(z)
r_i1 <- r_i[order(z)]
#LOESS Fit
fit1 <- loess(r_i1~z1,span=0.1)
lines(z1,predict(fit1),lwd=2,col=2)
#Smoothing Spline
fit2 <- smooth.spline(z1,r_i1,nknots=100)
lines(fit2,lwd=2,col=3)
#Nadaraya-Watson Estimator
tmp.ind <- round(seq(1,length(z1),len=1000))
bw <- npregbw(r_i1[tmp.ind]~z1[tmp.ind],regtype='lc',
              bwtype='fixed',bandwidth.compute=F,bws=0.1)
fit3 <- npreg(bws=bw,gradients=FALSE)
lines(z1[tmp.ind],fitted(fit3),lwd=2,col=4)
legend("topleft",bty="n",text.col=2:4,
       legend=c("LOESS","Spline","N-W"))

######################################################################
######## Likelihood Calculations & EM Algorithms
######################################################################

######## Maximum Likelihood Estimation

z.red <- quas[,4]
hist(z.red,prob=T,main="Redshift",xlab="Redshift Value")

library(stats4) #A standard package
lnorm.ll <- function(meanlog,sdlog){
  -sum(dlnorm(z.red,meanlog,sdlog,log=T))
}
out <- mle(lnorm.ll,start=list(meanlog=-1,sdlog=1),
           lower=c(-Inf,0.001),upper=c(100,100),
           method="L-BFGS-B")
summary(out)

#curves of the density function
hist(z.red,prob=T,main="Redshift",xlab="Redshift Value")
x.seq <- seq(0,3,len=100)
lines(x.seq,dlnorm(x.seq,coef(out)[1],coef(out)[2]),col=2)

n <- length(z.red)
mu.hat <- mean(log(z.red))
s2.hat <- mean((log(z.red)-mu.hat)^2)
cbind(c(mu.hat,sqrt(s2.hat)),
      c(sqrt(s2.hat/n),
        sqrt(s2.hat/(2*n))))
summary(out)

set.seed(100)
coef.bs <- NULL
for(i in 1:1000){
  x.bs <- sample(z.red,n,replace=T)
  lnorm.ll <- function(meanlog,sdlog){
    -sum(dlnorm(x.bs,meanlog,sdlog,log=T))
  }
  out.bs <- mle(lnorm.ll,start=list(meanlog=-1,sdlog=1),
                lower=c(-Inf,0.001),upper=c(100,100),
                method="L-BFGS-B")
  coef.bs <- rbind(coef.bs,coef(out.bs))
}
mu.bs <- mean(coef.bs[,1])   
mu.bs.se <- sd(coef.bs[,1])
s.bs <- sqrt(mean(coef.bs[,2]^2))
s.bs.se <- sqrt(mean((coef.bs[,2]-s.bs)^2))
cbind(c(mu.bs,s.bs),c(mu.bs.se,s.bs.se))
summary(out)

######## EM Algorithms

X.miss <- quasars[1:50,5]
Y.miss <- c(quasars[1:48,4],NA,NA)
plot(X.miss,Y.miss,pch=19,xlab="u_mag",ylab="z")

n <- length(X.miss)
m <- sum(!is.na(Y.miss))
mu.1 <- mean(X.miss)
sigma.11 <- mean((X.miss-mu.1)^2)
s.12 <- sum((X.miss[1:m]-mean(X.miss))*
              (Y.miss[1:m]-mean(Y.miss[1:m],na.rm=T)))/m
s.11 <- sum((X.miss[1:m]-mean(X.miss))*
              (X.miss[1:m]-mean(X.miss[1:m])))/m
s.22 <- sum((Y.miss[1:m]-mean(Y.miss,na.rm=T))*
              (Y.miss[1:m]-mean(Y.miss[1:m],na.rm=T)))/m
beta.hat <- s.12/s.11
mu.2 <- mean(Y.miss[1:m],na.rm=T)+beta.hat*
  (mu.1-mean(X.miss[1:m]))
sigma.22 <- s.22 + beta.hat^2*(sigma.11-s.11)
z.2j <- mu.2+(s.12/s.11)*(X.miss[(m+1):n]-mu.1)
sigma.12 <- (sum(X.miss*c(Y.miss[1:m],z.2j))-
               (sum(X.miss)*sum(c(Y.miss[1:m],z.2j)))/n)/n
mu <- c(mu.1,mu.2)
Sigma <- matrix(c(s.11,s.12,s.12,s.22),nrow=2)
ll <- sum(mvtnorm::dmvnorm(cbind(X.miss,Y.miss)[-c((m+1):n),],
                           mean=mu,sigma=Sigma,log=TRUE))
MLE_cf <- c(mu.1,mu.2,sigma.11,sigma.12,sigma.22,ll)
MLE_cf

#very cool plot
X <- seq(17,22.25,len=50)
Y <- seq(0,2.75,len=50)
Z <- outer(X,Y,FUN=function(x,y,...){
  apply(cbind(x,y),1,mvtnorm::dmvnorm,...)
},mean=mu,sigma=Sigma)
filled.contour(X,Y,Z,main="Bivariate Normal Density", 
               color.palette=topo.colors,
               plot.axes={ axis(1); axis(2); 
                           points(X.miss,Y.miss,pch=19,col=2) })

mu.1 <- 19.5
mu.2 <- 2.5
s.11 <- s.22 <- 1
s.12 <- 0.5
MLE_EM <- NULL

#Run the following 4 times
#Note that the for-loop is commented out.
#for(i in 1:4){
z.2j <- mu.2+(s.12/s.11)*(X.miss[(m+1):n]-mu.1)
z.2j.2 <- z.2j^2+s.22*(1-(s.12/sqrt(s.11*s.22))^2)
T1 <- sum(X.miss)
T2 <- sum(c(Y.miss[1:m],z.2j))
T11 <- sum(X.miss*X.miss)
T22 <- sum(c(Y.miss[1:m]^2,z.2j.2))
T12 <- sum(X.miss*c(Y.miss[1:m],z.2j))
T2.2 <- sum(c(Y.miss[1:m]^2,z.2j.2))
mu.1 <- T1/n; mu.2 <- T2/n
s.11 <- (T11-T1^2/n)/n 
s.22 <- (T22-T2^2/n)/n 
s.12 <- (T12-(T1*T2)/n)/n 
mu <- c(mu.1,mu.2)
Sigma <- matrix(c(s.11,s.12,s.12,s.22),nrow=2)
ll <- sum(mvtnorm::dmvnorm(cbind(X.miss,Y.miss)[-c((m+1):n),],
                           mean=mu,sigma=Sigma,log=TRUE))
MLE_EM <- rbind(MLE_EM,c(mu.1,mu.2,s.11,s.12,s.22,ll))
MLE_EM
MLE_cf
X <- seq(17,22.25,len=50)
Y <- seq(0,2.75,len=50)
Z <- outer(X,Y,FUN=function(x,y,...){
  apply(cbind(x,y),1,mvtnorm::dmvnorm,...)
}, mean=mu, sigma=Sigma)
filled.contour(X,Y,Z,main="Bivariate Normal Density", 
               color.palette=topo.colors,
               plot.axes={ axis(1); axis(2); 
                           points(X.miss,Y.miss,pch=19,col=2) })
#}

plot(MLE_EM[,6],type="b",pch=19,xlab="Iteration",
     ylab="Log-Likelihood")

######## Mixture of Normals

install.packages("mixtools")
library(mixtools)

Si_IV_1394 <- read.table(paste(loc,"QSO_absorb.txt",sep=""),
                         skip=1,nrows=104)[,2]
hist(Si_IV_1394,xlab="Velocity (km/s)")

BIC.mix <- function(out) -2*out$loglik+log(length(out$x))*
  (length(unlist(out[2:4]))-1)
out1 <- list(x=Si_IV_1394,mu=mean(Si_IV_1394),
             sigma=sd(Si_IV_1394),lambda=1,
             loglik=sum(dnorm(Si_IV_1394,mean(Si_IV_1394),
                              sd(Si_IV_1394),log=TRUE)))
set.seed(100)
out2 <- normalmixEM(Si_IV_1394,k=2,verb=F,eps=1e-4,
                    mu=c(0.6,0.9),sigma=c(0.07,0.07),maxit=5000)
out3 <- normalmixEM(Si_IV_1394,k=3,verb=F,eps=1e-4,
                    maxit=5000)
out4 <- normalmixEM(Si_IV_1394,k=4,verb=F,eps=1e-4,
                    maxit=5000)
out5 <- normalmixEM(Si_IV_1394,k=5,verb=F,eps=1e-4,
                    maxit=5000)
All.BIC <- c(BIC.mix(out1),BIC.mix(out2),BIC.mix(out3),
             BIC.mix(out4),BIC.mix(out5))
plot(All.BIC,type="b",xlab="# of Components",ylab="BIC")
which.min(All.BIC)

par(mfrow=c(1,2))
plot(out2,density=T)
plot(out3,density=T)
plot(out4,density=T)
plot(out5,density=T)

set.seed(100)
boot.comp(Si_IV_1394,max.comp=5,mix.type="normalmix",
          maxit=5000,B=30,epsilon=1e-4)
