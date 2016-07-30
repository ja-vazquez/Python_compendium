


########################################
########## Basic graphs



########## Bar plots

library(vcd)
counts <- table(Arthritis$Improved)

barplot(counts,
          main="Bar plot", xlab = "Improvement", ylab="Frequency")

#same but in horizontal bars
barplot(counts,
        main="Bar plot", xlab = "Improvement", ylab="Frequency", horiz = TRUE)


### Stacked and group bar plots

library(vcd)
counts <- table(Arthritis$Improved, Arthritis$Treatment)

#Stacked plot
barplot(counts, 
          main="Stacked bar plot", xlab="Treatment", ylab="Frequency", 
          col=c('red', 'yellow', 'green'), 
          legend=rownames(counts) )

#same as before but grouped bars
r<- barplot(counts, 
        main="Stacked bar plot", xlab="Treatment", ylab="Frequency", 
        col=c('red', 'yellow', 'green'), 
        legend=rownames(counts), beside = TRUE )
lines(r, counts)

?barplot

### Tweaking bar plots

par(mar = c(5, 8, 4, 2))       # size of margin
par(las=2)                     # rotate labels
counts <- table(Arthritis$Improved)
barplot(counts, 
          main="Treatment outcome", 
          horiz = TRUE, 
          cex.names = 0.8,       #font size
          names.arg=c("No improvement", "Some improv", "Marked Improvement"))



########## Spinograms
# a stack bar plot rescaled so the high of each bar is 1

library(vcd)
attach(Arthritis)
counts <- table(Treatment, Improved)
spine(counts, main="Spinogram ex")
detach(Arthritis)



########## Pie charts

par(mfrow=c(2, 2))
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie(slices, labels=lbls, 
      main="Simple Pie chart")


pct <- round(slices/sum(slices)*100)
lbls2 <- paste(lbls, "", pct,  "%", sep="")
pie(slices, labels=lbls2, col=rainbow(length(lbls2)), 
      main="Pie chart w percentages")

#3D pie chart
#install.packages("plotrix")
library(plotrix)

pie3D(slices, labels=lbls, explode=0.1, 
        main="3D pie chart ")

mytable <- table(state.region)
lbls3   <- paste(names(mytable), "\n", mytable, sep="")
pie(mytable, labels=lbls3, 
      main="Pie chart from a table")


########## Fan plot

library(plotrix)
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
fan.plot(slices, labels=lbls, 
    main="Fan plot")


########## Histograms

?hist
par(mfrow= c(2, 2))

hist(mtcars$mpg)

hist(mtcars$mpg,
      breaks=12, col="red", xlab="Miles per gallon", main="Colored in 12 bins")

hist(mtcars$mpg, 
     freq=FALSE, breaks=12, col="red", xlab="Miles per gallon", 
      main = "Histogram, rug plot, density curve")
rug(jitter(mtcars$mpg))
lines(density(mtcars$mpg), col="blue", lwd=2)

x <- mtcars$mpg
h <- hist(x,
          breaks=12, col="red", xlab="Miles per gallon", 
          main="Histogram with normal curve and box")
xfit <- seq(min(x), max(x), length=40)
yfit <- dnorm(xfit, mean=mean(x), sd= sd(x))
yfit <- yfit*diff(h$mids[3:4])*length(x)
lines(xfit, yfit, col="blue", lwd=2)
box()



########## Kernel Density plots



par(mfrow= c(2, 1))
d <- density(mtcars$mpg)
plot(d)

d <- density(mtcars$mpg)
plot(d, main="Kernel density")
polygon(d, col='green', border = 'blue')
rug(mtcars$mpg, col = "red")
?rug


#sm package to compare kernels

#install.packages("sm")
library(sm)
attach(mtcars)

cyl.f <- factor(cyl, levels=c(4,6,8), 
                  labels=c("4 cylinder", "6 cylinder", "8 cylinder"))
sm.density.compare(mpg, cyl, xlab="Miles per gallon")
title(main="MPG dist by car cyls")

colfill <- c(2:(1+ length(levels(cyl.f))))
#locator() option pick the legend interactively
legend(locator(1), levels(cyl.f), fill = colfill)
detach(mtcars)



########## Box plots
dev.off()
boxplot(mtcars$mpg, main="Box plot", ylab="Miles per Gallon")

boxplot(mpg ~ cyl, data = mtcars,
          #notch=TRUE, varwidth=TRUE,   # for notched box plots
          main="Car milles", 
          xlab="Cylinders", 
          ylab="Milles per Gallon")


# Using two cross factors

mtcars$cyl.f <- factor(mtcars$cyl, 
                        levels = c(4, 6, 8), 
                        labels = c("4", "6", "8"))

mtcars$am.f <- factor(mtcars$am, 
                        levels=c(0,1), 
                        labels=c("auto", "standard"))

boxplot(mpg ~ am.f * cyl.f, 
          data=mtcars, 
          varwidth=TRUE, 
          col=c("gold", "darkgreen"), 
          main="MPG by auto type", 
          xlab="Auto type", ylab="Miles per Gallon")

?formula

########## Violin plots

#install.packages("vioplot")
library(vioplot)

x1 <- mtcars$mpg[mtcars$cyl == 4]
x2 <- mtcars$mpg[mtcars$cyl == 6]
x3 <- mtcars$mpg[mtcars$cyl == 8]

vioplot(x1, x2, x3, 
          names=c("4 cyl", "6 cyl", "8 cyl"),
          col = "gold")
title("Violin miles per Gallon", ylab="MPG", 
        xlab="Cyls")



########## Dot plots

dotchart(mtcars$mpg, labels = row.names(mtcars), cex=.7,
          main = "Gas Miles per Gallon", 
          xlab = "MPG")

#

x <- mtcars[order(mtcars$mpg),]
x$cyl <- factor(x$cyl)

x$color[x$cyl == 4] <- "red"
x$color[x$cyl == 6] <- "blue"
x$color[x$cyl == 8] <- "darkgreen"

dotchart(x$mpg,
          labels= row.names(x), 
          cex=0.7, 
          groups = x$cyl,
          gcolor = "black",
          color  = x$color,
          pch = 19, 
          main ="Gas Miles per Car model \n grouped by cylinder",
          xlab = "MPG")







