## Markov chain Monte Carlo algorithm for a Bayesian (single) change point model
## read in the data
## chptdat = read.table("chpt.dat",header=T)
## Y = chptdat$Ener
## chptdat = read.table("coal.dat",header=T)
## Y = chptdat$Deaths
KGUESS = 10 # our guess for k based on exploratory data analysis
## Note: this function is not written in the most efficient way since its purpose is primarily instructive 

mhsampler = function(NUMIT=1000,dat=Y)
  {
    n = length(dat)
    cat("n=",n,"\n")
    ## set up
    ## NUMIT x 5 matrix to store Markov chain values
    ## each row corresponds to one of 5 parameters in order: theta,lambda,k,b1,b2
    ## each column corresponds to a single state of the Markov chain
    mchain = matrix(NA, 5, NUMIT)
    acc = 0 # count number of accepted proposals (for k only)
    
    ## starting values for Markov chain
    ## This is somewhat arbitrary but any method that produces reasonable values for each parameter is usually adequate.
    ## For instance, we can use approximate prior means or approximate MLEs.
    
    kinit = floor(n/2) # approximately halfway between 1 and n
    mchain[,1] = c(1,1,kinit,1,1)
    
    for (i in 2:NUMIT)
      {
        ## most upto date state for each parameter
        currtheta = mchain[1,i-1]
        currlambda = mchain[2,i-1]
        currk = mchain[3,i-1]
        currb1 = mchain[4,i-1]
        currb2 = mchain[5,i-1]
        
        ## sample from full conditional distribution of theta (Gibbs update)
        currtheta = rgamma(1,shape=sum(Y[1:currk])+0.5, scale=currb1/(currk*currb1+1))
        
        ## sample from full conditional distribution of lambda (Gibbs update)
        currlambda = rgamma(1,shape=sum(Y[(currk+1):n])+0.5, scale=currb2/((n-currk)*currb2+1))
        
        ## sample from full conditional distribution of k (Metropolis-Hastings update)
        propk = sample(x=seq(2,n-1), size=1) # draw one sample at random from uniform{2,..(n-1)}

        ## Metropolis accept-reject step (in log scale)
        logMHratio = sum(Y[1:propk])*log(currtheta)+sum(Y[(propk+1):n])*log(currlambda)-propk*currtheta- (n-propk)*currlambda - (sum(Y[1:currk])*log(currtheta)+sum(Y[(currk+1):n])*log(currlambda)-currk*currtheta- (n-currk)*currlambda)
        
        logalpha = min(0,logMHratio) # alpha = min(1,MHratio)
        if (log(runif(1))<logalpha) # accept if unif(0,1)<alpha, i.e. accept with probability alpha, else stay at current state
          {
            acc = acc + 1 # increment count of accepted proposals
            currk = propk
          }
        
        currk = KGUESS # if we do not sample k (k fixed)
        
        ## sample from full conditional distribution of b1 (Gibbs update): draw from Inverse Gamma
        currb1 = 1/rgamma(1,shape=0.5, scale=1/(currtheta+1))
        
        ## sample from full conditional distribution of b2 (Gibbs update): draw from Inverse Gamma
        currb2 = 1/rgamma(1,shape=0.5, scale=1/(currlambda+1))
        
        ## update chain with new values
        mchain[,i] = c(currtheta,currlambda,currk,currb1,currb2)
        
      }

    cat("Markov chain algorithm ran for ",NUMIT,"iterations (acc.rate for k=",acc/(NUMIT-1),")\n")
    cat("Parameters are in order: theta, lambda, k, b1, b2\n")
    return(mchain)
  }
