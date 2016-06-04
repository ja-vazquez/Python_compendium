################################################################
## consistent batch means and imse estimators of Monte Carlo standard errors
## author: Murali Haran
## An R function for computing consistent batch means estimate
## of standard error
################################################################
##  References
## (1) Galin L. Jones, Murali Haran, Brian S. Caffo, and Ronald Neath,
## "Fixed-Width Output Analysis for Markov Chain Monte Carlo" (2006),
## Journal of the American Statistical Association, 101:1537--1547

## AND a less technical reference (with a direct comparison to
## the Gelman-Rubin diagnostic)
## (2) Flegal, J.M., Haran, M., and Jones, G.L. (2008) Markov chain
## Monte Carlo: Can we trust the third significant figure?
## Statistical Science, 23,250--260. 
################################################################

## input: vals, a vector of N values (from a Markov chain),bs=batch size
## default bs (batch size) is "sqroot"=> number of batches is the square root of the run length
## if bs is "cuberoot", number of batches is the cube root of the run length
## output: list consisting of estimate of expected value and the Monte Carlo standard error of the estimate

## NOTE: YOU DO NOT NEED TO DOWNLOAD THIS FILE TO RUN BATCHMEANS IN R
## SIMPLY USE THE COMMAND BELOW FROM YOUR R COMMAND LINE
## source("http://www.stat.psu.edu/~mharan/batchmeans.R")

# new version: Sep.12, 2005
## Input: vals is a vector of values from a Markov chain produced by the Metropolis-Hastings algorithm
## bs provides the batch size, either "sqroot" for the square root of the sample size (recommended)
## or "cuberoot" for cube root of the sample size
## USAGE:  bm(vectorname)
## This will return the mean of the vector, along with an estimate of MCMC standard error based
## on the consistent batchmeans estimator
bm <- function(vals,bs="sqroot",warn=FALSE)
  {
    N <- length(vals)
    if (N<1000)
      {
        if (warn) # if warning
          cat("WARNING: too few samples (less than 1000)\n")
        if (N<10)
          return(NA)
      }

    if (bs=="sqroot") 
      {
        b <- floor(sqrt(N)) # batch size
        a <- floor(N/b) # number of batches
      }
    else
      if (bs=="cuberoot") 
        {
          b <- floor(N^(1/3)) # batch size
          a <- floor(N/b) # number of batches
        }
    else # batch size provided
      {
        stopifnot(is.numeric(bs))  
        b <- floor(bs) # batch size
        if (b > 1) # batch size valid
          a <- floor(N/b) # number of batches
        else
          stop("batch size invalid (bs=",bs,")")
      }
    
    Ys <- sapply(1:a,function(k) return(mean(vals[((k-1)*b+1):(k*b)])))

    muhat <- mean(Ys)
    sigmahatsq <- b*sum((Ys-muhat)^2)/(a-1)

    bmse <- sqrt(sigmahatsq/N)

    return(list(est=muhat,se=bmse))
  }

## apply bm to each col of a matrix of MCMC samples
## input: mcmat is a matrix with each row corresponding to a sample from the multivariate distribution of interest
## skip = vector of columns to skip
## output: matrix with number of rows=number of dimensions of distribution and 2 columns (estimate and s.error)
bmmat=function(mcmat,skip=NA)
{
  if (!any(is.na(skip)))
    {
      num=ncol(mcmat)-length(skip)
      mcmat=mcmat[-skip] # remove columns to be skipped
    }
  else # assume it is NA
    num=ncol(mcmat)

  bmvals=matrix(NA,num,2,dimnames=list(paste("V",seq(1,num),sep=""),c("est","se"))) # first col=est, second col=MS s.error

  bmres=apply(mcmat,2,bm)
  for (i in 1:num)
    {
      bmvals[i,]=c(bmres[[i]]$est,bmres[[i]]$se)
    }
  return(bmvals)
}

## Geyer's initial monotone positive sequence estimator (Statistical Science, 1992)
## input: Markov chain output (vector)
## output: monte carlo standard error estimate for chain
imse <- function(outp,asymvar=FALSE)
  {
    chainAC <- acf(outp,type="covariance",plot = FALSE)$acf ## USE AUTOCOVARIANCES
    AClen <- length(chainAC)
    gammaAC <- chainAC[1:(AClen-1)]+chainAC[2:AClen]

    m <- 1
    currgamma <- gammaAC[1]
    k <- 1
    while ((k<length(gammaAC)) && (gammaAC[k+1]>0) && (gammaAC[k]>=gammaAC[k+1]))
      k <- k +1

    if (k==length(gammaAC)) # added up until the very last computed autocovariance
      cat("WARNING: may need to compute more autocovariances for imse\n")
    sigmasq <- -chainAC[1]+2*sum(gammaAC[1:k])

    if (asymvar) # return asymptotic variance
      return(sigmasq)
    
    mcse <- sqrt(sigmasq/length(outp))
    return(mcse)
  }

imsemat=function(mcmat,skip=NA)
  {
    if (!is.na(skip))
      num=ncol(mcmat)-length(skip)
    else
      num=ncol(mcmat)
    
    imsevals=matrix(NA,num,2,dimnames=list(paste("V",seq(1,num),sep=""),c("est","se"))) # first col=est, second col=MS s.error

    mcmat=mcmat[-skip] # remove columns to be skipped
    imseres=apply(mcmat,2,imse)
    for (i in 1:num)
      {
        imsevals[i,]=c(mean(mcmat[,i]),imseres[i])
      }
    return(imsevals)
  }

## plot how Monte Carlo estimates change with increase in sample size
## input: samp (sample vector) and g (where E(g(x)) is quantity of interest)
## output: plot of estimate over time (increasing sample size)
## e.g.: estvssamp(outp,plotname=expression(paste("E(", beta,")")))
## if the values from the plot are desired, can use the flag retval and set it to TRUE
## e.g.: estvssamp(outp,plotname=expression(paste("E(", beta,")")), retval=TRUE)
estvssamp = function(samp, g=mean, plotname="mean estimates", retval=FALSE)
  {
    if (length(samp)<100)
      batchsize = 1
    else
      batchsize = length(samp)%/%100

    est = c()
    for (i in seq(batchsize,length(samp),by=batchsize))
      {
        est = c(est, g(samp[1:i]))
      }

##    plot(seq(batchsize,length(samp),by=batchsize),est,main=paste("M.C. estimates vs. sample size\n"),type="l",xlab="sample size",ylab="MC estimate")
    xvals= seq(batchsize,length(samp),by=batchsize)
    yvals=est
    plot(xvals,yvals,main=plotname,type="l",xlab="sample size",ylab="MC estimate")
    if (retval)
      return(cbind(xvals, yvals))
    
  }

## estimate effective sample size (ESS) as described in Kass et al (1998) and Robert and Casella (2004; pg.500)
## ESS=size of an iid sample with the same variance as the current sample
## ESS = T/kappa  where kappa (the `autocorrelation time' for the sample) = 1 + 2 sum of all lag auto-correlations
## Here we use a version analogous to IMSE where we cut off correlations beyond a certain lag (to reduce noise)
ess = function(outp,imselags=TRUE)
  {
    if (imselags) # truncate number of lags based on imse approach
      {
        chainACov <- acf(outp,type="covariance",plot = FALSE)$acf ## USE AUTOCOVARIANCES
        ACovlen <- length(chainACov)
        gammaACov <- chainACov[1:(ACovlen-1)]+chainACov[2:ACovlen]
        
        m <- 1
        currgamma <- gammaACov[1]
        k <- 1
        while ((k<length(gammaACov)) && (gammaACov[k+1]>0) && (gammaACov[k]>=gammaACov[k+1]))
          k <- k +1
        cat("truncated after ",k," lags\n")
        if (k==length(gammaACov)) # added up until the very last computed autocovariance
          cat("WARNING: may need to compute more autocovariances/autocorrelations for ess\n")

        chainACorr = acf(outp,type="correlation",plot = FALSE)$acf ## USE AUTOCORRELATIONS
        if (k==1)
          ACtime = 1
        else
          ACtime <- 1 + 2*sum(chainACorr[2:k])  # add autocorrelations up to lag determined by imse
      }
    else
      {
        chainACorr = acf(outp,type="correlation",plot = FALSE)$acf ## USE AUTOCORRELATIONS
        ACtime <- 1 + 2*sum(chainACorr[-c(1)])
      }
    
    return(length(outp)/ACtime)
  }

## effective samples per second
espersec = function(outp,numsec,imselags=TRUE)
  {
    essval = ess(outp,imselags)
    return(essval/numsec)
  }
