# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bernoulli regression in R
# synthetic data
# 1 response (y) and 1 explanatory variable (x1) with quadratic term

require(ggplot2)

set.seed(13979)                          # set seed to replicate example
nobs <- 2500                             # number of obsservations 
nmax <- 1.5                              # limits on random variable
nmin <- - 0.2
x1 <- runif(nobs,nmin,nmax)              # create y as adjusted random bernoulli variate


xb <- -3 + 15*x1-7.25*x1^2               # linear predictor
exb <- 1/(1+exp(-xb))                    # inverse-logit
by <- rbinom(nobs,size=1, prob = exb)
logitmod <-data.frame(by, x1) 


# Fit a normal model 
fit_norm <- lm(by ~ x1+I(x1^2),data = logitmod)
pred_norm <- predict(fit_norm, type = 'response')
data_norm <- data.frame(x1,pred_norm)


# Fit a logit model to the same data
fit_logit <- glm(by ~ x1+I(x1^2),data=logitmod,family = 'binomial')
pred_logit <- predict(fit_logit, type = 'response')
data_logit <- data.frame(x1,pred_logit)


# Bin data for visualization only
binx<-0.05
t.breaks <-cut(x1, seq(nmin,nmax, by=binx))
means <-tapply(by, t.breaks, mean)
semean <-function(x) sd(x)/sqrt(length(x))
means.se <-tapply(by, t.breaks, semean)
gbin<-data.frame(x=seq(nmin+binx,nmax, by=binx),y=means)

# plot
ggplot(logitmod,aes(x=x1,y=by))+ 
  geom_point(colour="cyan2",size=1,alpha=0.25,position = position_jitter (height  = 0.035))+
  
  geom_errorbar(data=gbin,aes(x=x,y=y,ymin=y-2*means.se,ymax=y+2*means.se),alpha=0.85,
                colour="gray70",width=0.005)+
  geom_line(aes(y=pred_norm), col='green2', size=1.2,data=data_norm,linetype="dotted") +  
  geom_line(aes(y=pred_logit),data=data_logit,size=1.2,col='red3')+
  geom_point(aes(x=x,y=y),size=2.5,data=gbin,colour="gray70")+
  theme_bw()+
  ylab("y")+
 xlab("x")+coord_cartesian(ylim=c(-0.2,1.025))


