library(tidyverse)

### extensive cleanup for plot (run before plot) 
cleanup = theme(panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_line(color = "black", lineend = "square", size =0.7),
                plot.margin = margin(0.5, 0.5, 0.5, 1, "cm"),
                axis.ticks = element_line(size = 0.7, lineend = "square", color = "black"))

# Simple Linear Regression

names(Boston)
lm.fit=lm(medv~lstat,data=Boston)
lm.fit
summary(lm.fit)
names(lm.fit)
coef(lm.fit)
confint(lm.fit)
predict(lm.fit,data.frame(lstat=(c(5,10,15))), interval="confidence")
predict(lm.fit,data.frame(lstat=(c(5,10,15))), interval="prediction")
plot(lstat,medv)
abline(lm.fit)
abline(lm.fit,lwd=3)
abline(lm.fit,lwd=3,col="red")
newx = seq(min(Boston$lstat), max(Boston$lstat), length.out = length(Boston$lstat))
conf_interval <- predict(lm.fit, data.frame(lstat = newx), interval = "confidence", level = 0.95)
pred_interval <- predict(lm.fit, data.frame(lstat = newx), interval = "prediction", level = 0.95)
lines(newx, conf_interval[,2], col="blue", lty=2)
lines(newx, conf_interval[,3], col="blue", lty=2)
lines(newx, pred_interval[,2], col="blue", lty=2)
lines(newx, pred_interval[,3], col="blue", lty=2)

ggplot(data = Boston, aes(x=lstat, y=medv)) +
  geom_point() +
  geom_smooth(method = "lm", col = "red") +
#  geom_line(aes(x=newx, y=as.vector(pred_interval[,1]))) +
  geom_line(aes(x=newx, y=as.vector(pred_interval[,2])), color = "blue", lty = 2) +
  geom_line(aes(x=newx, y=as.vector(pred_interval[,3])), color = "blue", lty = 2) +
  cleanup



ggplot(data = Boston, aes(x=lstat, y=medv)) +
  geom_point() +
  stat_smooth(method = "lm", col = "red") +
  cleanup

ggplotRegression <- function (fit) {
  
  require(ggplot2)
  
  ggplot(fit$model, aes_string(x = names(fit$model)[2], y = names(fit$model)[1])) + 
    geom_point() +
    stat_smooth(method = "lm", col = "red") +
    cleanup +
    labs(title = paste("Adj R2 = ",signif(summary(fit)$adj.r.squared, 5),
                       "Intercept =",signif(fit$coef[[1]],5 ),
                       " Slope =",signif(fit$coef[[2]], 5),
                       " P =",signif(summary(fit)$coef[2,4], 5)))
}

ggplotRegression(lm.fit)

lm.fit2=lm(medv~lstat+I(lstat^2))
anova(lm.fit,lm.fit2)

pred_interval2 <- predict(lm.fit2, data.frame(lstat = newx), interval = "prediction", level = 0.95)

ggplot(data = Boston, aes(x=lstat, y=medv)) +
  geom_point() +
  geom_line(aes(x=newx, y=as.vector(pred_interval2[,1]))) +
  geom_line(aes(x=newx, y=as.vector(pred_interval2[,2])), color = "blue", lty = 2) +
  geom_line(aes(x=newx, y=as.vector(pred_interval2[,3])), color = "blue", lty = 2) +
  cleanup


plot(lstat,medv,col="red")
plot(lstat,medv,pch=20)
plot(lstat,medv,pch="+")
plot(1:20,1:20,pch=1:20)
par(mfrow=c(2,2))
plot(lm.fit)
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))
which.max(hatvalues(lm.fit))
