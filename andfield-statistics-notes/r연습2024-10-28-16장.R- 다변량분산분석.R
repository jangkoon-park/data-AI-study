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

library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)


# 데이터 생성
library(reshape2)
data <- data.frame(
  subject = factor(1:10),
  time1 = rnorm(10, 70, 5),
  time2 = rnorm(10, 75, 5),
  time3 = rnorm(10, 80, 5)
)


#------And then load these packages, along with the boot package.-----
setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/16장" 
#-------Smart Alex Task 1-----

chickenData<-read.delim("chicken.dat", header = TRUE)

chickenData$group<-factor(chickenData$group, levels = c(1:2), labels = c("Manic Psychosis", "Sussex Lecturers"))

chickenMelt<-melt(chickenData, id = c("group"), measured = c("quality", "quantity"))
names(chickenMelt)<-c("group","Outcome_Measure", "Value")

Boxplot <- ggplot(chickenMelt, aes(group, Value))
Boxplot + geom_boxplot() + labs(x = "Group", y = "Value") + facet_wrap(~ Outcome_Measure)
imageFile <- paste(imageDirectory,"16 chicken Boxplot.png",sep="/")
ggsave(file = imageFile)


Bar <- ggplot(chickenMelt, aes(group, Value))
Bar + stat_summary(fun.y = mean, geom = "bar", position = "dodge", fill = "white") + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Group", y = "Value") + facet_wrap(~ Outcome_Measure, ncol = 2, scales = "free_y")
imageFile <- paste(imageDirectory,"16 chicken Bar.png",sep="/")
ggsave(file = imageFile)


options(digits = 3)
by(chickenData$quality, chickenData$group, stat.desc, basic = FALSE)
by(chickenData$quantity, chickenData$group, stat.desc, basic = FALSE)
options(digits = 7)

by(chickenData[, 2:3], chickenData$group, cov)


# 
# install.packages(mvnormtest)
# install.packages(MVN)
library(mvnormtest)
library(MVN)

# 데이터 전처리
Manic_Psychosis <- t(chickenData[1:10, 2:3])
Sussex_Lecturers <- t(chickenData[11:20, 2:3])

# Shapiro-Wilk 다변량 정규성 검정
mshapiro.test(as.matrix(Manic_Psychosis))
mshapiro.test(as.matrix(Sussex_Lecturers))

# 다변량 정규성 시각화
aq.plot(chickenData[, 2:3])

#---Main analysis
contrasts(chickenData$group)<-c(-1, 1)

outcome<-cbind(chickenData$quality, chickenData$quantity)
chickenModel<-manova(outcome ~ group, data = chickenData)
summary(chickenModel, intercept = TRUE)

summary.aov(chickenModel)

qualityModel<-lm(quality ~ group, data = chickenData)
quantityModel<-lm(quantity ~ group, data = chickenData)

summary.lm(qualityModel)
summary.lm(quantityModel)

#---DFA

chickenDFA<-lda(group ~ quality + quantity, data = chickenData)

plot(chickenDFA)

#-------Smart Alex Task 2-----

lyingData<-read.delim("lying.dat", header = TRUE)
lyingData$lying<-factor(lyingData$lying, levels = c("Lying Prevented", "Normal Parenting", "Lying Encouraged"))

#---Explore the data
# Graphs

lyingMelt<-melt(lyingData, id = c("lying"), measured = c("salary", "family", "work"))
names(lyingMelt)<-c("lying", "Outcome_Measure", "Value")


Boxplot <- ggplot(lyingMelt, aes(lying, Value))
Boxplot + geom_boxplot() + labs(x = "Treatment Group", y = "Value") + facet_wrap(~ Outcome_Measure, ncol = 3, scales = "free_y")
imageFile <- paste(imageDirectory,"16 Lying Boxplot.png",sep="/")
ggsave(file = imageFile)


Bar <- ggplot(lyingMelt, aes(lying, Value))
Bar + stat_summary(fun.y = mean, geom = "bar", position = "dodge", fill = "white") + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Treatment Group", y = "Value") + facet_wrap(~ Outcome_Measure, ncol = 3, scales = "free_y")
imageFile <- paste(imageDirectory,"16 lying Bar.png",sep="/")
ggsave(file = imageFile)


options(digits = 3)
by(lyingData$salary, lyingData$lying, stat.desc, basic = FALSE)
by(lyingData$family, lyingData$lying, stat.desc, basic = FALSE)
by(lyingData$work, lyingData$lying, stat.desc, basic = FALSE)
options(digits = 7)


by(lyingData[, 2:4], lyingData$lying, cov)


# selects the rows and columns of the data frame for each group, the t() rtransposes the data (so variables are in rows and cases in columns, which is the format that the shapiro test function requires)

lp<-t(lyingData[1:14, 2:4])
np<-t(lyingData[15:28, 2:4])
le<-t(lyingData[29:42, 2:4])

mshapiro.test(lp)
mshapiro.test(np)
mshapiro.test(le)

aq.plot(lyingData[, 2:4])


#---Main analysis

Encouraged_vs_Not<-c(1, 1, -2)
normal_vs_prevented <-c(1, -1, 0)
contrasts(lyingData$lying)<-cbind(Encouraged_vs_Not, normal_vs_prevented)

outcome<-cbind(lyingData$salary, lyingData$family, lyingData$work)
lyingModel<-manova(outcome ~ lying, data = lyingData)
summary(lyingModel, intercept = TRUE)

summary.aov(lyingModel)

salaryModel<-lm(salary ~ lying, data = lyingData)
familyModel<-lm(family ~ lying, data = lyingData)
workModel<-lm(work ~ lying, data = lyingData)
summary.lm(salaryModel)
summary.lm(familyModel)
summary.lm(workModel)

#---Robust analysis
lyingData$row<-rep(1:14, 3)

lyingMelt<-melt(lyingData, id = c("lying", "row"), measured = c("salary", "family", "work"))
names(lyingMelt)<-c("lying", "row", "Outcome_Measure", "value")
lyingRobust<-cast(lyingMelt, row ~ lying + Outcome_Measure, value = "value")
lyingRobust$row<-NULL

mulrank(3, 3, lyingRobust)
cmanova(3, 3, lyingRobust)

#-------Smart Alex Task 3-----

psychologyData<-read.delim("psychology.dat", header = TRUE)

psychologyData$group<-factor(psychologyData$group, levels = c(0:2), labels = c("Yr_1", "Yr_2", "Yr_3"))


by(psychologyData$exper, list(psychologyData$group), stat.desc, basic = FALSE)
by(psychologyData$stats, list(psychologyData$group), stat.desc, basic = FALSE)
by(psychologyData$social, list(psychologyData$group), stat.desc, basic = FALSE)
by(psychologyData$develop, list(psychologyData$group), stat.desc, basic = FALSE)
by(psychologyData$person, list(psychologyData$group), stat.desc, basic = FALSE)

by(psychologyData[, 2:6], psychologyData$group, cov)


# selects the rows and columns of the data frame for each group, the t() rtransposes the data (so variables are in rows and cases in columns, which is the format that the shapiro test function requires)


Yr_1<-t(psychologyData[1:11, 2:6])
Yr_2<-t(psychologyData[12:27, 2:6])
Yr_3<-t(psychologyData[28:40, 2:6])

mshapiro.test(Yr_1)
mshapiro.test(Yr_2)
mshapiro.test(Yr_3)

# aq.plot(psychologyData[, 2:6])

#---Main analysis

#Contrasts
Yr1_vs_others<-c(-2, 1, -1)
Yr2_vs_Yr3 <-c(0, -1, 1)
contrasts(psychologyData$group)<-cbind(Yr1_vs_others, Yr2_vs_Yr3)


outcome<-cbind(psychologyData$exper, psychologyData$stats, psychologyData$social, psychologyData$develop, psychologyData$person)
psychologyModel<-manova(outcome ~ group, data = psychologyData)
summary(psychologyModel, intercept = TRUE)

summary.aov(psychologyModel)
#---DFA
psychologyDFA<-lda(group ~ exper + stats + social + develop + person, data = psychologyData, prior = c(11, 16, 13)/40)

psychologyDFA
# 
plot(psychologyDFA)
predict(psychologyDFA)


#---Robust analysis
psychologyData$row<-rep(c(1:11, 1:16, 1:13))

psychologyMelt<-melt(psychologyData, id = c("group", "row"), measured = c("exper", "stats", "social", "develop", "person"))


names(psychologyMelt)<-c("group", "row", "Outcome_Measure", "value")
psychologyRobust<-cast(psychologyMelt, row ~ group + Outcome_Measure, value = "value")
psychologyRobust$row<-NULL

mulrank(3, 5, psychologyRobust)
cmanova(3, 5, psychologyRobust)






