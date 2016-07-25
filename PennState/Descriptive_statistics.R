
######################################################################
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

######################################################################
######## Basic Data Visualization

#very heavy plot
#dotchart(B.V)
B.V
#plotting histogram
hist(B.V,prob=T)
d <- density(B.V,na.rm=T)
lines(d,col=2,lwd=2,lty=2)

#because is too heavy, take a sample.
stem(sample(B.V,100))

boxplot(HIP[,c(4,6,7,9)])

#split plots on diff windows
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

#scatter plots
plot(Vmag, B.V)

plot(Vmag,B.V,pch=".")

plot(RA,Dec,pch=".")
rect(50,0,100,25,border=2)

# Make a zoom and filter relevan info
filter1 <- (RA>50 & RA<100 & Dec>0 & Dec<25)

plot(pmRA[filter1],pmDE[filter1],pch=20)
rect(0,-150,200,50,border=2)

plot(pmRA[filter1],pmDE[filter1],pch=20,xlim=c(0,200),
     ylim=c(-150,50))
rect(90,-60,130,-10,border=2)
filter2 <- (pmRA>90 & pmRA<130 & pmDE>-60 & pmDE< -10) 
# Space in 'pmDE< -10' is necessary!
filter  <-  filter1 & filter2

# Big matrix plots for everything 
pairs(HIP[filter,-c(3,5)],pch=20)

# drop the weird obervation (outliers) for e_Plx
filter <- filter & (e_Plx<5)
pairs(HIP[filter,-c(3,5)],pch=20)

sum(filter)

# plot read giants, coloured code
plot(Vmag,B.V,pch=c(46,20)[1+filter],col=1+filter,
     xlim=range(Vmag[filter]),ylim=range(B.V[filter]))

#3D plots
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

#local polynomial regression fitting
out.loess <- loess(B.V~Vmag,data=tmp.V)
lines(out.loess$x,out.loess$fitted,col=2,lwd=4)

#Using ggplot2
install.packages("ggplot2")
library(ggplot2)

z <- ggplot(tmp.V, aes(Vmag,B.V))
z+geom_point()
z+geom_point()+stat_smooth(method="loess",size=1.4,fill="grey50",alpha=0.5,level=0.99,colour="red")

######################################################################
######## Statistical Inference


######## Normality Testing

data("GlobClus_mag")
GC_MWG <- subset(GlobClus_mag,Sample=="MWG",select=2:3)
GC_M31 <- subset(GlobClus_mag,Sample=="M31",select=2:3)
KGC_MWG <- GC_MWG[,2]  
KGC_M31 <- GC_M31[,2]-24.44
kseq <- seq(-15.0,-5.0,0.25)

#plot distributions
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
                 sd=normfit_M31$estimate[[2]]) * normfit_M31$n*0.25, lwd=2)

shapiro.test(KGC_MWG)
shapiro.test(KGC_M31)

par(mfrow=c(1,2))
plot(ecdf(KGC_MWG))
plot(ecdf(KGC_M31))

#Kolmogorov-Smirnov test
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
