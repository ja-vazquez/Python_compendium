# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of frequentist linear regression in R
# synthetic data
# 1 response (y) and 2 explanatory variables (x1,x2) with 2 quadratic terms

#install.packages("plot3D",dependencies = T)      # Run this if plot3D not previously installed

require("plot3D")

set.seed(1056)                                    # set seed to replicate example
nobs= 150                                         # number of obs in model 
x1 <- runif(nobs,0,2)                             # random uniform variable
x2 <- runif(nobs,0,2) 
xb <- 2 + 3*x1-4.5*x1^2 +1.5*x2+1.5*x2^2          # linear predictor, xb
y <- rnorm(nobs, xb, sd=0.5)                      # create y as adjusted random normal variate


fit <- lm(y~x1+x2+I(x1^2)+I(x2^2))                # Compute the linear regression 
summary(fit)                                      # check numerical results

# predict values on regular xy grid
grid.lines = 26
x1.pred <- seq(1.01*min(x1), 0.99*max(x1), length.out = grid.lines)
x2.pred <- seq(1.01*min(x2), 0.99*max(x2), length.out = grid.lines)
x1x2 <- expand.grid( x1 = x1.pred, x2 = x2.pred)

y.pred <- matrix(predict(fit, newdata = x1x2), 
                 nrow = grid.lines, ncol = grid.lines)


# fitted points
fitpoints <- predict(fit)

scatter3D(x1, x2, y, pch = 19, cex = 0.5, cex.lab=1.5,
          theta = 135, phi = 25, ticktype = "detailed",col="red2",bty = "b2",t="l",
          xlab="x1",
          ylab="x2",
          zlab="y", 
          surf = list(col="cyan",x = x1.pred, y = x2.pred, z = y.pred,  
                      facets = NA, fit = fitpoints,lwd=1.5,lty=3),colkey = FALSE)


