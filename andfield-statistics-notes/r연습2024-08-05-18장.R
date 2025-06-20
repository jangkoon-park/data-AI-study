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

# install.packages("gmodels")
# install.packages("MASS")

library(gmodels)
library(MASS)

# install.packages("corpcor")
# install.packages("GPArotation")
# install.packages("psych")
# install.packages("pastecs")
# 


#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/18장" 



Training<-c(rep(0, 38), rep(1, 162))
Dance<-c(rep(1, 10), rep(0, 28),  rep(1, 114), rep(0, 48))

Training<-factor(Training, labels = c("Food as Reward", "Affection as Reward"))
Dance<-factor(Dance, labels = c("No", "Yes"))

catsData<-data.frame(Training, Dance)


catsData<-read.delim("Cats.dat", header = TRUE)

#Enter contingency table data
food <- c(10, 28)
affection <- c(114, 48)
catsTable <- cbind(food, affection) 


#Do the chi-square test
# CrossTable(predictor, outcome, fisher = TRUE, chisq = TRUE, expected = TRUE)
# CrossTable(contingencyTable, fisher = TRUE, chisq = TRUE, expected = TRUE)

# CrossTable(catsData$Training, catsData$Dance, fisher = TRUE, chisq = TRUE, expected = TRUE, sresid = TRUE, format = "SPSS")
# CrossTable(catsTable, fisher = TRUE, chisq = TRUE, expected = TRUE, sresid = TRUE, format = "SPSS")

CrossTable(catsData$Training, catsData$Dance, fisher = TRUE, chisq = TRUE, expected = TRUE, prop.c = FALSE, prop.t = FALSE, prop.chisq = FALSE,  sresid = TRUE, format = "SPSS")

catsRegression<-read.delim("CatRegression.dat", header = TRUE)

catModel<-lm(LnObserved ~ Training + Dance + Interaction, data = catsRegression)
summary(catModel)


catModel2<-lm(LnExpected ~ Training + Dance, data = catsRegression)
summary(catModel2)


##################### Cats and Dogs.dat ############로그 선형분석##################

catsDogs<-read.delim("CatsandDogs.dat", header = TRUE)
catsDogs


table(catsDogs$Animal, catsDogs$Training, catsDogs$Dance)
xtabs(~Animal + Training + Dance, data = catsDogs)

justCats = subset(catsDogs, Animal=="Cat")
justDogs = subset(catsDogs, Animal=="Dog")


catTable<-xtabs(~ Training + Dance, data = justCats)

CrossTable(justCats$Training, justCats$Dance, sresid = TRUE, prop.t=FALSE, prop.c=FALSE, prop.chisq=FALSE, format = "SPSS")

CrossTable(justDogs$Training, justDogs$Dance, sresid = TRUE, prop.t=FALSE, prop.c=FALSE, prop.chisq=FALSE, format = "SPSS")



catSaturated<-loglm(~ Training + Dance + Training:Dance, data = catTable, fit = TRUE)


catNoInteraction<-loglm(~ Training + Dance, data = catTable, fit = TRUE)
summary(catSaturated); summary(catNoInteraction)
#mosaic plot

mosaicplot(catSaturated$fit, shade = TRUE, main = "Cats: Saturated Model")
mosaicplot(catNoInteraction$fit, shade = TRUE, main = "Cats: Expected Values")






