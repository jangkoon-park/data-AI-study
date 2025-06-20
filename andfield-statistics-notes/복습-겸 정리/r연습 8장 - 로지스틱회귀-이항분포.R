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

#---연습문제  1장------------------------------------------------------
#load data
displayData<-read.delim("Display.dat", header = TRUE)

#look at first 6 cases of data
head(displayData)
displayData$display <- ifelse(displayData$display == "Yes", 1, 0)
#Create the two hierarchical models:

displayModel.1 <- glm(display ~ fb, data = displayData, family = binomial())

displayModel.2 <- update(displayModel.1, .~. + age + fb:age)

summary(displayModel.1)
summary(displayModel.2)


modelChi <- displayModel.1$null.deviance - displayModel.1$deviance
chidf <- displayModel.1$df.null - displayModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

logisticPseudoR2s <- function(LogModel) {
  dev <- LogModel$deviance 
  nullDev <- LogModel$null.deviance 
  modelN <-  length(LogModel$fitted.values)
  R.l <-  1 -  dev / nullDev
  R.cs <- 1- exp ( -(nullDev - dev) / modelN)
  R.n <- R.cs / ( 1 - ( exp (-(nullDev / modelN))))
  cat("Pseudo R^2 for logistic regression\n")
  cat("Hosmer and Lemeshow R^2  ", round(R.l, 3), "\n")
  cat("Cox and Snell R^2        ", round(R.cs, 3), "\n")
  cat("Nagelkerke R^2           ", round(R.n, 3),    "\n")
}
#Make sure that you have executed the function from the chapter first:
logisticPseudoR2s(displayModel.1)


#Compute odds ratio
exp(displayModel.1$coefficients)

#Compute confidence intervals
exp(confint(displayModel.1))

#compare model1 and model 2
modelChi <- displayModel.1$deviance - displayModel.2$deviance
chidf <- displayModel.1$df.residual - displayModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

anova(displayModel.1, displayModel.2)

#R2
logisticPseudoR2s(displayModel.2)

#odds ratio
exp(displayModel.2$coefficients)

#cofidence intervals
exp(confint(displayModel.2))


#Diagnostics for model 1

displayData$predicted.probabilities<-fitted(displayModel.1)
displayData$standardized.residuals<-rstandard(displayModel.1)
displayData$studentized.residuals<-rstudent(displayModel.1)
displayData$dfbeta<-dfbeta(displayModel.1)
displayData$dffit<-dffits(displayModel.1)

displayData $leverage<-hatvalues(displayModel.1)

#Predicted Probabilities:
head(displayData[, c("display", "fb", "age", "predicted.probabilities")])

#Residuals:
displayData[, c("leverage", "studentized.residuals", "dfbeta")]





#-----------------------연습문제  2장--------------------------

#load data
burnoutData<-read.delim("Burnout.dat", header = TRUE)

#look at first 6 cases of data
head(burnoutData)

#Relevel the categorical variable burnout:
# burnoutData$burnout<-relevel(burnoutData$burnout, "Not Burnt Out")

# head(displayData)
burnoutData$burnout <- ifelse(burnoutData$burnout == "Not Burnt Out", 0, 1)

#Create the two hierarchical models:

burnoutModel.1 <- glm(burnout ~ loc + cope, data = burnoutData, family = binomial())
burnoutModel.2 <- update(burnoutModel.1, .~. + teaching + research + pastoral)

summary(burnoutModel.1)
summary(burnoutModel.2)

#Compute model 1 improvement
modelChi <- burnoutModel.1$null.deviance - burnoutModel.1$deviance
chidf <- burnoutModel.1$df.null - burnoutModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob


#Compute model 1 R2 (remember to execute the function code first)
logisticPseudoR2s(burnoutModel.1)

#Compute odds ratio
exp(burnoutModel.1$coefficients)

#Confidence interval
exp(confint(burnoutModel.1))

#compare model1 and model 2
modelChi <- burnoutModel.1$deviance - burnoutModel.2$deviance
chidf <- burnoutModel.1$df.residual - burnoutModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

#Compute model 2 improvement from baseline:
modelChi <- burnoutModel.2$null.deviance - burnoutModel.2$deviance
chidf <- burnoutModel.2$df.null - burnoutModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

#Compute model 2 R2 (remember to execute the function code first)
logisticPseudoR2s(burnoutModel.2)

#Compute odds ratio model 2
exp(burnoutModel.2$coefficients)
exp(confint(burnoutModel.2))

#-------------------연습문제  3장------------------------

#Part A:

#load data
condomData<-read.delim("condom.dat", header = TRUE)

#look at first 6 cases of data
head(condomData)

#Relevel the categorical variables:
condomData$use<-relevel(condomData$use, "Unprotected")
condomData$gender<-relevel(condomData$gender, "Male")
condomData$previous<-relevel(condomData$previous, "No Condom")

#Create the two hierarchical models:
condomModel.1 <- glm(use ~ perceive + safety + gender, data = condomData, family = binomial())
condomModel.2 <- update(condomModel.1, .~. + previous + selfcon + sexexp)

summary(condomModel.1)
summary(condomModel.2)

#Compute model 1 improvement
modelChi <- condomModel.1$null.deviance - condomModel.1$deviance
chidf <- condomModel.1$df.null - condomModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.problogisticPseudoR2s(condomModel.1)


#Compute model 1 R2 (remember to execute the function code first)
logisticPseudoR2s(condomModel.1)

#Compute odds ratios:
exp(condomModel.1$coefficients)

#Confidence intervals
exp(confint(condomModel.1))

#compare model1 and model 2
modelChi <- condomModel.1$deviance - condomModel.2$deviance
chidf <- condomModel.1$df.residual - condomModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob


#Compute model 2 R2 (remember to execute the function code first)
logisticPseudoR2s(condomModel.2)

#Compute odds ratio model 2
exp(condomModel.2$coefficients)
exp(confint(condomModel.2))

#Part B:Is the model reliable?:

#Multicolinearity:

vif(condomModel.2)
1/vif(condomModel.2)

#linearity of the logit ------

#Create the variables with thier logs
condomData$logsafety<-log(condomData$safety +1)
condomData$logsexexp<-log(condomData$sexexp +1)
condomData$logselfcon<-log(condomData$selfcon + 1)
condomData$logperceive<-log(condomData$perceive +1)

head(condomData)

condomTest.1 <- glm(use ~ safety + sexexp + selfcon + perceive + safety:logsafety + sexexp:logsexexp + selfcon:logselfcon + perceive:logperceive, data = condomData, family=binomial())
summary(condomTest.1)

---#Diagnostics-----
condomData$predicted.probabilities<-fitted(condomModel.2)
condomData$standardized.residuals<-rstandard(condomModel.2)
condomData$studentized.residuals<-rstudent(condomModel.2)
condomData$dfbeta<-dfbeta(condomModel.2)
condomData$dffit<-dffits(condomModel.2)
condomData $leverage<-hatvalues(condomModel.2)

#Residuals:
condomData[, c("leverage", "studentized.residuals", "dfbeta")]

Part C:
  
  #Predicted Probabilities for participants 12, 53 and 75:
  (condomData[c(12,53,75), c("use", "safety", "sexexp","selfcon", "perceive", "previous", "gender", "predicted.probabilities")])

Part D:
  -4.9597+0.0027-0.965+0.3608+1.0872+0.6952+5.6934

exp(-1.9146)

