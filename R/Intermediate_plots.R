

########################################
########## Intermediate plots


##########  Scatter plots

attach(mtcars)
plot(wt, mpg, 
     main="Basic Scatter plot", 
     xlab="Car weight", 
     ylab="Miles per Gallon", pch=19)
abline(lm(mpg~wt), col="red", lwd=2, lty=1)
lines(lowess(wt, mpg), col="blue", lwd=2, lty =2) #smooth line
detach(mtcars)


library(car)
scatterplot(mpg ~ wt | cyl, data=mtcars, lwd=0, span=0.75, 
            main="Scatter", 
            xlab='Weight', 
            ylab='Miles per Galon', 
            legend.plot= TRUE, 
            #id.methods='identify',
            labels=row.names(mtcars),
            boxplots='xy')



### Scatter-plot matrices

pairs(~mpg+disp+drat+wt, data = mtcars, 
        main='Scatter plot')

library(car)
scatterplotMatrix(~mpg+disp+drat+wt, data=mtcars, 
                  spread=FALSE, smoother.args=list(lty=2), 
                  main='Scatter')


### High-density scatter plots

set.seed(1234)
n <- 10000
c1 <- matrix(rnorm(n, mean=0, sd=0.5), ncol=2)
c2 <- matrix(rnorm(n, mean=3, sd=2   ), ncol=2)
mydata <- rbind(c1, c2)
mydata <- as.data.frame(mydata)
names(mydata) <- c('x', 'y')

with(mydata,plot(x, y, pch=19, main='Scatter plot'))



### Smoothing with hexagons
with(mydata, smoothScatter(x, y, main="Scatter"))

install.packages("hexbin")
library(hexbin)
with(mydata, {
  bin <- hexbin(x, y, xbins=50)
  plot(bin, main='Hexagonal')
})


### 3D scatter plots

#install.packages("scatterplot3d")
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt, disp, mpg, 
          main='3D Scatter plot')

detach(mtcars)


# with lines showing the hight
#install.packages("scatterplot3d")
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt, disp, mpg, 
          pch=16,
          highlight.3d = TRUE,
          type='h',
          main='3D Scatter plot')
detach(mtcars)


# added a fit plane (instead of linear fit :D )
attach(mtcars)
s3d <- scatterplot3d(wt, disp, mpg, 
                     pch=16,
                     highlight.3d = TRUE,
                     type='h',
                     main='3D Scatter plot')
fit <- lm(mpg~ wt + disp)
s3d$plane3d(fit)
detach(mtcars)



### Spinning 3D scatter plots

library(rgl)
attach(mtcars)
plot3d(wt, disp, mpg, col="red", size=5)
detach(mtcars)


library(car)
with(mtcars, scatter3d(wt, disp, mpg))


### Bubble plots

attach(mtcars)
r <- sqrt(disp/pi)
symbols(wt, mpg, circle=r, inches=0.30, 
        fg='white', bg= 'lightblue', 
        main='Bubble plot', 
        ylab='Miles per gallon', 
        xlab='weight')
text(wt, mpg, rownames(mtcars), cex = 0.6)
detach(mtcars)


########## Line charts

opar <- par(no.readonly = TRUE)
par(mfrow =c(1, 2))
t1 <- subset(Orange, Tree==1)
plot(t1$age, t1$circunference, 
     xlab="Age", 
     ylab="Circunference", 
     main="Orange tree")
plot(t1$age, t1$circunference, 
     xlab='Age', 
     ylab='Circunference', 
     main='Orange tree',
     type ='b')
par(opar)




########## Corrgrams

options(digits=2)
cor(mtcars[1:11])

install.packages("corrgram")
library(corrgram)
corrgram(mtcars[1:11], order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt, 
         main='Corrgram')


#Only the bottom corner
corrgram(mtcars[1:11], order=TRUE, lower.panel=panel.shade, 
         upper.panel=NULL, text.panel=panel.txt, 
         main='Corrgram')



#Using ellipses and scatter plots
corrgram(mtcars[1:11],
         order=TRUE, lower.panel = panel.ellipse, 
         upper.panel = panel.pts, text.panel = panel.txt,
         diag.panel = panel.minmax, main='Corrg')


cols <- colorRampPalette(c('darkgoldenrod4', 'burlywood1', 
                           'darkkhaki', 'darkgreen'))
corrgram(mtcars[1:11], order=TRUE, col.regions = cols,
         lower.panel=panel.shade, upper.panel = panel.conf,
         text.panel=panel.txt, main='Corrgram')



########## Mosaic plots

ftable(Titanic)

library(vcd)
mosaic(Titanic, shade=TRUE, legend=TRUE)

mosaic(~Class+Sex+Survived, data=Titanic, shade=TRUE, legend=TRUE)





