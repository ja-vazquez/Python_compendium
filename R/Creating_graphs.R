


########################################
########## Working with graphs


?mtcars
?lm

#pdf("mygraph.pdf")
attach(mtcars)
plot(wt, mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
detach(mtcars)
#dev.off()


######  A simple example

dose  <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

?plot

plot(dose, drugA, type="b")

#Graphical parameters
#Customize many features of a graph, by specifying 
#these options through the par() function

opar <- par(no.readonly = TRUE)
  #line and symbol type
par(lty=2, pch=17)
plot(dose, drugA, type='b')
par(opar)


###### Symbols and lines 
plot(dose, drugA, type='b', lty=3, lwd=3, pch=15, cex=2)

###### Colors
?RColorBrewer
library(RColorBrewer)
n <- 7
mycolors <- brewer.pal(n, "Set1")
barplot(rep(1, n), col= mycolors)


n <- 10
mycolors <- rainbow(n)
pie(rep(1, n), labels=mycolors, col=mycolors)
mygrays <- gray(0:n/n)
pie(rep(1, n), labels=mygrays, col=mygrays)


###### Text characteristics , fonts and text scaling
par(font.lab=3, cex.lab=1.5, font.main=4, cex.main=2)


###### Margin dimensions
par(pin=c(4, 2), mai=c(1, .5, 1, .2))

###### Example

dose  <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly = TRUE)
par(pin=c(2, 3))
par(lwd=2, cex=1.5)
par(cex.axis=0.75, font.axis=3)
plot(dose, drugA, type='b', pch=19, lty=2, col='red')
plot(dose, drugB, type='b', pch=23, lty=6, col='blue', bg='green')
par(opar)


###### Adding text, customized axes and legends

plot(dose, drugA, type='b', col='red', lty=2, pch=2, lwd=2, 
     main='Clinical Trials for drug A', sub='Hypotetical data', 
     xlab='Dosage', ylab='Drug response', 
     xlim=c(0, 60), ylim=c(0, 70))


###### Titles

title(main='main title', col.main='red', 
      sub='subtitle', col.sub='blue', 
      xlab='x label', ylab='ylabel', 
      col.lab='green', cex.lab=0.75)


###### Axes [at=tick mark, mar=margins, las=labes parallel, 
#          tck=length of tick

x <- x(1:10)
y <- x
z <- 10/x
opar <- par(no.readonly = TRUE)
  
par(mar=c(5, 4, 4, 8) + 0.1)
plot(x, y, type='b', 
     pch=21, col='red', 
     yaxt='n', lty=3, ann=FALSE)

  # add a new graph  to an existing one
lines(x, z, type='b', pch=22, col='blue', lty=2)

axis(side=2, at=x, labels=x, col.axis='red', las=2)

axis(4, at=z, lables=round(z, digits=2), 
     col.axis='blue', las=2, cex.axis=0.7, tck=-0.01)

mtext('y=1/x', side=4, line=3, cex.lab=1, las=2, col='blue')

title("An example", 
      xlab="X values",
      ylab='Y=X')
par(opar)



###### Reference lines
abline(v= seq(1, 10, 2), lty=2, col='blue')


###### Comparign drugA and drugB response by dose

dose  <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly = TRUE)

par(lwd=2, cex=1.5, font.lab=2)

plot(dose, drugA, type='b', 
     pch=15, lty=1, col='red', ylim=c(0, 60), 
     main="Drug A vs Drug B", 
     xlab='Drug dosage', ylab='Drug response')

lines(dose, drugB, type='b', 
      pch=17, lty=2, col='blue')

abline(h=c(30), lwd=1.5, lty=2, col='gray')

  #minor tick marks
#install.packages("Hmisc")
library(Hmisc)
minor.tick(nx=3, ny=3, tick.ratio=0.5)

legend("topleft", inset=0.05, title="Drug Type", c("A", "B"),
       lty=c(1, 2), pch=c(15, 17), col=c("red", "blue"))

par(opar)


###### Text annotations

attach(mtcars)
plot(wt, mpg, 
     main="Mileage vs Car Weight", 
     xlab="Weight", ylab="Mileage", 
     pch=18, col="blue")
text(wt, mpg,
     row.names(mtcars), cex=0.6, pos=4, col="red")
detach(mtcars)


###### Second example

opar <- par(no.readonly = TRUE)
par(cex=1.5)
plot(1:7, 1:7, type="n")
text(3, 3, "Example of text")
text(4, 4, family="mono", "Example of mono")
text(5, 5, family='serif', "Example of serif")
par(opar)

?plotmath


###### Combining graphs
# buch of plots

attach(mtcars)
opar <- par(no.readonly = TRUE)
par(mfrow= c(2, 2))
plot(wt, mpg, main="Scatterplot of wt vs mpg")
plot(wt, disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")
par(opar)
detach(mtcars)


# Second example
#histograms in a 3 x 1 arrays

attach(mtcars)
opar <- par(no.readonly = TRUE)
par(mfrow= c(3, 1))
hist(wt)
hist(mpg)
hist(disp)
par(opar)
detach(mtcars)


# The layout(mat) function, where mat is a matrix object specifying
# the location of the multiple plots to combine.


attach(mtcars)
layout(matrix( c(1, 2, 3, 3), 2, 2, byrow= TRUE))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)


# Controling the size of each figure

attach(mtcars)
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow = TRUE), 
              widths=c(3, 1), heights=c(1, 2))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)



# Figure arragement with time control

opar <- par(no.readonly = TRUE)
par(fig= c(0, 0.8, 0, 0.8))
plot(mtcars$mpg, mtcars$wt,
     xlab = "Miles per Gallon", 
     ylab = "Car weight")
par(fig= c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$mpg, horizontal = TRUE, axes=FALSE)

par(fig= c(0.65, 1, 0, 0.8), new=TRUE)
boxplot(mtcars$wt, axes=FALSE)

mtext("Scatter plot", side=3, outer=TRUE, line=-3)
par(opar)

