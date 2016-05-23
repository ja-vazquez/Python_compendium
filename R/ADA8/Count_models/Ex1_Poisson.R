# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bayesian Poisson regression in R using JAGS
# synthetic data
# 1 response (y) and 1 explanatory variable (x1) 


require(R2jags)
require(ggplot2)
source("..//Auxiliar_functions/jagsresults.R")


set.seed(2016)                                        # set seed to replicate example
nobs <- 500                                           # number of observations
x1 <- runif(nobs)                                     # random uniform variable
xb <- 1 + 2*x1                                        # linear predictor
py <- rpois(nobs, exp(xb))                            # create py as adjusted random Poisson variate
poismod <- data.frame(py,x1)


# Prepare data for prediction 
M=1000                                                # Sample size
xx = seq(from =  min(x1), 
         to =  max(x1), 
         length.out = M)

# prepare data for JAGS input
X <- model.matrix(~ x1, data = poismod)
K <- ncol(X)                                          # Number of betas

POIS.data <- list(Y = py,
                  X = X,       
                  K = K,           
                  N = nobs,
                  xx = xx, 
                  M = M)           


# JAGS model
Pois<-"model{

    # non-informative prior for coefficients  
    for (i in 1:K) {beta[i] ~ dnorm(0, 1e-4)}               

    # likelihood function
    for (i in 1:N) {
        Y[i] ~ dpois(mu[i])                                 
        log(mu[i]) <- inprod(beta[], X[i,])  
    }

    # Prediction for new data
    for (j in 1:M){
        log(mux[j])<-beta[1]+beta[2]*xx[j]
        Yx[j]~dpois(mux[j])
    }
}"

# set initial values
inits  <- function () {
    list(beta = rnorm(K, 0, 0.1))
}

# set parameter for prediction
params <- c("Yx")

# fit
P1 <-   jags(data       = POIS.data,
             inits      = inits,
             parameters = params,
             model      = textConnection(Pois),
             n.thin     = 1,
             n.chains   = 3,
             n.burnin   = 2500,
             n.iter     = 5000)

# check results
print(P1, intervals=c(0.025, 0.975), digits=3)

# Plot
yx <- jagsresults(x=P1, params=c('Yx'))

gdata <- data.frame(x =xx, mean = yx[,"mean"],lwr1=yx[,"25%"],lwr2=yx[,"2.5%"],upr1=yx[,"75%"],upr2=yx[,"97.5%"])

ggplot(poismod ,aes(x=x1,y=py))+ 
  geom_point(colour="blue3",size=1.5,alpha=0.9)+
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.35, fill=c("orange2"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.15, fill = c("orange"),show.legend=FALSE) +
  geom_line(data=gdata,aes(x=xx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  theme_bw() 
 
