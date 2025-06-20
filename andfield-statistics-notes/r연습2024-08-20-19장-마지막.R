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

library(gmodels)
library(MASS)

library(foreign)
# library(Rcmdr)

# install.packages("corpcor")
# install.packages("GPArotation")
# install.packages("psych")
# install.packages("pastecs")
# 
#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/19장" 


surgeryData = read.delim("Cosmetic Surgery.dat",  header = TRUE)

intercept <-gls(Post_QoL~1, data = surgeryData, method = "ML")
randomIntercept <-lme(Post_QoL~1, data = surgeryData, random = ~1|Clinic, method = "ML")

randomInterceptSurgery<-update(randomIntercept, .~. + Surgery)
randomInterceptSurgeryQoL<-update(randomInterceptSurgery, .~. + Base_QoL)
addRandomSlope<-update(randomInterceptSurgeryQoL, random = ~Surgery|Clinic)
addReason<-update(addRandomSlope, .~. + Reason)
finalModel<-update(addReason, .~. + Reason:Surgery)

BDIModel<-update(finalModel, .~. + BDI)
AgeModel<-update(BDIModel, .~. + Age)
genderModel<-update(AgeModel, .~. + Gender)

anova(finalModel, genderModel); summary(genderModel); intervals(genderModel)

physicalSubset<-surgeryData$Reason==1 
cosmeticSubset<-surgeryData$Reason==0
physicalModel<-update(addRandomSlope, .~. + BDI + Age + Gender, subset= physicalSubset)
cosmeticModel<-update(addRandomSlope, .~. + BDI + Age + Gender, subset= cosmeticSubset)
summary(physicalModel)
summary(cosmeticModel)
##--------------------------------------------------------------------
#GROWTH MODELS

satisfactionData = read.delim("Honeymoon Period.dat",  header = TRUE)
restructuredData<-reshape(satisfactionData, idvar = c("Person", "Gender"), varying = c("Satisfaction_Base", "Satisfaction_6_Months", "Satisfaction_12_Months", "Satisfaction_18_Months"), v.names = "Life_Satisfaction", timevar = "Time", times = c(0:3), direction = "long")

intercept <-gls(Life_Satisfaction~1, data = restructuredData, method = "ML", na.action = na.exclude)
randomIntercept <-lme(Life_Satisfaction ~1, data = restructuredData, random = ~1|Person, method = "ML",  na.action = na.exclude, control = list(opt="optim"))

timeRI<-update(randomIntercept, .~. + Time)
timeRS<-update(timeRI, random = ~Time|Person)
ARModel<-update(timeRS, correlation = corAR1(0, form = ~Time|Person))
timeQuadratic<-update(ARModel, .~. + I(Time^2))
timeCubic <-update(timeQuadratic, .~. + I(Time^3))
genderModel <-update(timeCubic, .~. + Gender)
anova(timeCubic, genderModel)
summary(genderModel)
intervals(genderModel)




##--------------------------------------------------------------------
#SMART ALEX
#Task 1 연습문제 1

surgeryData = read.delim("Cosmetic Surgery.dat",  header = TRUE)

intercept <-gls(Post_QoL~1, data = surgeryData, method = "ML")
randomIntercept <-lme(Post_QoL~1, data = surgeryData, random = ~1|Clinic, method = "ML")

randomInterceptSurgery<-update(randomIntercept, .~. + Surgery)
randomInterceptSurgeryQoL<-update(randomInterceptSurgery, .~. + Base_QoL)
addRandomSlope<-update(randomInterceptSurgeryQoL, random = ~Surgery|Clinic)
addReason<-update(addRandomSlope, .~. + Reason)
finalModel<-update(addReason, .~. + Reason:Surgery)


BDIModel<-update(finalModel, .~. + BDI)
AgeModel<-update(BDIModel, .~. + Age)
genderModel<-update(AgeModel, .~. + Gender)


anova(finalModel, genderModel); summary(genderModel); intervals(genderModel)


physicalSubset<-surgeryData$Reason==1 
cosmeticSubset<-surgeryData$Reason==0
physicalModel<-update(addRandomSlope, .~. + BDI + Age + Gender, subset= physicalSubset)
cosmeticModel<-update(addRandomSlope, .~. + BDI + Age + Gender, subset= cosmeticSubset)


summary(physicalModel)
summary(cosmeticModel)
--------
#Task 2
  
  satisfactionData = read.delim("Honeymoon Period.dat",  header = TRUE)
restructuredData<-reshape(satisfactionData, idvar = c("Person", "Gender"), varying = c("Satisfaction_Base", "Satisfaction_6_Months", "Satisfaction_12_Months", "Satisfaction_18_Months"), v.names = "Life_Satisfaction", timevar = "Time", times = c(0:3), direction = "long")

intercept <-gls(Life_Satisfaction~1, data = restructuredData, method = "ML", na.action = na.exclude)
randomIntercept <-lme(Life_Satisfaction ~1, data = restructuredData, random = ~1|Person, method = "ML",  na.action = na.exclude, control = list(opt="optim"))

timeRI<-update(randomIntercept, .~. + Time)
timeRS<-update(timeRI, random = ~Time|Person)
ARModel<-update(timeRS, correlation = corAR1(0, form = ~Time|Person))
timeQuadratic<-update(ARModel, .~. + I(Time^2))
timeCubic <-update(timeQuadratic, .~. + I(Time^3))
genderModel <-update(timeCubic, .~. + Gender)
anova(timeCubic, genderModel)
summary(genderModel)
intervals(genderModel)
-----------
#Task 3
exerciseData = read.delim("Hill et al. (2007).dat",  header = TRUE)

intercept<-gls(Post_Exercise~1, data = exerciseData, method = "ML", na.action = na.exclude)
randomInt <-lme(Post_Exercise~1, data = exerciseData, random = ~1|Classroom, method = "ML")
intervention<-update(randomInt, .~. + Intervention)
anova(intercept, randomInt, intervention)
anova(intervention)
summary(intervention)

#Task 4
finalIntervention<-update(intervention, .~. + Pre_Exercise)
anova(intervention, finalIntervention)
summary(finalIntervention)




