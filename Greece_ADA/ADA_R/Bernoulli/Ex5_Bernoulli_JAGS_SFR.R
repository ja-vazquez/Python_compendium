.# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bayesian Bernoulli regression in R using JAGS
# real data from Biffi and Maio, 2013 - http://adsabs.harvard.edu/cgi-bin/bib_query?arXiv:1309.2283
# 
# 1 response (y): star formation
# 1 explanatory variable (x1): molecular fraction

require(R2jags)
require(ggplot2)
source("..//Auxiliar_functions/jagsresults.R")

# read data
SFR_dat<-read.csv("..//astro_data/SFR.csv")

x1 <- log(SFR_dat$Xmol,10)                   
by <- SFR_dat$SFR    
nobs <- nrow(SFR_dat)

# Prepare data for prediction 
M=500
xx = seq(from =  min(x1), 
         to =  max(x1), 
         length.out = M)


# Construct data dictionary
logitmod <-data.frame(by, x1)
X <- model.matrix(~ 1+x1+I(x1^2)+I(x1^3), 
                  data = logitmod)

XX <- model.matrix(~1+xx+I(xx^2)+I(xx^3))
K <- ncol(X)
logit_data <- list(Y  = logitmod$by, # Response variable
                   X  = X,           # Predictors
                   K  = K,           # Number of Predictors including the intercept 
                   N  = nobs,        # Sample size 
                   XX = XX, 
                   M = M
)

# JAGS code
LOGIT<-"model{

    # Diffuse normal priors for predictors
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001) }

    # Likelihood function 
    for (i in 1:N){  
        Y[i] ~ dbern(p[i])
        logit(p[i]) <- eta[i]
        eta[i]  <- inprod(beta[], X[i,])
    }

    # Prediction for new data
    for (j in 1:M){
        etax[j]<-inprod(beta[], XX[j,])
        logit(px[j]) <- etax[j]
        Yx[j]~dbern(px[j])
    }
}"

#A function to generate initial values for mcmc
inits  <- function () {
  list(beta  = rnorm(ncol(X), 0, 0.1)  )  
}

# define parameters
params <- c("beta","px")

# Fit
jagsfit<- jags(data       = logit_data,
               inits      = inits,
               parameters = params,
               model      = textConnection(LOGIT),
               n.thin     = 1,
               n.chains   = 3,
               n.burnin   = 2500,
               n.iter     = 8000)


# check results
jagsresults(x=jagsfit, params=c("beta"))


# Bin data for visualization
binx<-0.5
t.breaks <-cut(x1, seq(min(x1),max(x1), by=binx))
means <-tapply(by, t.breaks, mean)
semean <-function(x) sd(x)/sqrt(length(x))
means.se <-tapply(by, t.breaks, semean)

# Plot
y <- jagsresults(x=jagsfit, params=c('px'))
x <- xx
gdata <- data.frame(x =xx, mean = y[,"mean"],lwr1=y[,"25%"],lwr2=y[,"2.5%"],upr1=y[,"75%"],upr2=y[,"97.5%"])

gbin<-data.frame(x=seq(binx+min(x1),max(x1), by=binx),y=means)

ggplot(logitmod,aes(x=x1,y=by))+ 
  geom_point(colour="red",size=1.25,alpha=0.85,position = position_jitter (h = 0.075))+
  geom_point(aes(x=x,y=y),size=3,data=gbin,colour="blue3")+
  geom_errorbar(data=gbin,aes(x=x,y=y,ymin=y-2*means.se,ymax=y+2*means.se),
                colour="blue",width=0.01)+
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.45, fill=c("orange2"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.35, fill = c("orange"),show.legend=FALSE) +
  geom_line(data=gdata,aes(x=xx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  theme_bw()+coord_cartesian(ylim=c(0,1))+xlab(expression(log~x[mol]))+ylab("Probability of star formation activity")+
  theme(axis.title=element_text(size=25))


