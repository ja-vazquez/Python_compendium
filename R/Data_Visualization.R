


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
