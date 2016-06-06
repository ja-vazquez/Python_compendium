
xs = rnorm(10000)
hist(xs)

xcount = sum((xs>-1) & (xs<0)) # count number of draws between -1 and 0
xcount/10000 # Monte Carlo estimate of probability
pnorm(0)-pnorm(-1) # Compare it to R's answer (cdf at 0) - (cdf at -1) 


#Example
chptdat = read.table("http://www.stat.psu.edu/~mharan/MCMCtut/COUP551_rates.dat",skip=1) 

Y=chptdat[,2] # store data in Y
ts.plot(Y,main="Time series plot of change point data")

source("MCMCchpt.R") # with appropriate filepathname

mchain <- mhsampler(NUMIT=1000,dat=Y) # call the function with appropriate arguments 

mean(mchain[1,]) # obtain mean of first row (thetas) 
apply(mchain,1,mean) # compute means by row (for all parameters at once)
apply(mchain,1,median) # compute medians by row (for all parameters at once)

plot(density(mchain[1,]),main="smoothed density plot for theta posterior")
plot(density(mchain[2,]),main="smoothed density plot for lambda posterior")
hist(mchain[3,],main="histogram for k posterior")

sum(mchain[2,]>10)/length(mchain[2,])

# currk <- KGUESS 

mchain <- mhsampler(NUMIT=1000,dat=Y) 

estvssamp(mchain[3,]) 

acf(mchain[1,],main="acf plot for theta")
acf(mchain[2,],main="acf plot for lambda")
acf(mchain[3,],main="acf plot for k")
acf(mchain[4,],main="acf plot for b1")
acf(mchain[5,],main="acf plot for b2")

mchain2 <- mhsampler(NUMIT=1000,dat=Y)
estvssamp(mchain2[3,]) 

bm(mchain[1,])
bm(mchain[2,])
bm(mchain[3,])
bm(mchain[4,])
bm(mchain[5,])

mchain2 <- mhsampler(NUMIT=100000,dat=Y)