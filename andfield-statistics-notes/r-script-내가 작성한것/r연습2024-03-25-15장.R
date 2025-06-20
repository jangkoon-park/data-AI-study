#Initiate packages
# install.packages("car")
# install.packages("clinfun")
# install.packages("ggplot2")
# install.packages("pastecs")
# install.packages("pgirmess")

library(compute.es)
library(ez)
library(ggplot2)
library(multcomp)
library(nlme)
library(pastecs)
library(reshape)

library(car)
library(clinfun)
library(ggplot2)
library(pastecs)
library(pgirmess)
# install.packages("WRS", repos="http://R-Forge.R-project.org")

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/15장" 



#Enter raw data

sundayBDI<-c(15, 35, 16, 18, 19, 17, 27, 16, 13, 20, 16, 15, 20, 15, 16, 13, 14, 19, 18, 18)
wedsBDI<-c(28, 35, 35, 24, 39, 32, 27, 29, 36, 35, 5, 6, 30, 8, 9, 7, 6, 17, 3, 10)
drug<-gl(2, 10, labels = c("Ecstasy", "Alcohol"))
drugData<-data.frame(drug, sundayBDI, wedsBDI)


drugData<-read.delim("Drug.dat", header = TRUE)


#exploratory analysis

by(drugData[,c(2:3)], drugData$drug, stat.desc, basic=FALSE, norm=TRUE)
leveneTest(drugData$sundayBDI, drugData$drug, center = "mean")
leveneTest(drugData$wedsBDI, drugData$drug, center = "mean")

# wilcox.test(x, y = NULL, alternative = c("two.sided", "less", "greater"),
#             mu = 0, paired = FALSE, exact = FALSE, correct = FALSE, conf.level = 0.95, na.action = na.exclude)


sunModel<-wilcox.test(sundayBDI ~ drug, data = drugData)
sunModel
wedModel<-wilcox.test(wedsBDI ~ drug, data = drugData)
wedModel


sunModel<-wilcox.test(sundayBDI ~ drug, data = drugData, exact = FALSE, correct= FALSE)
sunModel
wedModel<-wilcox.test(wedsBDI ~ drug, data = drugData, exact = FALSE, correct= FALSE)
wedModel



#Jane superbrain:
g1 <- drugData$sundayBDI[drugData$drug == "Alcohol"]
g2 <- drugData$sundayBDI[drugData$drug == "Ecstasy"]
n1 <- length(g1); n2 <- length(g2)
w <- rank(c(g1, g2)) 
r1 <- w[1:n1]; r2 <- w[(n1+1):(n1+n2)]
w1 <- sum(r1); w2 <- sum(r2)
wilc1 <- w1-n1*(n1+1)/2; wilc2 <- w2-n2*(n2+1)/2
wilc = min(wilc1, wilc2)
wilc
m1 <- mean(r1); m2 <- mean(r2)
m1; m2

rFromWilcox<-function(wilcoxModel, N){
  z<- qnorm(wilcoxModel$p.value/2)
  r<- z/ sqrt(N)
  cat(wilcoxModel$data.name, "Effect Size, r = ", r)
}

rFromWilcox(sunModel, 20)
rFromWilcox(wedModel, 20)

#********************* Wilcoxon Signed Rank ********************

drugData$BDIchange<-drugData$wedsBDI-drugData$sundayBDI
by(drugData$BDIchange, drugData$drug, stat.desc, basic = FALSE, norm = TRUE)

boxplot1<-ggplot(drugData, aes(drug, sundayBDI)) + geom_boxplot()
boxplot1

boxplot2<-ggplot(drugData, aes(drug, wedsBDI)) + geom_boxplot()
boxplot2

boxplot2<-ggplot(drugData, aes(drug, wedsBDI)) + geom_boxplot()
boxplot2



alcoholData<-subset(drugData, drug == "Alcohol")
ecstasyData<-subset(drugData, drug == "Ecstasy")


by(alcoholData, alcoholData$drug, stat.desc, basic = FALSE, norm = TRUE)
alcoholModel

alcoholModel<-wilcox.test(alcoholData$wedsBDI, alcoholData$sundayBDI,  paired = TRUE, correct= FALSE)
alcoholModel

ecstasyModel<-wilcox.test(ecstasyData$wedsBDI, ecstasyData$sundayBDI, paired = TRUE, correct= FALSE)
ecstasyModel


drugMeltData<-melt(drugData, id = c("drug"), measured = c("sundayBDI", "wedsBDI"))
names(drugMeltData)<-c("drug", "BDI", "POINT")

dateBoxplot <- ggplot(drugMeltData, aes(drug , POINT, colour = BDI ))
dateBoxplot + geom_boxplot() + labs(x = "약", y = " 우울증 수치", colour = "BDI")
imageFile <- paste(imageDirectory,"14 우울증 Date Boxplot.png",sep="/")
ggsave(file = imageFile)

rFromWilcox(alcoholModel, 20)
rFromWilcox(ecstasyModel, 20)
##########################################################
# Sperm<-c(0.35, 0.58, 0.88, 0.92, 1.22, 1.51, 1.52, 1.57, 2.43, 2.79, 3.40, 4.52, 4.72, 6.90, 7.58, 7.78, 9.62, 10.05, 10.32, 21.08, 0.33, 0.36, 0.63, 0.64, 0.77, 1.53, 1.62, 1.71, 1.94, 2.48, 2.71, 4.12, 5.65, 6.76, 7.08, 7.26, 7.92, 8.04, 12.10, 18.47, 0.40, 0.60, 0.96, 1.20, 1.31, 1.35, 1.68, 1.83, 2.10, 2.93, 2.96, 3.00, 3.09, 3.36, 4.34, 5.81, 5.94, 10.16, 10.98, 18.21, 0.31, 0.32, 0.56, 0.57, 0.71, 0.81, 0.87, 1.18, 1.25, 1.33, 1.34, 1.49, 1.50, 2.09, 2.70, 2.75, 2.83, 3.07, 3.28, 4.11)
# Soya<-gl(4, 20, labels = c("No Soya", "1 Soya Meal", "4 Soya Meals", "7 Soya Meals"))
# soyaData<-data.frame(Sperm, Soya)

soyaData<-read.delim("Soya.dat", header = TRUE)
soyaData$Soya<-factor(soyaData$Soya, levels = c(1, 2, 3, 4) )

by(soyaData$Sperm, soyaData$Soya, stat.desc, basic=FALSE)
by(soyaData$Sperm, soyaData$Soya, stat.desc, desc = FALSE, basic=FALSE, norm=TRUE)


leveneTest(soyaData$Sperm, soyaData$Soya)


kruskal.test(Sperm ~ Soya, data = soyaData)


soyaData$Ranks<-rank(soyaData$Sperm)

by(soyaData$Ranks, soyaData$Soya, mean)
by(soyaData$Ranks, soyaData$Soya, stat.desc, basic=FALSE, norm=TRUE)

ggplot(soyaData, aes(Soya, Sperm)) + geom_boxplot() +
  labs(y = "Sperm Count", x = "Number of Soya Meals Per Week")

ggsave(file = paste(imageDirectory, "15 sperm boxplot.png", sep = "/"))

kruskalmc(Sperm ~ Soya, data = soyaData)
kruskalmc(Sperm ~ Soya, data = soyaData, cont = 'two-tailed')

jonckheere.test(soyaData$Sperm, as.numeric(soyaData$Soya))


#==========연습문제 15장 1번 =-===============================================================

MenDogs<-read.delim("MenLikeDogs.dat", header = TRUE)
#exploratory analysis
by(MenDogs$behaviou, MenDogs$species, stat.desc, basic=FALSE, norm=TRUE)

boxplot1<-ggplot(MenDogs, aes(species, behaviou)) + geom_boxplot()
boxplot1

leveneTest(MenDogs$behaviou, MenDogs$species, center = "mean")

dogModel<-wilcox.test(behaviou ~ species, data = MenDogs)
dogModel

#Jane superbrain: 랭킹 평균 구하기
g1 <- MenDogs$behaviou[MenDogs$species == "Dog"]
g2 <- MenDogs$behaviou[MenDogs$species == "Man"]
n1 <- length(g1); n2 <- length(g2)
w <- rank(c(g1, g2)) 
r1 <- w[1:n1]; r2 <- w[(n1+1):(n1+n2)]
w1 <- sum(r1); w2 <- sum(r2)
wilc1 <- w1-n1*(n1+1)/2; wilc2 <- w2-n2*(n2+1)/2
wilc = min(wilc1, wilc2)
wilc
m1 <- mean(r1); m2 <- mean(r2)
m1; m2

rFromWilcox<-function(wilcoxModel, N){
  z<- qnorm(wilcoxModel$p.value/2)
  r<- z/ sqrt(N)
  cat(wilcoxModel$data.name, "Effect Size, r = ", r)
}

rFromWilcox(dogModel, 40)

############################################2번 연습문제


darkLord<-read.delim("DarkLord.dat", header = TRUE)

#exploratory analysis
stat.desc(darkLord, basic=FALSE, norm=TRUE)

#Wilcoxon signed-rank test:
darkModel<-wilcox.test(darkLord$message, darkLord$nomessag,  paired = TRUE, correct= FALSE)
darkModel

rFromWilcox(darkModel, 64)
############################################3번 연습문제
eastendersData<-read.delim("Eastenders.dat", header = TRUE)
stat.desc(eastendersData, basic = FALSE, norm = TRUE)

library(reshape)

friedman.test(as.matrix(eastendersData))
friedmanmc(as.matrix(eastendersData))



