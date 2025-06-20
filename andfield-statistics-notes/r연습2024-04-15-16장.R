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

# library(WRS)

#library(klaR)
# library(OPENMALINDO)

#install.packages("klaR")
# install.packages("mvoutlier")
# install.packages("mvnormtest")
# install.packages("pastecs")
# install.packages("reshape")
# install.packages("WRS", repos="http://R-Forge.R-project.org")


# library(WRS)
# source("http://www-rcf.usc.edu/~rwilcox/Rallfun-v14")

# install.packages("devtools")
# devtools::install_github("musto101/wilcox_R")
# library(wilcox_R)


# library(WRS)
# install.packages("WRS", repos="http://R-Forge.R-project.org")

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/16장" 

ocdData<-read.delim("OCD.dat", header = TRUE)
ocdData$Group<-factor(ocdData$Group, levels = c("CBT", "BT", "No Treatment Control"), labels = c("CBT", "BT", "NT"))

# Enter the data by hand
Group<-gl(3, 10, labels = c("CBT", "BT", "NT"))
Actions<-c(5, 5, 4, 4, 5, 3, 7, 6, 6, 4, 4, 4, 1, 1, 4, 6, 5, 5, 2, 5, 4, 5, 5, 4, 6, 4, 7, 4, 6, 5)
Thoughts<-c(14, 11, 16, 13, 12, 14, 12, 15, 16, 11, 14, 15, 13, 14, 15, 19, 13, 18, 14, 17, 13, 15, 14, 14, 13, 20, 13, 16, 14, 18)
ocdData<-data.frame(Group, Actions, Thoughts)



#---Explore the data
# Graphs

ocdScatter <- ggplot(ocdData, aes(Actions, Thoughts))
ocdScatter + geom_point() + geom_smooth(method = "lm")+ labs(x = "Number of Obsession-Related Behaviours", y = "Number of Obsession-Related Thoughts") + facet_wrap(~Group, ncol = 3)
imageFile <- paste(imageDirectory,"16 OCD Scatter.png",sep="/")
ggsave(file = imageFile)


ocdMelt<-melt(ocdData, id = c("Group"), measured = c("Actions", "Thoughts"))
names(ocdMelt)<-c("Group", "Outcome_Measure", "Frequency")


ocdBar <- ggplot(ocdMelt, aes(Group, Frequency, fill = Outcome_Measure))
ocdBar + stat_summary(fun.y = mean, geom = "bar", position = "dodge") + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Treatment Group", y = "Number of Thoughts/Actions", fill = "Outcome Measure") + scale_y_continuous(breaks = seq(0, 20, by = 2))
imageFile <- paste(imageDirectory,"16 OCD Bar.png",sep="/")
ggsave(file = imageFile)


ocdBoxplot <- ggplot(ocdMelt, aes(Group, Frequency, colour = Outcome_Measure))
ocdBoxplot + geom_boxplot() + labs(x = "Treatment Group", y = "Number of Thoughts/Actions", colour = "Outcome Measure") + scale_y_continuous(breaks = seq(0, 20, by = 2))
imageFile <- paste(imageDirectory,"16 OCD Boxplot.png",sep="/")
ggsave(file = imageFile)

options(digits = 3)
by(ocdData$Actions, ocdData$Group, stat.desc, basic = FALSE)
by(ocdData$Thoughts, ocdData$Group, stat.desc, basic = FALSE)
options(digits = 7)

by(ocdData[, 2:3], ocdData$Group, cov)

cbt<-t(ocdData[1:10, 2:3])
bt<-t(ocdData[11:20, 2:3])
nt<-t(ocdData[21:30, 2:3])

mshapiro.test(cbt)
mshapiro.test(bt)
mshapiro.test(nt)

aq.plot(ocdData[, 2:3])


ocdNoOutlier<-ocdData[-26,]

nt<-t(ocdNoOutlier[21:29, 2:3])
mshapiro.test(nt)


#---Set contrasts

CBT_vs_NT<-c(1, 0, 0)
BT_vs_NT <-c(0, 1, 0)

contrasts(ocdData$Group)<-cbind(CBT_vs_NT, BT_vs_NT)



outcome<-cbind(ocdData$Actions, ocdData$Thoughts)
ocdModel<-manova(outcome ~ Group, data = ocdData)
summary(ocdModel, intercept = TRUE)

#Anova(ocdModel, type = "III")

summary(ocdModel, intercept = TRUE, test = "Wilks")
summary(ocdModel, intercept = TRUE, test = "Hotelling")
summary(ocdModel, intercept = TRUE, test = "Roy")

#-univariate analysis
summary.aov(ocdModel)

actionModel<-lm(Actions ~ Group, data = ocdData)
thoughtsModel<-lm(Thoughts ~ Group, data = ocdData)
summary.lm(actionModel)
summary.lm(thoughtsModel)

ocdData$row<-rep(1:10, 3)

ocdMelt<-melt(ocdData, id = c("Group", "row"), measured = c("Actions", "Thoughts"))
names(ocdMelt)<-c("Group", "row", "Outcome_Measure", "Frequency")
ocdRobust<-cast(ocdMelt, row ~ Group + Outcome_Measure, value = "Frequency")
ocdRobust$row<-NULL

ocdDFA<-lda(Group ~ Actions + Thoughts, data = ocdData, na.action="na.omit")
summary(ocdDFA)
plot(ocdDFA)
predict(ocdDFA)

cbt<-t(ocdData[1:10, 2:3])
bt<-t(ocdData[11:20, 2:3])
nt<-t(ocdData[21:30, 2:3])

mshapiro.test(cbt)
mshapiro.test(bt)
mshapiro.test(nt)

aq.plot(ocdData[, 2:3])

ocdNoOutlier<-ocdData[-26,]
nt<-t(ocdNoOutlier[21:29, 2:3])
mshapiro.test(nt)

CBT_vs_NT<-c(1, 0, 0)
BT_vs_NT <-c(0, 1, 0)
contrasts(ocdData$Group)<-cbind(CBT_vs_NT, BT_vs_NT)

outcome<-cbind(ocdData$Actions, ocdData$Thoughts)
ocdModel<-manova(outcome ~ Group, data = ocdData)
summary(ocdModel, intercept = TRUE)


