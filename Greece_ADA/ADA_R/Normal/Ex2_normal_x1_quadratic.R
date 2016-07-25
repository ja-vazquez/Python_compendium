# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of frequentist linear regression in R
# synthetic data
# 1 response (y) and 1 explanatory variable (x1) with 1 quadratic term


set.seed(1056)                    # set seed to replicate example
nobs= 150                         # number of obs in model 
x1 <- runif(nobs,0,5)             # random uniform variable
mu <- 1 + 5 * x1 - 0.75 * x1 ^ 2  # linear predictor, xb
y <- rnorm(nobs, mu, sd=0.5)      # create y as adjusted random normal variate 

plot(x1,y)                        # Visualize data
 

fit <- lm(y ~ x1+I(x1^2))          # Normal Fit 
summary(fit) 

xx <- seq(0,5,length=200)
ypred <- predict(fit,newdata=list(x1=xx),type="response")     # Prediction from the model 

plot(x1,y,pch=19,col="red")                                   # Plot regression line 
lines(xx,ypred,col='cyan',lwd=4,lty=2)

segments(x1,fitted(fit),x1,y,lwd=2,col="gray")                # add the residuals
