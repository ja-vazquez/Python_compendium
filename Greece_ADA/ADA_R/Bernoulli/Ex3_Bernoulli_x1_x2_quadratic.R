# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of frequentist Bernoulli regression in R
# synthetic data
# 1 response (y) and 2 explanatory variables (x1,x2) with 2 quadratic terms

#install.packages("plot3D",dependencies = T)      # Run this if plot3D not previously installed

require("plot3D")

set.seed(1056)                                    # set seed to replicate example
nobs= 1000                                        # number of obs in model 
x1 <- runif(nobs,0,6)                             # random uniform variable
x2 <- runif(nobs,0,6) 
eta <- -1 + 4*x1-1.25*x1^2 -2.5*x2+0.75*x2^2      # linear predictor, xb
p <- 1/(1+exp(-eta))                              # inverse-logit link
y <- rbinom(nobs,size=1, prob = p)                # create y as adjusted random bernoulli variate



fit <- glm(y~x1+x2+I(x1^2)+I(x2^2),family = "binomial")   # Compute the linear regression 
summary(fit)

# predict values on regular xy grid
grid.lines = 30
x1.pred <- seq(1.01*min(x1), 0.99*max(x1), length.out = grid.lines)
x2.pred <- seq(1.01*min(x2), 0.99*max(x2), length.out = grid.lines)
x1x2 <- expand.grid( x1 = x1.pred, x2 = x2.pred)

y.pred <- matrix(predict(fit, newdata = x1x2,type="response"), 
                 nrow = grid.lines, ncol = grid.lines)


# fitted points for droplines to surface
fitpoints <- predict(fit,type="response")

scatter3D(x1, x2, y,  cex = 0.75, cex.lab=1.5,type="p",pch = 19,
          theta = 130, phi = 25, ticktype = "detailed",col="orange2",bty = "b2",
          xlab="x1",
          ylab="x2",
          zlab="y", 
          surf = list(col="cyan3",x = x1.pred, y = x2.pred, z = y.pred,  
                      facets = NA, lwd=1.25,lty=2),colkey = FALSE)


