# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of frequentist linear regression in R
# synthetic data
# 1 response (y) and 1 explanatory variable (x1)


set.seed(1056)                    # set seed to replicate example
nobs= 100                         # number of observations 
x1 <- runif(nobs)                 # random uniform variable
mu <- 1 + 3*x1                    # linear predictor
y <- rnorm(nobs, mu, sd=0.25)     # create y as adjusted random normal variate 

# Fit model
fit <- lm(y ~ x1)                 # Normal Fit of the synthetic data. 
summary(fit) 

xx <- seq(0,5,length=200)
ypred <- predict(fit,newdata=list(x1=xx),type="response") # Prediction from the model 

 
plot(x1,y,pch=19,col="red")                               # Plot regression line
lines(xx,ypred,col='cyan',lwd=4,lty=2)

segments(x1,fitted(fit),x1,y,lwd=2,col="gray")            # Add the residuals
