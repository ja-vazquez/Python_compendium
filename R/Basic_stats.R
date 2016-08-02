


########################################
########## Basic stats



myvars <- c("mpg", "hp", "wt")
head(mtcars[myvars])  #only these columns

########## using summary()
summary(mtcars[myvars])


#usign sapply ~like in .py

mystats <- function(x, na.omit=FALSE){
           if(na.omit)
              x <- x[!is.na(x)]
           m <- mean(x)
           n <- length(x)
           return(c(n=n, mean=m))  
}

sapply(mtcars[myvars], mystats)


########## using describe()

library(Hmisc)
myvars <- c("mpg", "hp", "wt")
describe(mtcars[myvars])

#same but with psych

install.packages("psych")
library(psych)
describe(mtcars[myvars])


##########  using aggregate()
# for a single value function, ie. mean

myvars <- c("mpg", "hp", "wt")
aggregate(mtcars[myvars], by=list(am=mtcars$am), mean)
aggregate(mtcars[myvars], by=list(am=mtcars$am), sd)


##########  using by()
# pick up your own function

dstats <- function(x)sapply(x, mystats)
myvars <- c("mpg", "hp", "wt")
by(mtcars[myvars], mtcars$am, dstats)



##########  using summaryBy()
# by group

install.packages("doBy")
library(doBy)
summaryBy(mpg + hp + wt ~ am, data=mtcars, FUN=mystats)


##########  using describe.by()
# stats by grouping

describeBy(mtcars[myvars], list(am=mtcars$am))



########################################
########## Tables

library(vcd)
head(Arthritis)

mytable <- with(Arthritis, table(Improved))
mytable

#show in frequencies
prop.table(mytable)*100


### Two way tables

mytable <- xtabs(~Treatment + Improved, data= Arthritis)
mytable

#for summing with (1st)(2nd) variable

margin.table(mytable, 1)
margin.table(mytable, 2)

# add marginal sums
#(both columns and rows)

addmargins(mytable)



########## Two way table with CrossTable
#more complete stats

install.packages("gmodels")
library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)



########## Three way contingency table

mytable <- xtabs(~Treatment + Sex + Improved, data=Arthritis)
mytable

margin.table(mytable, 3)

#ftable for compact and attactive  version
ftable(prop.table(mytable, c(1,2)))



########## Chi-square test

library(vcd)
mytable <- xtabs(~Treatment+Improved, data = Arthritis)
chisq.test(mytable)

mytable <- xtabs(~Improved+Sex, data = Arthritis)
chisq.test(mytable)



########## Fisher test

mytable <- xtabs(~Treatment+Improved, data = Arthritis)
fisher.test(mytable)




########################################
##########  Correlations

#by default uses Pearson, that assesses the degree
#of linear relationship


states <- state.x77[, 1:6]
cov(states)
cor(states)

cor(states, method = "spearman")

x <- states[, c("Population", "Income", "Illiteracy", "HS Grad")]
y <- states[, c("Life Exp", "Murder")]
cor(x, y)


########## Correlation coefficients

cor.test(states[,3], states[,5])

# p-value = 1.258e-08, they are correlated !


# Test of significance via corr.test()
# shows correlation and p-values
library(psych)
corr.test(states, use='complete')


########## T-tests

library(MASS)
t.test(Prob ~ So, data = UScrime)
# reject the hypothesis that states have equal probabilities

 
### Dependent test
library(MASS)
sapply(UScrime[c("U1", "U2")], function(x)(c(mean=mean(x), sd=sd(x))))

with(UScrime, t.test(U1, U2, paired = TRUE))











