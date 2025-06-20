# install.packages("car")
# install.packages("effects")
# install.packages("compute.es")
# install.packages("multcomp")
# install.packages("pastecs")
# install.packages("WRS", repos="http://R-Forge.R-project.org")
# install.packages("reshape")


#Initiate packages
library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)
library(WRS)
library(reshape)

# source("http://www-rcf.usc.edu/~rwilcox/Rallfun-v14")


setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/"  

viagraData<-read.delim("ViagraCovariate.dat", header = TRUE)

by(viagraData$libido, viagraData$dose, stat.desc, basic = F)
by(viagraData$partnerLibido, viagraData$dose, stat.desc, basic = F)

stat.desc(viagraData$libido, basic = F)
stat.desc(viagraData$partnerLibido, basic = F)

#Self Test


viagraData$dose<-factor(viagraData$dose, levels = c(1:3), labels = c("Placebo", "Low Dose", "High Dose"))




libido<-c(3,2,5,2,2,2,7,2,4,7,5,3,4,4,7,5,4,9,2,6,3,4,4,4,6,4,6,2,8,5)
partnerLibido<-c(4,1,5,1,2,2,7,4,5,5,3,1,2,2,6,4,2,1,3,5,4,3,3,2,0,1,3,0,1,0)
dose<-c(rep(1,9),rep(2,8), rep(3,13))
dose<-factor(dose, levels = c(1:3), labels = c("Placebo", "Low Dose", "High Dose"))
viagraData<-data.frame(dose, libido, partnerLibido)



#Graphs
restructuredData<-melt(viagraData, id = c("dose"), measured = c("libido", "partnerLibido")) 
names(restructuredData)<-c("dose", "libido_type", "libido")

boxplot <- ggplot(restructuredData, aes(dose, libido))
boxplot + geom_boxplot() + facet_wrap(~libido_type) + labs(x = "Dose", y = "Libido")
imageFile <- paste(imageDirectory,"11 Viagra Boxplot.png",sep="/")
ggsave(file = imageFile)


scatter <- ggplot(viagraData, aes(partnerLibido, libido, colour = dose))
scatter + geom_point(aes(shape = dose), size = 3) + geom_smooth(method = "lm", aes(fill = dose), alpha = 0.1) + labs(x = "Partner's Libido", y = "Participant's Libido")
imageFile <- paste(imageDirectory,"11 Viagra scatter.png",sep="/")
ggsave(file = imageFile)

scatter <- ggplot(viagraData, aes(partnerLibido, libido))
scatter + geom_point(size = 3) + geom_smooth(method = "lm", alpha = 0.1) + labs(x = "Partner's Libido", y = "Participant's Libido")
imageFile <- paste(imageDirectory,"11 Viagra covariate.png",sep="/")
ggsave(file = imageFile)

leveneTest(viagraData$libido, viagraData$dose, center = median)

checkIndependenceModel<-aov(partnerLibido ~ dose, data = viagraData)
summary(checkIndependenceModel)
summary.lm(checkIndependenceModel)




#ANCOVA

#contrasts(viagraData$dose)<-contr.helmert(3)
contrasts(viagraData$dose)<-cbind(c(-2,1,1), c(0,-1,1))
viagraModel<-aov(libido~ partnerLibido + dose, data = viagraData)
Anova(viagraModel, type="III")


adjustedMeans<-effect("dose", viagraModel, se=TRUE)
summary(adjustedMeans)
adjustedMeans$se


summary.lm(viagraModel)


postHocs<-glht(viagraModel, linfct = mcp(dose = "Tukey"))
summary(postHocs)
confint(postHocs)

plot(viagraModel)




libido<-c(3,2,5,2,2,2,7,2,4,7,5,3,4,4,7,5,4,9,2,6,3,4,4,4,6,4,6,2,8,5)
partnerLibido<-c(4,1,5,1,2,2,7,4,5,5,3,1,2,2,6,4,2,1,3,5,4,3,3,2,0,1,3,0,1,0)
dose<-c(rep(1,9),rep(2,8), rep(3,13))
dose<-factor(dose, levels = c(1:3), labels = c("Placebo", "Low Dose", "High Dose"))
viagraData<-data.frame(dose, libido, partnerLibido)

postHocs<-glht(viagraModel, linfct = mcp(dose = "Tukey"))
summary(postHocs)
confint(postHocs)

plot(viagraModel)

#Homogeneity of regression slopes

hoRS<-aov(libido ~ partnerLibido+dose+dose:partnerLibido, data = viagraData)

# hoRS<-aov(libido ~ partnerLibido*dose, data = viagraData)
hoRS<-update(viagraModel, .~. + partnerLibido:dose)
Anova(hoRS, type="III")


#Self Test
anovaModel<-aov(libido ~ dose, data = viagraData)
summary(anovaModel)



invisibilityData<-read.delim("CloakofInvisibility.dat", header = TRUE)
invisibilityData$cloak<-factor(invisibilityData$cloak, levels = c(1:2), labels = c("No Cloak", "Cloak"))

restructuredData<-melt(invisibilityData, id = c("cloak"), measured = c("mischief1", "mischief2")) 
names(restructuredData)<-c("cloak", "mischief_type", "mischief")

boxplot <- ggplot(restructuredData, aes(cloak, mischief))
boxplot + geom_boxplot() + facet_wrap(~mischief_type) + labs(x = "cloak", y = "mischief")


noCloak<-subset(invisibilityData, cloak=="No Cloak",)
invisCloak<-subset(invisibilityData, cloak=="Cloak",)

covGrp2<-invisCloak$mischief1
dvGrp2<-invisCloak$mischief2
covGrp1<-noCloak$mischief1
dvGrp1<-noCloak$mischief2

ancova(covGrp2, dvGrp2, covGrp1, dvGrp1)
ancboot(covGrp2, dvGrp2, covGrp1, dvGrp1, nboot = 2000)

#Load the data:###########################################
murisData<-read.delim("Muris et al. (2008).dat", header = TRUE)

#Set Training to be a factor:
murisData$Training<-factor(murisData$Training, levels = c(1:2), labels = c("Negative Training", "Positive Training"))

#Set Gender to be a factor:
murisData$Gender<-factor(murisData$Gender, levels = c(1:2), labels = c("Boy", "Girl"))


leveneTest(murisData$Interpretational_Bias, interaction(murisData$Gender, murisData$Age, murisData$SCARED, murisData$Training), center = median)

murisModel<-aov(Interpretational_Bias ~ Training, data = murisData)
summary(murisModel)


checkIndependenceModel.1<-aov(Age ~Training, data = murisData)
checkIndependenceModel.2<-aov(Gender ~Training, data = murisData)
checkIndependenceModel.3<-aov(SCARED ~Training, data = murisData)

summary(checkIndependenceModel.1)
summary.lm(checkIndependenceModel.1)

summary(checkIndependenceModel.2)
summary.lm(checkIndependenceModel.2)

summary(checkIndependenceModel.3)
summary.lm(checkIndependenceModel.3)


#Run the ANCOVA:
contrasts(murisData$Gender)<-c(-1,1)
contrasts(murisData$Training)<-c(-1,1)
murisModel<-aov(Interpretational_Bias~SCARED + Age + Gender + Training, data = murisData)
Anova(murisModel, type = "III")

#adjusted means:
adjustedMeans<-effect("Training", murisModel, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se


#Regression parameter for the covariate:
summary.lm(murisModel)

#Plots:
plot(murisModel)

################################ 연습 문제 ################################ 

# 1장

#Load in the data:
stalkerData<-read.delim("Stalker.dat", header = TRUE)
stalkerData$group<-factor(stalkerData$group, levels = c(1:2), labels = c("group 1", "group 2"))

by(stalkerData$stalk1 , stalkerData$group , stat.desc, basic = F)
by(stalkerData$stalk2 , stalkerData$group , stat.desc, basic = F)

restructuredData<-melt(stalkerData, id = c("group"), measured = c("stalk1", "stalk2")) 
names(restructuredData)<-c("group", "stalk_type", "stalk")

boxplot <- ggplot(restructuredData, aes(group, stalk))
boxplot + geom_boxplot() + facet_wrap(~stalk_type) + labs(x = "group", y = "stalk")

noTerm_stalk1<-subset(stalkerData, group=="group 1",)
yesTerm_stalk1<-subset(stalkerData, group=="group 2",)

leveneTest(noTerm_stalk1$stalk1, yesTerm_stalk1$stalk1, center = median)

stalkerDataeModel<-aov(noTerm_stalk1$stalk1  ~ yesTerm_stalk1$stalk1)


summary(stalkerDataeModel)
summary.lm(stalkerDataeModel)


noTerm_stalk2<-subset(stalkerData, group=="group 1",)

yesTerm_stalk2<-subset(stalkerData, group=="group 2",)


leveneTest(noTerm_stalk2$stalk2, yesTerm_stalk2$stalk2, center = median)




stalkerDataeModel2<-aov(noTerm_stalk2$stalk2  ~ yesTerm_stalk2$stalk2)


summary(stalkerDataeModel2)
summary.lm(stalkerDataeModel2)




















################################ 예제 ################################ 


boxplot <- ggplot(restructuredData, aes(dose, libido))
boxplot + geom_boxplot() + facet_wrap(~libido_type) + labs(x = "Dose", y = "Libido")
imageFile <- paste(imageDirectory,"11 Viagra Boxplot.png",sep="/")
ggsave(file = imageFile)


scatter <- ggplot(viagraData, aes(partnerLibido, libido, colour = dose))
scatter + geom_point(aes(shape = dose), size = 3) + geom_smooth(method = "lm", aes(fill = dose), alpha = 0.1) + labs(x = "Partner's Libido", y = "Participant's Libido")
imageFile <- paste(imageDirectory,"11 Viagra scatter.png",sep="/")
ggsave(file = imageFile)

scatter <- ggplot(viagraData, aes(partnerLibido, libido))
scatter + geom_point(size = 3) + geom_smooth(method = "lm", alpha = 0.1) + labs(x = "Partner's Libido", y = "Participant's Libido")
imageFile <- paste(imageDirectory,"11 Viagra covariate.png",sep="/")
ggsave(file = imageFile)

leveneTest(viagraData$libido, viagraData$dose, center = median)

checkIndependenceModel<-aov(partnerLibido ~ dose, data = viagraData)
summary(checkIndependenceModel)
summary.lm(checkIndependenceModel)




#ANCOVA

#contrasts(viagraData$dose)<-contr.helmert(3)
contrasts(viagraData$dose)<-cbind(c(1,-1), c(-1,1))
viagraModel<-aov(libido~ partnerLibido + dose, data = viagraData)
Anova(viagraModel, type="III")


adjustedMeans<-effect("dose", viagraModel, se=TRUE)
summary(adjustedMeans)
adjustedMeans$se


summary.lm(viagraModel)


postHocs<-glht(viagraModel, linfct = mcp(dose = "Tukey"))
summary(postHocs)
confint(postHocs)

plot(viagraModel)


################################ 연습 문제 ################################ 

# 1장



#Load in the data:

stalkerData<-read.delim("Stalker.dat", header = TRUE)
stalkerData$group<-factor(stalkerData$group, levels = c(1:2), labels = c("group 1", "group 2"))
# stalkerData$group<-factor(stalkerData$group, levels = c(1:2), labels = c("Cruel to be Kind Therapy", "Psychodyshamic Therapy"))
# 
# noTerm_stalk1<-subset(stalkerData, group=="group 1",)
# yesTerm_stalk1<-subset(stalkerData, group=="group 2",)
# 
# by(stalkerData$stalk1 , stalkerData$group , stat.desc, basic = F)
# by(stalkerData$stalk2 , stalkerData$group , stat.desc, basic = F)



restructuredData<-melt(stalkerData, id = c("group"), measured = c("stalk1", "stalk2")) 
# restructuredData2<-melt(yesTerm_stalk1, id = c("group"), measured = c("stalk1", "stalk2")) 
names(restructuredData)<-c("group", "Time", "stalk")
# names(restructuredData2)<-c("group", "stalk_type", "stalk")


boxplot <- ggplot(restructuredData, aes(group, stalk))
boxplot + geom_boxplot() + facet_wrap(~Time) + labs(x = "group", y = "stalk")

# 
# boxplot <- ggplot(restructuredData2, aes(group, stalk))
# boxplot + geom_boxplot() + facet_wrap(~stalk_type) + labs(x = "group", y = "stalk2")

# 
# noTerm_stalk1<-subset(stalkerData, group=="group 1",)
# yesTerm_stalk1<-subset(stalkerData, group=="group 2",)
# leveneTest(stalkerData$stalk2, interaction(stalkerData$group, stalkerData$stalk1), center = median)

# leveneTest(stalkerData$stalk1, stalkerData$stalk2, center = median)
# leveneTest(yesTerm_stalk1$stalk1, yesTerm_stalk1$stalk2, center = median)

# stalkerDataeModel1<-aov(stalkerData$stalk1  ~ stalkerData$stalk2)
# 
# summary(stalkerDataeModel1)
# summary.lm(stalkerDataeModel1)
# 
# stalkerDataeModel2<-aov(noTerm_stalk2$stalk1  ~ noTerm_stalk1$stalk2)
# 
# summary(stalkerDataeModel2)
# summary.lm(stalkerDataeModel2)
# 
#

stalkerModel.1<-aov(stalk2~ group, data = stalkerData)

#Run the ANCOVA:
contrasts(stalkerData$group) <- cbind(c(1,-1))

stalkerModel.1<-aov(stalk2~stalk1+ group, data = stalkerData)
# 
# stalkerDataModel<-aov(stalk2 ~ stalk1+group, data = noTerm_stalk1)
Anova(stalkerModel.1, type = "III") 



#adjusted means:
adjustedMeans<-effect("group", stalkerModel.1, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se


#Regression parameter for the covariate:
summary.lm(stalkerModel.1)

plot(stalkerModel.1)

#Plots:
plot(stalkerDataModel)

#####################연습 문제 2번##################콜라 


# drink well drunk
hangoverData<-read.delim("HangoverCure.dat", header = TRUE)
hangoverData$drink<-factor(hangoverData$drink, levels = c(1:3), labels = c("water", "rucozeid","coke"))
# 
# restructuredData<-melt(hangoverData, id = c("drink"), measured = c("well", "drunk")) 
# 
# boxplot <- ggplot(restructuredData, aes(drink , value))
# boxplot + geom_boxplot() + facet_wrap(~variable ) + labs(x = "group", y = "stalk")


#Levene's test: drink well drunk
leveneTest(hangoverData$well, interaction(hangoverData$drink, hangoverData$drunk), center = median)

hangoverModel.1<-aov(well~drink, data = hangoverData)

summary(hangoverModel.1)

summary.lm(hangoverModel.1)


checkIndependenceModel<-aov(drunk~drink, data = hangoverData)

summary(checkIndependenceModel)

summary.lm(checkIndependenceModel)

contrasts(hangoverData$drink)<-cbind(c(-1,2,-1), c(1,0,-1))
hangoverModel.2<-aov(well~drunk + drink, data = hangoverData)
Anova(hangoverModel.2, type = "III")
plot(hangoverModel.2)

#adjusted means:
adjustedMeans<-effect("drink", hangoverModel.2, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

#Regression parameter for the covariate:
summary.lm(hangoverModel.2)

#Plots:
plot(hangoverModel.2)

hoRS<-update(hangoverModel.2, .~. + drunk:drink)
Anova(hoRS, type = "III")


########################연습문제 3 ##########################################
elephantData<-read.delim("Elephant Football.dat", header = TRUE)
# elephant experience goals
elephantData$elephant<-factor(elephantData$elephant, levels = c(1:2), labels = c("Asian Elephant", "African Elephant"))



leveneTest(elephantData$goals, interaction(elephantData$elephant , elephantData$experience), center = median)


elephantData.1<-aov(goals~elephant, data = elephantData)
summary(elephantData.1)
summary.lm(elephantData.1)


checkIndependenceModel<-aov(experience~elephant , data = elephantData)
summary(checkIndependenceModel)
summary.lm(checkIndependenceModel)


contrasts(elephantData$elephant)<-cbind(c(-1,1))
elephantData.2<-aov(goals~elephant + experience, data = elephantData)
Anova(elephantData.2, type = "III")
plot(elephantData.2)

adjustedMeans<-effect("elephant", elephantData.2, se = TRUE)
summary(adjustedMeans)
adjustedMeans$se

summary.lm(elephantData.2)


asian<-subset(elephantData, elephant=="Asian Elephant",)
african<-subset(elephantData, elephant=="African Elephant",)
                        
covGrp1<-asian$experience
dvGrp1<-asian$goals
covGrp2<-african$experience
dvGrp2<-african$goals

ancova(covGrp1, dvGrp1, covGrp2, dvGrp2)
ancboot(covGrp1, dvGrp1, covGrp2, dvGrp2, nboot = 2000)

    