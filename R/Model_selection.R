

######################################################################
######## Model Selection


######## AIC and BIC

x <- logL[mainseqhyades]
y <- B.V[mainseqhyades]
plot(x,y)

model1 <- lm(y~x)
model2 <- lm(y~x+I(x^2))
model3 <- lm(y~x+I(x^2)+I(x^3))
model4 <- lm(y~x+I(x^2)+I(x^3)+I(x^4))
model5 <- lm(y~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))
model6 <- lm(y~x+I(x^2)+I(x^3)+I(x^4)+I(x^5)+I(x^6))

library(stats4) #Necessary for the BIC function
AIC.m <- c(AIC(model1),AIC(model2),AIC(model3),
           AIC(model4),AIC(model5),AIC(model6))
BIC.m <- c(BIC(model1),BIC(model2),BIC(model3),
           BIC(model4),BIC(model5),BIC(model6))
plot(1:6,AIC.m,ylim=c(-280,-220),pch=19,xlab="Order",
     ylab="AIC/BIC Value")
lines(1:6,AIC.m)
points(1:6,BIC.m,pch=21,col=2)
lines(1:6,BIC.m,col=2)
legend("topright",legend=c("AIC","BIC"),col=1:2,
       text.col=1:2,pch=c(19,21))
which.min(AIC.m)
which.min(BIC.m)

########R^2 and Adjusted-R^2

r.sq <- c(summary(model1)[[8]],summary(model2)[[8]],
          summary(model3)[[8]],summary(model4)[[8]],
          summary(model5)[[8]],summary(model6)[[8]])
adj.r.sq <- c(summary(model1)[[9]],summary(model2)[[9]],
              summary(model3)[[9]],summary(model4)[[9]],
              summary(model5)[[9]],summary(model6)[[9]])
r.sq
adj.r.sq
which.max(r.sq)
which.max(adj.r.sq)

