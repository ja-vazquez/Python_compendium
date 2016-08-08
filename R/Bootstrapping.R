
########################################
########## Resampling and Bootstraping

### Permutation tests

install.packages('coin')
library(coin)

score <- c(40, 57, 45, 55, 58, 57, 64, 55, 62, 65)
treatment <- factor(c(rep('A', 5), rep('B', 5)))
mydata <- data.frame(treatment, score)

plot(score, treatment)
t.test(score~treatment, data=mydata, var.equal=TRUE)

oneway_test(score~treatment, data=mydata, distribution='exact')
#they are not so different, but inconclusive test tough


# Wilcoxon-Man-Whitney test

library(MASS)
UScrime <- transform(UScrime, So=factor(So))
plot(UScrime$So, UScrime$Prob)

wilcox_test(Prob~So, data=UScrime, distribution='exact')
#they are not equal, with high confidence


library(multcomp)
set.seed(1234)
oneway_test(response~trt, data=cholesterol, 
            distribution=approximate(B=9999))

#different in response among patients


















