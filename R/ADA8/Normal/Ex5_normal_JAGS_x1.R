# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bayesian normal linear regression in R using JAGS
# synthetic data
# 1 response (y) and 1 explanatory variable (x1)

require(R2jags)
source("..//Auxiliar_functions/jagsresults.R")
require(ggplot2)

set.seed(1056)                 # set seed to replicate example
nobs= 500                      # number of obs in model 
x1 <- rnorm(nobs,5,2)          # random uniform variable

xb <- 2 + 3*x1                 # linear predictor
y <- rnorm(nobs, xb, sd=2)     # create y as adjusted random normal variate


# Prepare data for prediction 
M=500
xx = seq(from =  min(x1), 
         to =  max(x1), 
         length.out = M)


# prepare data for JAGS input
X <- model.matrix(~ 1 + x1)
K <- ncol(X)

jags_data <- list(Y = y,
                  X  = X,
                  K  = K,
                  N  = nobs,
                  M = M,
                  xx= xx)
    

# JAGS model
NORM <- "model{
    # Diffuse normal priors for predictors
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001) }
    
   # Uniform prior for standard deviation
     tau <- pow(sigma, -2)       # precision
     sigma ~ dunif(0, 100)       # standard deviation
   
    # Likelihood function 
    for (i in 1:N){
    Y[i]~dnorm(mu[i],tau)
    mu[i]  <- eta[i]
    eta[i] <- beta[1]+beta[2]*X[i,2]
    }

   # Prediction for new data
   for (j in 1:M){
   etax[j]<-beta[1]+beta[2]*xx[j]
   mux[j]  <- etax[j]
   Yx[j]~dnorm(mux[j],tau)
    }
}"

# set initial values
inits <- function () {
  list(
    beta = rnorm(K, 0, 0.01))
}

# define parameters
#params <- c("beta", "sigma","Yx")
params <- c("beta", "sigma")


jagsfit <- jags(
           data       = jags_data,
           inits      = inits,
           parameters = params,
           model      = textConnection(NORM),
           n.chains   = 3,
           n.iter     = 5000,
           n.thin     = 1,
           n.burnin   = 2500)

require(mcmcplots)
traplot(jagsfit)
#denplot(jagsfit)

#print(jagsfit,justify = "left", digits=2)


# Plot
yx <- jagsresults(x=jagsfit, params=c('Yx'))


normdata <- data.frame(x1,y)
gdata <- data.frame(x =xx, mean = yx[,"mean"],lwr1=yx[,"25%"],lwr2=yx[,"2.5%"],upr1=yx[,"75%"],upr2=yx[,"97.5%"])


ggplot(normdata,aes(x=x1,y=y))+ geom_point(colour="#de2d26",size=1,alpha=0.35)+
  geom_point(size=1.5,colour="red3")+
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.45, fill=c("orange3"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.35, fill = c("orange"),show.legend=FALSE) +
  geom_line(data=gdata,aes(x=xx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  theme_bw()
 
