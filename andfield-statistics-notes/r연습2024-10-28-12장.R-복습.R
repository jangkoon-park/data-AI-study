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

# install.packages("ancova")

# 데이터 생성
library(reshape2)
data <- data.frame(
  subject = factor(1:10),
  time1 = rnorm(10, 70, 5),
  time2 = rnorm(10, 75, 5),
  time3 = rnorm(10, 80, 5)
)

# 데이터를 long 형식으로 변환
data_long <- melt(data, id.vars = "subject", variable.name = "time", value.name = "score")


repeated_measures_anova <- aov(score ~ time + Error(subject/time), data = data_long)
summary(repeated_measures_anova)

# 데이터를 long 형식으로 변환
data_long <- melt(data, id.vars = "subject", variable.name = "time", value.name = "score")


#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/12장" 

#Read in the data:
fugaziData<-read.delim("fugazi.dat", header = TRUE)

#Set music and age to be factors:
fugaziData$music<-factor(fugaziData$music, levels = c(1:3), labels = c("Fugazi", "Abba", "Barf Grooks"))

fugaziData$age<-factor(fugaziData$age, levels = c(1:2), labels = c("40+", "0-40"))

#Error bar graph:
bar <- ggplot(fugaziData, aes(music, liking, fill = age))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Music", y = "Mean Liking Rating", fill = "Age Group") 

#Descriptive statistics;

by(fugaziData$liking, list(fugaziData$age, fugaziData$music), stat.desc)

#Levene's Test:
leveneTest(fugaziData$liking, interaction(fugaziData$music, fugaziData$age), center = median)

#ANOVA
contrasts(fugaziData$music)<-cbind(c(1, -2, 1), c(1, 0, -1))
contrasts(fugaziData$age)<-c(-1, 1)
fugaziModel<-aov(liking ~ music*age, data = fugaziData)
Anova(fugaziModel, type="III")

#To view contrasts:
summary.lm(fugaziModel)

#Plots:
plot(fugaziModel)

#Error bar graph music vs liking:
bar <- ggplot(fugaziData, aes(music, liking))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Music", y = "Mean Liking Rating") 

#Error bar graph Age vs liking:
bar <- ggplot(fugaziData, aes(age, liking))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Age", y = "Mean Liking Rating") 

#Post hocs 
pairwise.t.test(fugaziData$liking, fugaziData$music, p.adjust.method = "bonferroni")


omega_factorial<-function(n,a,b, SSa, SSb, SSab, SSr)
{
  MSa<-SSa/(a-1)
  MSb<-SSb/(b-1)
  MSab<-SSab/((a-1)*(b-1))
  MSr<-SSr/(a*b*(n-1))
  varA<-((a-1)*(MSa-MSr))/(n*a*b)
  varB<-((b-1)*(MSb-MSr))/(n*a*b)
  varAB<-((a-1)*(b-1)*(MSab-MSr))/(n*a*b)
  varTotal<-varA + varB + varAB + MSr
  
  print(paste("Omega-Squared A: ", varA/varTotal))
  print(paste("Omega-Squared B: ", varB/varTotal))
  print(paste("Omega-Squared AB: ", varAB/varTotal))
}
#Effect Sizes	
omega_factorial(15,2,3,1,81864,310790,32553)

#-------Smart Alex Task 2-----
chickFlick<-read.delim("ChickFlick.dat", header = TRUE)

#Levene's tests:
leveneTest(chickFlick$arousal, interaction(chickFlick$film, chickFlick$gender), center = median)

# chickFlick$film<-factor(chickFlick$film, levels = c(0:1), labels = c("Bridget Jones' Diary","Memento"))

chickFlick$film<-factor(chickFlick$film, levels = c("Bridget Jones' Diary","Memento") , labels = c("Bridget Jones' Diary","Memento"))

chickFlick$gender<-factor(chickFlick$gender, levels = c("Male", "Female"), labels = c("Male", "Female"))

#ANOVA
contrasts(chickFlick$film)<-c(-1, 1)
contrasts(chickFlick$gender)<-c(1, -1)
chickFlick<-aov(arousal ~ gender*film, data = chickFlick)
Anova(chickFlick, type="III")

#Error bar graph (gender vs mean arousal)
bar <- ggplot(chickFlick, aes(gender, arousal))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Gender", y = "Mean Arousal") 

#Error bar graph (film vs mean arousal)
bar <- ggplot(chickFlick, aes(film, arousal))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Film", y = "Mean Arousal") 

#Error bar graph- interaction 
bar <- ggplot(chickFlick, aes(gender, arousal, fill = film))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Gender", y = "Mean Arousal", fill = "Film") 

#View contrasts:

summary.lm(chickFlick)

#Effect Sizes

omega_factorial(10,2,2,87,1092,34.2,1467.7)


#-------Smart Alex Task 3-----


#Read in the data:
escapeData<-read.delim("Escape From Inside.dat", header = TRUE)

#Set Song Type and Songwriter to be factors:
escapeData$Song_Type<-factor(escapeData$Song_Type, levels = c(0:1), labels = c("Symphony", "Fly Song"))

escapeData$Songwriter<-factor(escapeData$Songwriter, levels = c(0:1), labels = c("Malcom", "Andy"))

#Error line graph:
line <- ggplot(escapeData, aes(Song_Type, Screams, colour = Songwriter))
line + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Songwriter)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Type of Song", y = "Mean Number of Screams Elicited by the Song", colour = "Songwriter") 

#Levene's Test:

leveneTest(escapeData$Screams, interaction(escapeData$Song_Type, escapeData$Songwriter), center = median)

#ANOVA
contrasts(escapeData$Song_Type)<-c(-1, 1)
contrasts(escapeData$Songwriter)<-c(1, -1)
escapeModel<-aov(Screams ~ Song_Type*Songwriter, data = escapeData)
Anova(escapeModel, type="III")

#Error bar graph Type of Song vs Screams:
bar <- ggplot(escapeData, aes(Song_Type, Screams))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Type of Song", y = "Mean Number of Screams Elicited by the Song") 

#Error bar graph Songwriter vs Screams:
bar <- ggplot(escapeData, aes(Songwriter, Screams))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Songwriter", y = "Mean Number of Screams Elicited by the Song") 

#Effect Sizes
omega_factorial(17,2,2,74.1,35.3,18,227.3)

#-------Smart Alex Task 4-----

#Load in the data:
gogglesData<-read.csv("goggles.csv", header = TRUE)

#simple effects
gogglesData$simple<-gl(6,8)
gogglesData$simple<-factor(gogglesData$simple, levels = c(1:6), labels = c("Female_0","Female_2", "Female_4","Male_0","Male_2", "Male_4"))

genderEffect1<-c(1, 1, 1, -1, -1, -1)
MaleEffect1<-c(0, 0, 0, -2, 1, 1)
MaleEffect2<-c(0, 0, 0, 0, 1, -1)
FemaleEffect1<-c(-2, 1, 1, 0, 0, 0)
FemaleEffect2<-c(0, 1, -1, 0, 0, 0)
simpleEff<-cbind(genderEffect1, MaleEffect1, MaleEffect2, FemaleEffect1, FemaleEffect2)

contrasts(gogglesData$simple)<-simpleEff
simpleEffectModel<-aov(attractiveness ~ simple, data = gogglesData)

summary.lm(simpleEffectModel)



#-------Smart Alex Task 5-----

athleteData<-read.delim("wii.dat", header = TRUE)

#Graphs
athleteME <- ggplot(athleteData, aes(athlete, injury))
athleteME + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Athlete", y = "Mean Injury Score") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Athlete Main Effect.png",sep="/")
ggsave(file = imageFile)

stretchME <- ggplot(athleteData, aes(stretch, injury))
stretchME + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Stretching Routine", y = "Mean Injury Score") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Stretch Main Effect.png",sep="/")
ggsave(file = imageFile)

wiiME <- ggplot(athleteData, aes(wii, injury))
wiiME + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Wii Activity", y = "Mean Injury Score") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Main Effect.png",sep="/")
ggsave(file = imageFile)

athletestretchInt <- ggplot(athleteData, aes(stretch, injury, colour = athlete))
athletestretchInt + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= athlete)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Stretching Routine", y = "Mean Injury Score", colour = "Athlete") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Stretch Athlete Interaction.png",sep="/")
ggsave(file = imageFile)

athleteWiiInt <- ggplot(athleteData, aes(wii, injury, colour = athlete))
athleteWiiInt + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= athlete)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Wii Activity", y = "Mean Injury Score", colour = "Athlete") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Athlete Interaction.png",sep="/")
ggsave(file = imageFile)

stretcheWiiInt <- ggplot(athleteData, aes(wii, injury, colour = stretch))
stretcheWiiInt + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= stretch)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Wii Activity", y = "Mean Injury Score", colour = "Stretching Routine") + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii Stretch Interaction.png",sep="/")
ggsave(file = imageFile)

threeWayInt <- ggplot(athleteData, aes(wii, injury, colour = stretch))
threeWayInt + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= stretch)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Wii Activity", y = "Mean Injury Score", colour = "Stretching Routine") + facet_wrap(~athlete) + scale_y_continuous(breaks=seq(0,10, by = 1), limits = c(0, 10))
imageFile <- paste(imageDirectory,"12 Wii 3 way Interaction.png",sep="/")
ggsave(file = imageFile)

#Levene's test:

leveneTest(athleteData$injury, interaction(athleteData$athlete, athleteData$stretch, athleteData$wii), center = median)


#Remember you MUST set orthogonal contrasts if using Type III sums of squares
contrasts(athleteData$athlete)<-c(-1, 1)
contrasts(athleteData$stretch)<-c(-1, 1)
contrasts(athleteData$wii)<-c(-1, 1)
athleteModel<-aov(injury ~ athlete*stretch*wii, data = athleteData)
Anova(athleteModel, type="III")

summary.lm(athleteModel)

plot(athleteModel)


#Robust analysis

athleteData$row<-rep(1:15, 8)
athleteMelt<-melt(athleteData, id = c("row", "athlete", "stretch", "wii"), measured = c( "injury"))
athleteWide<-cast(athleteMelt,  row ~ athlete + stretch + wii)
athleteWide$row<-NULL

t3way(2,2,2, athleteWide)

