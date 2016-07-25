# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bayesian normal linear regression in R using JAGS
# synthetic data
# 1 response (y) and 4 explanatory variables (x1,x2,x3,x4)

#install.packages("plot3D",dependencies = T)        # Run this if plot3D not previously installed

require(R2jags)
require(mcmcplots)      

set.seed(1056)                                      # set seed to replicate example
nobs= 500                                           # number of obs in model 
x1 <- runif(nobs)                                   # random uniform variable
x2 <- runif(nobs)                                  
x3 <- runif(nobs)                                   
x4 <- runif(nobs)  
xb <- 2 + 3*x1+4*x2-1*x3+0.75*x4                    # linear predictor, xb
y <- rnorm(nobs, xb, sd=1.5)                        # create y as adjusted random normal variate

# prepare data for JAGS input
X <- model.matrix(~ 1 + x1+x2+x3+x4)
K <- ncol(X)
jags_data <- list(Y = y,
                  X  = X,
                  K  = K,
                  N  = nobs)
    

# JAGS model
NORM <-" model{
    # Diffuse normal priors for predictors
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001) }
    
   # Uniform prior for standard deviation
     tau <- pow(sigma, -2)       # precision
     sigma ~ dunif(0, 100)       # standard deviation
   
    # Likelihood function 
    for (i in 1:N){
    Y[i]~dnorm(mu[i],tau)
    mu[i]  <- eta[i]
    eta[i] <- inprod(beta[], X[i,])
    }
    }"

# set initial values
inits <- function () {
  list(
    beta = rnorm(K, 0, 0.01))
}

# define parameters
params <- c("beta", "sigma")

# fit
jagsfit <- jags(
           data       = jags_data,
           inits      = inits,
           parameters = params,
           model      = textConnection(NORM),
           n.chains   = 3,
           n.iter     = 5000,
           n.thin     = 1,
           n.burnin   = 2500)

print(jagsfit,justify = "left", digits=2)

# plot chains
traplot(jagsfit,c("beta", "sigma"))

# plot posteriors
denplot(jagsfit,c("beta", "sigma"))

# plot all coefficients
caterplot(jagsfit,c("beta", "sigma"))


