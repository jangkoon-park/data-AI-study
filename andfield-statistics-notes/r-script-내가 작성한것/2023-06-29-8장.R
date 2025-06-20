#------Install Packages-----
install.packages("car")
install.packages("mlogit")

#------And then load these packages, along with the boot package.-----

library(car)
library(mlogit)
library(Rcmdr)

imageDirectory<-"C:/Users/CJ/Documents/앤드필드/데이터"
setwd("C:/Users/CJ/Documents/앤드필드/데이터")

#load data
eelData<-read.delim("eel.dat", header = TRUE)

#look at first 6 cases of data
head(eelData)

# specify the baseline category
#Alternatively Re-orders the levels of the factyor so that Not Cured and No Treatment are the baseline categories
eelData$Cured<-factor(eelData$Cured, levels = c("Not Cured", "Cured"))
eelData$Intervention<-factor(eelData$Intervention, levels = c("No Treatment", "Intervention"))
eelData$Cured<-relevel(eelData$Cured, "Not Cured")
eelData$Intervention<-relevel(eelData$Intervention, "No Treatment")




#Create the two hierarchical models:

eelModel.1 <- glm(Cured ~ Intervention, data = eelData, family = binomial())
eelModel.2 <- glm(Cured ~ Intervention + Duration, data = eelData, family = binomial())

summary(eelModel.1)
summary(eelModel.2)

#Just to prove what the null deviance is
eelModel.0 <- glm(Cured ~ 1, data = eelData, family = binomial())
summary(eelModel.0)


modelChi <- eelModel.1$null.deviance - eelModel.1$deviance
chidf <- eelModel.1$df.null - eelModel.1$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob



#load data
penaltyData<-read.delim("penalty.dat", header = TRUE)
penaltyData
#look at first 6 cases of data
head(penaltyData)

#Create the two hierarchical models:

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


#----- Testing the linearity of the logit ------

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

eelData$Cured<-factor(eelData$Cured, levels = c("Not Cured", "Cured"))
eelData$Intervention<-factor(eelData$Intervention, levels = c("No Treatment", "Intervention"))


----------------------------------------------------------------------------------------


chatData<-read.delim("Chat-Up Lines.dat", header = TRUE)
chatData$Gender<-factor(chatData$Gender, levels = c("Male", "Female"))
chatData$Gender<-relevel(chatData$Gender, ref = 1)

chatData$Success<-factor(chatData$Success, levels = c("Get Phone Number", "Go Home with Person","No response/Walk Off"))
chatData$Success<-relevel(chatData$Success, ref = 3)

head(chatData)
is.factor(chatData$Success)
is.factor(chatData$Gender)


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



#Create the variables with thier logs:
mlChat$logFunny<-log(mlChat$Funny +1)
mlChat$logGood<-log(mlChat$Good_Mate +1)
mlChat$logSex<-log(mlChat$Sex + 1)

head(mlChat)

chatTest.1 <- mlogit(Success ~ 1 | Good_Mate + Funny + Sex + Funny:logFunny + Good_Mate:logGood + Sex:logSex, data = mlChat, reflevel=3)
summary(chatTest.1)








