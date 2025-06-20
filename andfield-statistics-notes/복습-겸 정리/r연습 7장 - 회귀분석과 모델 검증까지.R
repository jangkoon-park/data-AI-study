library(compute.es)
library(ez)
library(ggplot2)
library(multcomp)
library(nlme)
library(pastecs)
library(reshape)
library(car)
library(clinfun)
library(pgirmess)
library(mvnormtest)
library(mvoutlier)
library(corpcor)
library(GPArotation)
library(psych)
library(Hmisc)
library(boot)
library(polycor)
library(ggm)
library(QuantPsyc)
library(car)
library(boot)
# library(Rcmdr)
# 
# install.packages("QuantPsyc")
# install.packages("car")
# install.packages("BiocManager")
# BiocManager::install("graph")

#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/8장" 

#---연습문제  1장------
#load in the pubs.dat data:

pubs<-read.delim("pubs.dat", header = TRUE)

count(pubs)

#create a regression model to predict mortality from number of pubs:

pubsReg <-lm(mortality ~ pubs, data = pubs)

#obtain output of the regression:

summary(pubsReg)

#--Bootstrap the regression parameters:
#first execute the bootreg() function from the book chapter.


bootReg<-function(formula, data, i)
{
  d <- data[i,]
  fit <- lm(formula, data = d)
  return(coef(fit))
}


#We can then use the function to obtain the bootstrap samples:
bootResults<-boot(statistic = bootReg, formula = mortality ~ pubs, data = pubs, R = 2000)

#Obtain the bootstrap confidence intervals for the intercept and slope:
boot.ci(bootResults, type = "bca", index = 1)

#Obtain the bootstrap confidence intervals for the intercept and slope:
boot.ci(bootResults, type = "bca", index = 2)

#---연습문제 2장----

#load in the Supermodel.dat data--

Supermodel<-read.delim("Supermodel.dat", header = TRUE)

#----create a regression model to predict salery from Age, number of years being a supermodel and beauty-----
Supermodel.1 <- lm(salary~age + beauty + years, data= Supermodel)

#--obtain output of the regression---

summary(Supermodel.1)

##-----obtain the standardized beta estimates:------

lm.beta(Supermodel.1)

##---is the model valid?----
vif(Supermodel.1)
1/vif(Supermodel.1)
dwt(Supermodel.1)
resid(Supermodel.1)
rstandard(Supermodel.1)

#----Histogram-----
hist(rstandard(Supermodel.1))

##---Plot of the standardized residuals----- 
plot(Supermodel.1$fitted.values,rstandard(Supermodel.1))

#---It also helps to add a horizontal line at the mean--
abline(0,0)

#To obtain some other plots, we can use the plot() function:

plot(Supermodel.1)


#----Obtain casewise diagnostics and add them to the original data 
Supermodel$cooks.distance<-cooks.distance(Supermodel.1)
Supermodel$residuals<-resid(Supermodel.1)
Supermodel$standardized.residuals <- rstandard(Supermodel.1)
Supermodel$studentized.residuals <- rstudent(Supermodel.1)
Supermodel$dfbeta <- dfbeta(Supermodel.1)
Supermodel$dffit <- dffits(Supermodel.1)
Supermodel$leverage <- hatvalues(Supermodel.1)
Supermodel$covariance.ratios <- covratio(Supermodel.1)

#----List of standardized residuals greater than 2--------------
Supermodel$standardized.residuals>2| Supermodel$standardized.residuals < -2

#---Create a variable called large.residual, which is TRUE (or 1) if the residual is greater than 2, or less than -2.----------
Supermodel$large.residual <- Supermodel$standardized.residuals > 2| Supermodel$standardized.residuals < -2

#---Count the number of large residuals-------------
sum(Supermodel$large.residual)

#-----If we want to display only some of the variables we can use:----
Supermodel[,c("salary", "age", "beauty", "years", "standardized.residuals")]

#---Display the value of salary, age, beauty, years, and the standardized residual, for those cases which have a residual greater than 2 or less than -2.-------------

Supermodel[Supermodel$large.residual,c("salary", "age", "beauty", "years", "standardized.residuals")]

#------연습문제 3 장-------------------------

#-----Read in data for Glastonbury Festival Regression----

gfr<-read.delim("GlastonburyFestivalRegression.dat", header=TRUE)
gfr <- na.omit(gfr)
#---Create three dummy variables. Make sure you don't do this if there are missing data.---
gfr$crusty<-gfr$music=="Crusty"
gfr$metaller<-gfr$music=="Metaller"
gfr$indie.kid<-gfr$music=="Indie Kid"

#---Create a regression model---------

gfr.1 <- lm(gfr$change ~ gfr$crusty + gfr$metaller + gfr$indie.kid, data=gfr)
summary(gfr.1)

##---is the model valid?----
vif(gfr.1)
1/vif(gfr.1)

# The Durbin–Watson statistic: 

dwt(gfr.1)

#----Histogram-----
hist(rstandard(gfr.1))

##---Plot of the standardized residuals----- 
plot(gfr.1$fitted.values,rstandard(gfr.1))

#---It also helps to add a horizontal line at the mean--
abline(0,0)

#To obtain some other plots, we can use the plot() function:
plot(gfr.1)


#----Obtain casewise diagnostics and add them to the original data 
gfr$cooks.distance<-cooks.distance(gfr.1)
gfr$residuals<-resid(gfr.1)
gfr$standardized.residuals<-rstandard(gfr.1)
gfr$studentized.residuals<-rstudent(gfr.1)
gfr$dfbeta<-dfbeta(gfr.1)
gfr$dffit<-dffits(gfr.1)
gfr$leverage<-hatvalues(gfr.1)
gfr$covariance.ratios<-covratio(gfr.1)

#----List of standardized residuals greater than 2--------------
gfr$standardized.residuals>2| gfr$standardized.residuals < -2

#---Create a variable called large.residual, which is TRUE (or 1) if the residual is greater than 2, or less than -2.----------
gfr$large.residual <- gfr$standardized.residuals > 2| gfr$standardized.residuals < -2

#---Count the number of large residuals-------------
sum(gfr$large.residual)

#-----If we want to display only some of the variables we can use:----
gfr[,c("change", "crusty", "metaller", "indie.kid", "standardized.residuals")]

#---Display the value of change, crusty, metaller, indie.kid, and the standardized residual, for those cases which have a residual greater than 2 or less than -2.-------------

gfr[gfr$large.residual,c("change", "crusty", "metaller", "indie.kid", "standardized.residuals")]

#------Task 4----------

#-----Read in data for Child Aggression----

ChildAggression<-read.delim("ChildAggression.dat", header = TRUE)

#---Conduct the analysis hierarhically entering parenting style and sibling aggression in the first step-------

ChildAggression.1<-lm(Aggression ~ Sibling_Aggression + Parenting_Style, data = ChildAggression)

#------And the remaining variables in a second step-----

ChildAggression.2<-lm(Aggression ~ Sibling_Aggression+Parenting_Style+ Diet + Computer_Games + Television, data=ChildAggression)

#----View the output of the two regressions---

summary(ChildAggression.1)
summary(ChildAggression.2)

#----To compare the R2 in two models, use the ANOVA command---

anova(ChildAggression.1, ChildAggression.2)

#---VIF------

vif(ChildAggression.1)
1/vif(ChildAggression.1)

vif(ChildAggression.2)
1/vif(ChildAggression.2)


#----The Durbin-Watson test is obtained with either dwt() or durbinWatsonTest()---

durbinWatsonTest(ChildAggression.1)
dwt(ChildAggression.2)

#---Histogram of standardized residuals---

hist(rstandard(ChildAggression.2))

#--Plot of residuals against fitted (predicted) values, with a flat line at the mean--
plot(ChildAggression.2$fitted.values,rstandard(ChildAggression.2))
abline(0, 0)

#---We can obtain standardized parameter estimates with the lm.beta() function---

lm.beta(ChildAggression.1)
lm.beta(ChildAggression.2)

#---Confidence intervals are obtained with the confint() function----
confint(ChildAggression.2)

#----You can round them to make life easier----
round(confint(ChildAggression.2), 2)

#To obtain some other plots, we can use the plot() function:

plot(ChildAggression.2)

#----Obtain casewise diagnostics and add them to the original data 
ChildAggression$cooks.distance<-cooks.distance(ChildAggression.2)
ChildAggression$residuals<-resid(ChildAggression.2)
ChildAggression$standardized.residuals <- rstandard(ChildAggression.2)
ChildAggression$studentized.residuals <- rstudent(ChildAggression.2)
ChildAggression$dfbeta <- dfbeta(ChildAggression.2)
ChildAggression$dffit <- dffits(ChildAggression.2)
ChildAggression$leverage <- hatvalues(ChildAggression.2)
ChildAggression$covariance.ratios <- covratio(ChildAggression.2)

#----List of standardized residuals greater than 2--------------
ChildAggression$standardized.residuals>2| ChildAggression$standardized.residuals < -2

#---Create a variable called large.residual, which is TRUE (or 1) if the residual is greater than 2, or less than -2.----------
ChildAggression$large.residual <- ChildAggression$standardized.residuals > 2| ChildAggression$standardized.residuals < -2

#---Count the number of large residuals-------------
sum(ChildAggression$large.residual)

#-----If we want to display only some of the variables we can use:----
ChildAggression[,c("Aggression", "Sibling_Aggression","Parenting_Style","Diet","Computer_Games", "Television", "standardized.residuals")]

#---Display the value of Aggression, Parenting_Style, Diet, Computer_Games and Television and the standardized residual, for those cases which have a residual greater than 2 or less than -2.-------------

ChildAggression[ChildAggression$large.residual,c("Aggression", "Sibling_Aggression","Parenting_Style","Diet","Computer_Games", "Television", "standardized.residuals")]



