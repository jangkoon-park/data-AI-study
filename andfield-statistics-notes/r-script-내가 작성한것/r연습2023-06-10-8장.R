library(car)
library(ggplot2)
library(pastecs)
library(psych) 
# install.packages("Hmisc")
# install.packages("polycor")
# install.packages("ggm")

#Initiate packages
library(Hmisc)
library(ggplot2)
library(boot)
library(polycor)
library(ggm)


setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/8장/"  



library(QuantPsyc)
library(car)
library(boot)
library(Rcmdr)


library(QuantPsyc)
library(car)
library(boot)
library(Rcmdr)


eelData<-read.delim("eel.dat", header = TRUE)

head(eelData)

eelData$Cured <- factor(eelData$Cured)
eelData$Cured <- relevel(eelData$Cured, ref = "Not Cured")


eelData$Intervention <- factor(eelData$Intervention)
eelData$Intervention<-relevel(eelData$Intervention, "No Treatment")

eelModel.1 <- glm(Cured ~ Intervention, data = eelData, family = binomial())
eelModel.2 <- glm(Cured ~ Intervention + Duration, data = eelData, family = binomial())


summary(eelModel.1)
summary(eelModel.2)



eelModel.0 <- glm(Cured ~ 1, data = eelData, family = binomial())
summary(eelModel.0)


modelChi <- eelModel.1$null.deviance - eelModel.1$deviance
chidf <- eelModel.1$df.null - eelModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob


-------------------------------------------------------------------------------------------
  
  
  
  #-----Self test-----

#load data
penaltyData<-read.delim("penalty.dat", header = TRUE)

#look at first 6 cases of data
head(penaltyData)


#Create the two hierarchical models:

penaltyData["Scored"][penaltyData["Scored"] == "Scored Penalty"] <- 1
penaltyData["Scored"][penaltyData["Scored"] == "Missed Penalty"] <- 0
penaltyData$Scored <- as.numeric(penaltyData$Scored)
head(penaltyData)

penaltyModel.1 <- glm(Scored ~ Previous + PSWQ, data = penaltyData, family = binomial())
penaltyModel.2 <- glm(Scored ~ Previous + PSWQ + Anxious, data = penaltyData, family = binomial())
#This works too:
penaltyModel.2 <- update(penaltyModel.1, .~. + Anxious)


summary(penaltyModel.1)
summary(penaltyModel.2)

#Compute model 1 improvement
modelChi <- penaltyModel.1$null.deviance - penaltyModel.1$deviance
chidf <- penaltyModel.1$df.null - penaltyModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

###############################################
# This section creates a function called      #
# logisticPseudoR2s().  To use it             #
# type logisticPseudoR2s(myLogisticModel)     #
###############################################
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
############End of function ######################

#Compute model 1 R2 (remember to execute the function code first)
logisticPseudoR2s(penaltyModel.1)

#Compute odds ratio
exp(penaltyModel.1$coefficients)
exp(confint(penaltyModel.1))


#compare model1 and model 2
modelChi <- penaltyModel.1$deviance - penaltyModel.2$deviance
chidf <- penaltyModel.1$df.residual - penaltyModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

anova(penaltyModel.1, penaltyModel.2)


#Compute model 2 R2 (remember to execute the function code first)
logisticPseudoR2s(penaltyModel.2)

#Compute odds ratio model 2
exp(penaltyModel.2$coefficients)
exp(confint(penaltyModel.2))

#----- Testing multicollinearity ------

vif(penaltyModel.2)
1/vif(penaltyModel.2)

cor(penaltyData[, c("Previous", "PSWQ", "Anxious")])



#Create the interaction of PSWQ with log(PSWQ)
penaltyData$logPSWQInt<-log(penaltyData$PSWQ)*penaltyData$PSWQ

#Create the interaction of Anxious and Previous with their logs

penaltyData$logAnxInt<-log(penaltyData$Anxious)*penaltyData$Anxious
penaltyData$logPrevInt<-log(penaltyData$Previous + 1)*penaltyData$Previous

head(penaltyData)



penaltyTest.1 <- glm(Scored ~ PSWQ +
                       Anxious + 
                       Previous +
                       logPSWQInt +
                       logAnxInt +	
                       logPrevInt, 
                     data=penaltyData, family=binomial())
summary(penaltyTest.1)




















#********************* Chat Up Lines Example ********************

chatData<-read.delim("Chat-Up Lines.dat", header = TRUE)

##추가분
chatData$Success <- factor(chatData$Success)
chatData$Gender <- factor(chatData$Gender)


chatData$Gender<-relevel(chatData$Gender, ref = 2)
levels(chatData$Gender) #기저범주 확인

head(chatData)
is.factor(chatData$Success)
is.factor(chatData$Gender)


#Rearrange data
#newDataframe<-mlogit.data(oldDataFrame, choice = "text", shape = "wide"/"long")
library(car)
library(mlogit)
library(Rcmdr)

mlChat <- mlogit.data(chatData, choice="Success", shape="wide")
head(mlChat)

#Create model:

chatModel <- mlogit(Success ~ 1 | Good_Mate + Funny + Gender + Sex + Gender:Sex +  Funny:Gender , data = mlChat, reflevel="No response/Walk Off")
summary(chatModel)

data.frame(exp(chatModel$coefficients))
exp(confint(chatModel))



chatBase<-mlogit(Success ~ 1, data = mlChat, reflevel=3)


#-------Self test-------

#Testing for Multicolinearity---

#We need to test for Multicolinearity using the chatData dataframe:

chatData<-read.delim("Chat-Up Lines.dat", header = TRUE)
chatData$Gender<-relevel(chatData$Gender, ref = 2)

chatModel <- glm(Success ~ Funny + Good_Mate + Sex + Gender, data = chatData, family = binomial())

vif(chatModel)
1/vif(chatModel)

#Correlations
cor(chatData[, c("Funny", "Good_Mate", "Sex")])


#----- Testing the linearity of the logit ------








displayData<-read.delim("Display.dat", header = TRUE)

head(displayData)

displayData$fb  <- factor(displayData$fb)
displayData$display <- factor(displayData$display)




displayData$fb<-relevel(displayData$fb, ref = 1)

head(displayData)
is.factor(displayData$fb)
is.factor(displayData$display)

library(car)
library(mlogit)
library(Rcmdr)

displayData.1 <- glm(display ~ age + fb, data = displayData, family = binomial())


summary(displayData.1)



displayModel.1 <- glm(display ~ fb, data = displayData, family = binomial())

displayModel.2 <- update(displayModel.1, .~. + age + fb:age)

summary(displayModel.1)
summary(displayModel.2)



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



modelChi <- displayModel.1$null.deviance - displayModel.1$deviance
chidf <- displayModel.1$df.null - displayModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

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

displayData$leverage<-hatvalues(displayModel.1)

#Predicted Probabilities:
head(displayData[, c("display", "fb", "age", "predicted.probabilities")])

#Residuals:
displayData[, c("leverage", "studentized.residuals", "dfbeta")]


#Part A:

#load data
condomData<-read.delim("condom.dat", header = TRUE)
condomData
#look at first 6 cases of data
head(condomData)


condomData$use  <- factor(condomData$use)
condomData$gender <- factor(condomData$gender)
condomData$previous <- factor(condomData$previous)

#Relevel the categorical variables:
condomData$use<-relevel(condomData$use, "Unprotected")
condomData$gender<-relevel(condomData$gender, "Male")
condomData$previous<-relevel(condomData$previous, "No Condom")

head(condomData)


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



condomModel.1 <- glm(use  ~ safety + gender + sexexp + previous + selfcon +  perceive , data = condomData, family = binomial())

condomModel.2 <- glm(use  ~ safety + previous + selfcon +  perceive , data = condomData, family = binomial())

condomModel.3 <- glm(use  ~ safety + selfcon +  perceive , data = condomData, family = binomial())

summary(condomModel.1)
summary(condomModel.2)
summary(condomModel.3)



anova(condomModel.1, condomModel.2,condomModel.3)


modelChi <- condomModel.3$null.deviance - condomModel.3$deviance
chidf <- condomModel.3$df.null - condomModel.3$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob




modelChi <- condomModel.2$deviance - condomModel.1$deviance
chidf <- condomModel.2$df.residual - condomModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

logisticPseudoR2s(condomModel.3)
logisticPseudoR2s(condomModel.2)
logisticPseudoR2s(condomModel.1)


exp(condomModel.3$coefficients)
exp(condomModel.2$coefficients)
exp(condomModel.1$coefficients)

#Compute confidence intervals
exp(confint(condomModel.3))
exp(confint(condomModel.2))
exp(confint(condomModel.1))




condomData$predicted.probabilities<-fitted(condomModel.3)
condomData$standardized.residuals<-rstandard(condomModel.3)
condomData$studentized.residuals<-rstudent(condomModel.3)
condomData$dfbeta<-dfbeta(condomModel.3)
condomData$dffit<-dffits(condomModel.3)

condomData$leverage<-hatvalues(condomModel.3)

#Predicted Probabilities:
head(condomData[, c("safety", "selfcon", "perceive", "predicted.probabilities")])

#Residuals:
condomData[, c("leverage", "studentized.residuals", "dfbeta")]

condomData

vif(condomModel.1)
1/vif(condomModel.1)




