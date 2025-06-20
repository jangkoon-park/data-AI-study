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
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/15장" 


#---------Smart Alex Task 1---------------------------

MenDogs<-read.delim("MenLikeDogs.dat", header = TRUE)

#exploratory analysis
by(MenDogs[,2], MenDogs$species, stat.desc, basic=FALSE, norm=TRUE)

#Wilcoxon rank sum test
MenDogsModel<-wilcox.test(behaviou ~ species, data = MenDogs)
MenDogsModel


rFromWilcox(MenDogsModel, 40)


#---------Smart Alex Task 2---------------------------

darkLord<-read.delim("DarkLord.dat", header = TRUE)

#exploratory analysis
stat.desc(darkLord, basic=FALSE, norm=TRUE)

#Wilcoxon signed-rank test:
darkModel<-wilcox.test(darkLord$message, darkLord$nomessag,  paired = TRUE, correct= FALSE)
darkModel

#Effect size (make sure that you have executed the function from the book chapter first)
rFromWilcox(darkModel, 64)



#---------Smart Alex Task 3---------------------------

eastendersData<-read.delim("Eastenders.dat", header = TRUE)
stat.desc(eastendersData, basic = FALSE, norm = TRUE)

library(reshape)

friedman.test(as.matrix(eastendersData))
friedmanmc(as.matrix(eastendersData))


#---------Smart Alex Task 4---------------------------
clownData<-read.delim("coulrophobia.dat", header = TRUE)

#Relevel the variable infotype:
clownData$infotype<-factor(clownData$infotype, levels = levels(clownData$infotype)[c(3, 1, 2, 4)])

#Descriptives:
by(clownData$beliefs, clownData$infotype, stat.desc, basic=FALSE)


kruskal.test(beliefs ~ infotype, data = clownData)
clownData$Ranks<-rank(clownData$beliefs)
by(clownData$Ranks, clownData$infotype, mean)

#Compare each group against the control
kruskalmc(beliefs ~ infotype, data = clownData, cont = 'two-tailed')

jonckheere.test(clownData$beliefs, as.numeric(clownData$infotype))

#Relevel the variable infotype so that Adverts is level 1:
clownData$infotype<-factor(clownData$infotype, levels = levels(clownData$infotype)[c(2, 1, 3, 4)])

#Compare each group against Adverts:
kruskalmc(beliefs ~ infotype, data = clownData, cont = 'two-tailed')





