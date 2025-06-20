
#Initiate packages
library(compute.es)
library(ez)
library(ggplot2)
library(multcomp)
library(nlme)
library(pastecs)
library(reshape)
# install.packages("WRS", repos="http://R-Forge.R-project.org")

#Initiate packages
library(compute.es)
library(ez)
library(ggplot2)
library(multcomp)
library(nlme)
library(pastecs)
library(reshape)
library(WRS)
# library(WRS)
# library(WRS)
# source("http://www-rcf.usc.edu/~rwilcox/Rallfun-v14")


setwd("C:/Users/CJ/Documents/앤드필드/데이터")

imageDirectory<-"C:/Users/CJ/Documents/앤드필드/14장" 


dateData<-read.delim("LooksOrPersonality.dat", header = TRUE)

speedData<-melt(dateData, id = c("participant","gender"), measured = c("att_high", "av_high", "ug_high", "att_some", "av_some", "ug_some", "att_none", "av_none", "ug_none"))
names(speedData)<-c("participant", "gender", "groups", "dateRating")

speedData$personality<-gl(3, 60, labels = c("Charismatic", "Average", "Dullard"))
speedData$looks<-gl(3,20, 180, labels = c("Attractive", "Average", "Ugly"))

speedData<-speedData[order(speedData$participant),]



#Enter data by hand

participant<-gl(20, 9, labels = c("P01", "P02", "P03", "P04", "P05", "P06", "P07", "P08", "P09", "P10", "P11", "P12", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20" ))

participant<-gl(20, 9, labels = c(paste("P", 1:20, sep = "_")))


gender<-gl(2, 90, labels = c("Male", "Female"))
personality<-gl(3, 3, 180, labels = c("Charismatic", "Average", "Dullard"))
looks<-gl(3, 1, 180, labels = c("Attractive", "Average", "Ugly"))
dateRating<-c(86, 84, 67, 88, 69, 50, 97, 48, 47, 91, 83, 53, 83, 74, 48, 86, 50, 46, 89, 88, 48, 99, 70, 48, 90, 45, 48, 89, 69, 58, 86, 77, 40, 87, 47, 53, 80, 81, 57, 88, 71, 50, 82, 50, 45, 80, 84, 51, 96, 63, 42, 92, 48, 43, 89, 85, 61, 87, 79, 44, 86, 50, 45, 100, 94, 56, 86, 71, 54, 84, 54, 47, 90, 74, 54, 92, 71, 58, 78, 38, 45, 89, 86, 63, 80, 73, 49, 91, 48, 39, 89, 91, 93, 88, 65, 54, 55, 48, 52, 84, 90, 85, 95, 70, 60, 50, 44, 45, 99, 100, 89, 80, 79, 53, 51, 48, 44, 86, 89, 83, 86, 74, 58, 52, 48, 47, 89, 87, 80, 83, 74, 43, 58, 50, 48, 80, 81, 79, 86, 59, 47, 51, 47, 40, 82, 92, 85, 81, 66, 47, 50, 45, 47, 97, 69, 87, 95, 72, 51, 45, 48, 46, 95, 92, 90, 98, 64, 53, 54, 53, 45, 95, 93, 96, 79, 66, 46, 52, 39, 47)

speedData<-data.frame(participant, gender, personality, looks, dateRating)



#Exploring Data

dateBoxplot <- ggplot(speedData, aes(looks, dateRating, colour = personality))
dateBoxplot + geom_boxplot() + labs(x = "Attractiveness", y = "Mean Rating of Date", colour = "Charisma") + facet_wrap(~gender)
imageFile <- paste(imageDirectory,"14 Speed Date Boxplot.png",sep="/")
ggsave(file = imageFile)


looksBar <- ggplot(speedData, aes(looks, dateRating))
looksBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Attractiveness", y = "Mean Rating of Date") 
imageFile <- paste(imageDirectory,"14 Speed Date Looks.png",sep="/")
ggsave(file = imageFile)


charismaBar <- ggplot(speedData, aes(personality, dateRating))
charismaBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Charisma", y = "Mean Rating of Date") 
imageFile <- paste(imageDirectory,"14 Speed Date Charisma.png",sep="/")
ggsave(file = imageFile)

genderBar <- ggplot(speedData, aes(gender, dateRating))
genderBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Gender", y = "Mean Rating of Date") 
imageFile <- paste(imageDirectory,"14 Speed Date Gender.png",sep="/")
ggsave(file = imageFile)

genderLooks <- ggplot(speedData, aes(looks, dateRating, colour = gender))
genderLooks + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Attractiveness", y = "Mean Rating of Date", colour = "Gender") + scale_y_continuous(limits = c(0,100)) 
imageFile <- paste(imageDirectory,"14 looks  gender.png",sep="/")
ggsave(file = imageFile)

genderCharisma <- ggplot(speedData, aes(personality, dateRating, colour = gender))
genderCharisma + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Charisma", y = "Mean Rating of Date", colour = "Gender") + scale_y_continuous(limits = c(0,100)) 
imageFile <- paste(imageDirectory,"14 personality  gender.png",sep="/")
ggsave(file = imageFile)

looksCharisma <- ggplot(speedData, aes(looks, dateRating, colour = personality))
looksCharisma + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= personality)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Attractiveness", y = "Mean Rating of Date", colour = "Charisma") + scale_y_continuous(limits = c(0,100)) 
imageFile <- paste(imageDirectory,"14 personality  looks.png",sep="/")
ggsave(file = imageFile)

looksCharismaGender <- ggplot(speedData, aes(looks, dateRating, colour = personality))
looksCharismaGender + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= personality)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Attractiveness", y = "Mean Rating of Date", colour = "Charisma") + scale_y_continuous(limits = c(0,100)) + facet_wrap(~gender)
imageFile <- paste(imageDirectory,"14 three way interaction.png",sep="/")
ggsave(file = imageFile)

#using ezAnova
options(digits = 3)
by(speedData$dateRating, speedData$looks, stat.desc, basic = FALSE)
by(speedData$dateRating, speedData$personality, stat.desc, basic = FALSE)
by(speedData$dateRating, speedData$gender, stat.desc, basic = FALSE)
by(speedData$dateRating, list(speedData$looks, speedData$gender), stat.desc, basic = FALSE)
by(speedData$dateRating, list(speedData$personality, speedData$gender), stat.desc, basic = FALSE)
by(speedData$dateRating, list(speedData$looks, speedData$personality), stat.desc, basic = FALSE)
by(speedData$dateRating, list(speedData$looks, speedData$personality, speedData$gender), stat.desc, basic = FALSE)
options(digits = 7)

#using ezAnova
SomevsNone<-c(1, 1, -2)
HivsAv<-c(1, -1, 0)

AttractivevsUgly<-c(1, 1, -2)
AttractvsAv<-c(1, -1, 0)

contrasts(speedData$personality)<-cbind(SomevsNone, HivsAv)
contrasts(speedData$looks)<-cbind(AttractivevsUgly, AttractvsAv)

options(digits = 3)
speedModel<-ezANOVA(data = speedData, dv = .(dateRating), wid = .(participant),  between = .(gender), within = .(looks, personality), type = 3, detailed = TRUE)
speedModel
options(digits = 7)

#Using lme


HighvsAv<-c(1, 0, 0)
DullvsAv<-c(0, 0, 1)

AttractivevsAv<-c(1, 0, 0)
UglyvsAv<-c(0, 0, 1)

contrasts(speedData$personality)<-cbind(HighvsAv, DullvsAv)
contrasts(speedData$looks)<-cbind(AttractivevsAv, UglyvsAv)
contrasts(speedData$gender)<-c(1, 0)

#Building the model
baseline<-lme(dateRating ~ 1, random = ~1|participant/looks/personality, data = speedData, method = "ML")
looksM<-update(baseline, .~. + looks)
personalityM<-update(looksM, .~. + personality)
genderM<-update(personalityM, .~. + gender)
looks_gender<-update(genderM, .~. + looks:gender)
personality_gender<-update(looks_gender, .~. + personality:gender)
looks_personality<-update(personality_gender, .~. + looks:personality)
speedDateModel<-update(looks_personality, .~. + looks:personality:gender)


anova(baseline, looksM, personalityM, genderM, looks_gender, personality_gender, looks_personality, speedDateModel)
summary(speedDateModel)

rcontrast(-1.20802, 108)
rcontrast(3.85315, 108)
rcontrast(7.53968, 108)
rcontrast(-0.97891, 108)
