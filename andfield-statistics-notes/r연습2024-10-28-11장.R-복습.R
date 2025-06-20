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


# install.packages("car")
# install.packages("effects")
# install.packages("compute.es")
# install.packages("multcomp")
# install.packages("pastecs")
# # install.packages("WRS", repos="http://R-Forge.R-project.org")
# # install.packages("reshape")
#  install.packages("ancova")
#Initiate packages
library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)
# library(ancova)
# library(WRS)
# library(reshape)

# 
# install.packages("corpcor")
# install.packages("GPArotation")
# install.packages("psych")
# install.packages("pastecs")
# 
# install.packages("melt")

install.packages("ancova")

#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/11장" 


#--------Smart Alex Task 1----------

#Load in the data:
stalkerData<-read.delim("Stalker.dat", header = TRUE)

#Set group to be a factor:
stalkerData$group<-factor(stalkerData$group, levels = c(1:2), labels = c("Cruel to be Kind Therapy", "Psychodyshamic Therapy"))

#boxplots
restructuredData<-melt(stalkerData, id = c("group"), measured = c("stalk1", "stalk2")) 
names(restructuredData)<-c("group", "Time", "Stalk")

boxplot <- ggplot(restructuredData, aes(group, Stalk))
boxplot + geom_boxplot() + facet_wrap(~Time) + labs(x = "Type of Therapy", y = "Number of Hours Spent Stalking")


#Look at the ANOVA before the covariate is included:
stalkerModel.1<-aov(stalk2~ group, data = stalkerData)
summary(stalkerModel.1)

#Levene's test:
leveneTest(stalkerData$stalk2, interaction(stalkerData$group, stalkerData$stalk1), center = median)

#Check that the covariate is independent from the experimental manipulation:
checkIndependenceModel<-aov(stalk1~group, data = stalkerData)

summary(checkIndependenceModel)

summary.lm(checkIndependenceModel)

#Run the ANCOVA:

contrasts(stalkerData$group)<-c(-1, 1)
stalkerModel.1<-aov(stalk2~stalk1 + group, data = stalkerData)
Anova(stalkerModel.1, type = "III")

#adjusted means:
adjustedMeans<-effect("group", stalkerModel.1, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

#Regression parameter for the covariate:
summary.lm(stalkerModel.1)

#Plots:
plot(stalkerModel.1)

#Check for homogenity of regression slopes:
hoRS<-update(stalkerModel.1, .~. + stalk1:group)
Anova(hoRS, type = "III")

#Robust ANCOVA:
CruelGroup<-subset(stalkerData, group=="Cruel to be Kind Therapy",)
PsychoGroup<-subset(stalkerData, group=="Psychodyshamic Therapy",)

covGrp1<- CruelGroup$stalk1
dvGrp1<- CruelGroup$stalk2
covGrp2<-PsychoGroup$stalk1
dvGrp2<-PsychoGroup$stalk2

ancova(covGrp1, dvGrp1, covGrp2, dvGrp2)
ancboot(covGrp1, dvGrp1, covGrp2, dvGrp2, nboot = 2000)

#--------Smart Alex Task 2----------

#Load the data:
hangoverData<-read.delim("HangoverCure.dat", header = TRUE)

#Set drink to be a factor:
hangoverData$drink<-factor(hangoverData$drink, levels = c(1:3), labels = c("Water", "Lucozade", "Cola"))

#Conduct a one-way ANOVA without covariate
hangoverModel<-aov(well~drink, data = hangoverData)
Anova(hangoverModel, type = "III")
summary(hangoverModel)

#Normal ANCOVA
leveneTest(stalkerData$stalk2, interaction(stalkerData$group, stalkerData$stalk1), center = median)


#Levene's Test
leveneTest(hangoverData$well, interaction(hangoverData$drink, hangoverData$drunk), center = median)

#Test whether the IV and covariate are independent

checkIndependenceModel<-aov(drunk ~ drink, data = hangoverData)
summary(checkIndependenceModel)
summary.lm(checkIndependenceModel)

#ANCOVA+ Contrasts
contrasts(hangoverData$drink)<-cbind(c(-1,2,-1), c(1,0,-1))
hangoverModel<-aov(well~drunk + drink, data = hangoverData)
Anova(hangoverModel, type="III")
summary.lm(hangoverModel)

#Plots:
plot(hangoverModel)

adjustedMeans<-effect("drink", hangoverModel, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

hoRS<-update(hangoverModel, .~. + drunk:drink)
Anova(hoRS, type = "III")

#--------Smart Alex Task 3----------

#Load in the data:
elephantData<-read.delim("Elephant Football.dat", header = TRUE)

#Set the variable elephant to be a factor:
elephantData$elephant<-factor(elephantData$elephant, levels = c(1:2), labels = c("Asian Elephant", "African Elephant"))


#Graphs
boxplot <- ggplot(elephantData, aes(elephant, goals))
boxplot + geom_boxplot() + labs(x = "Type of Elephant", y = "Number of Goals")

boxplot <- ggplot(elephantData, aes(elephant, experience))
boxplot + geom_boxplot() + labs(x = "Type of Elephant", y = "Football Experience (Years)")

#Normal ANCOVA

#Levene's Test:

leveneTest(elephantData$goals, interaction(elephantData$elephant, elephantData$experience), center = median)

#Test whether the IV and covariate are independent

checkIndependenceModel<-aov(experience ~ elephant, data = elephantData)
summary(checkIndependenceModel)
summary.lm(checkIndependenceModel)

#ANCOVA
contrasts(elephantData$elephant)<-c(-1, 1)
elephantModel<-aov(goals~ experience + elephant, data = elephantData)
Anova(elephantModel, type = "III")
summary.lm(elephantModel)
plot(elephantModel)

adjustedMeans<-effect("elephant", elephantModel, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

hoRS<-update(elephantModel, .~. + experience:elephant)
Anova(hoRS, type = "III")

#Robust Tests
asian<-subset(elephantData, elephant=="Asian Elephant",)
african<-subset(elephantData, elephant=="African Elephant",)

covGrp1<-asian$experience
dvGrp1<-asian$goals
covGrp2<-african$experience
dvGrp2<-african$goals

ancova(covGrp1, dvGrp1, covGrp2, dvGrp2)
ancboot(covGrp1, dvGrp1, covGrp2, dvGrp2, nboot = 2000)





