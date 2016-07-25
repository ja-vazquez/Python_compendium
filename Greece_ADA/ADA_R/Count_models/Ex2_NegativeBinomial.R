# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# See also R. S. de Souza, et al. MNRAS, 453, 1928-1940, 2015
# doi:10.1093/mnras/stv1825
#
# Example of Bayesian negative binomial regression in R using JAGS
# synthetic data
# 1 response (y) and 1 explanatory variable (x1) 

library(R2jags)
library(MASS)
library(scales)
require(ggplot2)
source("..//Auxiliar_functions/jagsresults.R")


set.seed(141)                                              # set seed to replicate example
nobs <- 750                                                # number of obs in model
x1 <- runif(nobs,0,4)                                      # random uniform variable
xb <- -1 + 2.5*x1                                          # linear predictor

theta <- 0.75                                              # probability of success
exb <- exp(xb)                                             
nby <- rnegbin(n = nobs, mu = exb, theta = theta)          # create y as adjusted random variate

# Prepare data for prediction 
M=500
xx = seq(from = 0.95*min(x1), 
         to = 1.05*max(x1), 
         length.out = M)


# prepare data for input
negbml <-data.frame(nby, x1)
X <- model.matrix(~ x1, data=negbml)
K <- ncol(X)

NB.data <- list(
  Y = negbml$nby,
  X = X,
  K = K,
  N = nobs,
  M = M,
  xx = xx)


# JAGS model
sink("NBGLM.txt")
cat(" model{
    # Priors for coefficients
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001)}

    # Prior for dispersion

    theta ~ dgamma(1e-3,1e-3)
    # Likelihood function
    for (i in 1:N){
        Y[i] ~ dnegbin(p[i], theta)
        p[i] <- theta/(theta + mu[i])
        mu[i] <- exp(eta[i])
        eta[i] <- inprod(beta[], X[i,])
    }

  # Prediction
    for (j in 1:M){
        etax[j] <- beta[1]+beta[2]*xx[j]
        px[j] <- theta/(theta + mux[j])
        mux[j] <- exp(etax[j])
        Yx[j] ~ dnegbin(px[j], theta)
   }
}
  ",fill = TRUE)
sink()


# set initial values
inits <- function () { list(
  beta = rnorm(K, 0, 0.1), 
  theta = runif(0.00, 5) )
}

# define parameters
params <- c("beta", "theta","Yx")



# fit
NB2 <- jags(data = NB.data, 
            inits = inits,
            parameters = params,
            model = "NBGLM.txt",
            n.thin = 1,
            n.chains = 3,
            n.burnin = 2500,
            n.iter = 5000)

            
# check results
print(NB2, intervals=c(0.025, 0.975), digits=3)


# Plot
yx <- jagsresults(x=NB2, params=c('Yx'))


NBdata <- data.frame(x1,nby)
gdata <- data.frame(x =xx, mean = yx[,"50%"],lwr1=yx[,"25%"],lwr2=yx[,"2.5%"],upr1=yx[,"75%"],upr2=yx[,"97.5%"])

# transform scale
asinh_trans <- function(){
  trans_new(name = 'asinh', transform = function(x) asinh(x), 
            inverse = function(x) sinh(x))
}

ggplot(NBdata,aes(x=x1,y=nby))+ geom_point(colour="green",size=1,alpha=0.35)+
  geom_point(size=1.75,colour="green3")+
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.3, fill=c("red"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.2, fill = c("orange"),show.legend=FALSE) +
  geom_line(data=gdata,aes(x=xx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  theme_bw()+
  scale_y_continuous(trans = 'asinh',breaks=c(0,10,100,1000,10000,100000),
  labels=c("0",expression(10^1),expression(10^2),expression(10^3),expression(10^4),expression(10^5)))

















