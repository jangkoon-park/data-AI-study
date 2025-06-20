# install.packages("ggplot2")
# install.packages("pastecs")
# install.packages("WRS")
# install.packages("Hmisc")


#------WRS 설치방벙.-----
# install.packages(c("MASS", "akima", "robustbase"))
# install.packages(c("cobs", "robust", "mgcv", "scatterplot3d", "quantreg", "rrcov", "lars", "pwr", "trimcluster", "parallel", "mc2d", "psych", "Rfit"))
# install.packages("WRS", repos="http://R-Forge.R-project.org", type="source")


#------Rcmdr 설치방벙.-----
# install.packages(c("RcmdrMisc", "car", "effects"))
# install.packages("Rcmdr")
# 
# install.packages("tcltk")

library(ggplot2)
library(pastecs)
library(reshape)
library(WRS)


library(lattice)
lattice.options(default.theme = standard.theme(color = FALSE))

library(splines)
library(RcmdrMisc)
library(car)
library(sandwich)
library(effects)

# install.packages("qqnorm_spss")
# library(qqnorm_spss)

#library(Rcmdr)

source("http://dornsife.usc.edu/assets/sites/239/docs/Rallfun-v21")

setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/"  


dummy<-read.delim("dummy.dat", header = TRUE)


dummy.1 <- lm(libido  ~ dummy1+dummy2 , data = dummy)

summary(dummy.1)
sqrt(0.3346)

# install.packages("car")
library(car)


leveneTest(dummy$dummy1, dummy$dummy2)

# 
# group1 <- c(1, 2, 3, 4, 5)
# group2 <- c(2, 3, 4, 5, 6)
# group3 <- c(3, 4, 5, 6, 7)
# 
# 
# class(group1)
# class(group2)
# class(group3)
# 
# sum(is.na(group1))
# sum(is.na(group2))
# sum(is.na(group3))
# 
# 
# leveneTest(group1, group2, group3)


Contrast<-read.delim("Contrast.dat", header = TRUE)

Contrast.1 <- lm(libido  ~ dummy1+dummy2 , data = Contrast)

summary(Contrast.1)

# 범주형 변수 생성
category <- factor(c("A", "B", "C", "A", "B", "C"))

# Treatment Contrast 설정
contrasts(category) <- contr.treatment(3)

# 결과 확인
summary(lm(1:6 ~ category))


contr.treatment()
contr.SAS()
contr.helmert()

contr.SAS()
contrasts(category)


 

Viagra<-read.delim("Viagra.dat", header = TRUE)


libido<-   c(3,2,1,1,4,5,2,4,2,3,7,4,5,3,6)

dose<-gl(3,5, labels   = c("Placebo", "Low Dose", "High Dose"))
            
viagraData<- data.frame(dose, libido)
        
line <- ggplot(viagraData, aes(dose, libido))



line + stat_summary(
  fun.y = mean,
  geom = "line",
  size = 1,
  aes(group = 1),
  colour = "#FF6633"
) + stat_summary(
  fun.data = mean_cl_boot,
  geom = "errorbar",
  width = 0.2,
  size = 0.75,
  colour = "#990000"
) + stat_summary(
  fun.y = mean,
  geom = "point",
  size = 4,
  colour = "#990000"
)  + labs(x = "Dose of Viagra", y = "Mean Libido")



imageFile <- paste(imageDirectory,"10 Viagra Line.png",sep="/")

ggsave(file = imageFile)


#Descriptives
by(viagraData$libido, viagraData$dose, stat.desc)



#Levene's test
leveneTest(viagraData$libido, viagraData$dose, center = median)
#levene.test(viagraData$libido, viagraData$dose)


viagraModel<-aov(libido~dose, data = viagraData)

summary(viagraModel)
summary.lm(viagraModel)
plot(viagraModel)

contrasts(viagraData$dose)<-contr.poly(3)

viagraTrend<-aov(libido~dose, data = viagraData)
summary.lm(viagraTrend)

pairwise.t.test(viagraData$libido, viagraData$dose, p.adjust.method = "bonferroni")
pairwise.t.test(viagraData$libido, viagraData$dose, p.adjust.method = "BH")
viagraWide<-unstack(viagraData, libido~dose)

lincon(viagraWide, tr = .1)
mcppb20(viagraWide, tr = .1, nboot = 2000)


# 10장 연습문제 1번


teach<-read.delim("Teach.dat", header = TRUE)


line <- ggplot(teach, aes(group , exam))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=1), colour = "#FF6633") + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75, colour = "#990000") + stat_summary(fun.y = mean, geom = "point", size = 4, colour = "#990000") + stat_summary(fun.y = mean, geom = "point", size = 3, colour = "#FF6633") + labs(x = "징벌 보상 무관심", y = "시험백분율")

by(teach$exam, teach$group, stat.desc)

leveneTest(teach$exam, teach$group, center = median)

teachModel<-aov(exam~group, data = teach)

summary(teachModel)
summary.lm(teachModel)
plot(teachModel)

teach$group <- as.factor(teach$group)

contrast1<-c(-1,-1,2)
contrast2<-c(1,-1,0)

contrasts(teach$group)<-cbind(contrast1, contrast2)
teach$group

teachPlanned<-aov(exam~group, data = teach)

summary.lm(teachPlanned)



# 10장 연습문제 2번

superData = read.delim("Superhero.dat", header = TRUE)

superData$hero<-factor(superData$hero, levels = c(1:4), labels = 
                         c("Spiderman","Superman", "Hulk", "Ninja Turtle"))

line <- ggplot(superData, aes(hero  , injury))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=1), colour = "#FF6633") + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75, colour = "#990000") + stat_summary(fun.y = mean, geom = "point", size = 4, colour = "#990000") + stat_summary(fun.y = mean, geom = "point", size = 3, colour = "#FF6633") + labs(x = "징벌 보상 무관심", y = "시험백분율")

by(superData$injury, superData$hero, stat.desc)



leveneTest(superData$injury, superData$hero, center = median)


superDataModel<-aov(injury~hero, data = superData)



summary(superDataModel)
summary.lm(superDataModel)
plot(superDataModel)

pairwise.t.test(superData$injury, superData$hero, p.adjust.method = "BH")


bar <- ggplot(superData, aes(hero, injury))
bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + 
  stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Superhero Costume", y = "Mean Severity of Injury")




# 10장 연습문제 3번

soyaData = read.delim("Soya.dat", header = TRUE)

#Descriptives:

by(soyaData$Sperm, soyaData$Soya, stat.desc)

#Set soya to be a factor:


soyaData$Soya <- as.factor(soyaData$Soya)


leveneTest(soyaData$Sperm, soyaData$Soya, center = "median")



soyaDataModel<-aov(Sperm~Soya, data = soyaData)

summary(soyaDataModel)
summary.lm(soyaDataModel)


pairwise.t.test(soyaData$Sperm, soyaData$Soya, p.adjust.method = "BH")


bar <- ggplot(soyaData, aes(Soya, Sperm))
bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + 
  stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Superhero Costume", y = "Mean Severity of Injury")


# 모수 비모수 둘다 가능?
oneway.test(Sperm~Soya, data = soyaData) 


# 10장 연습문제 4번-------------------

tumourData = read.delim("Tumour.dat", header = TRUE)

tumourData$usage<-factor(tumourData$usage, levels = c(0:5), labels = c("0 Hours", "1 Hour", "2 Hours", "3 Hours", "4 Hours", "5 Hours"))

#Error bar graph

#Create a bar object:
bar <- ggplot(tumourData, aes(usage, tumour))

#Create the bar graph:
bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Mobile Phone Use (Hours Per Day)", y = "Mean Size of Tumour (MM cubed)")

#Descriptives:

by(tumourData$tumour, tumourData$usage, stat.desc)

#Conduct a Levene's test:

leveneTest(tumourData$tumour, tumourData$usage, center = "median")

#Run the one-way ANOVA:

tumourModel<-aov(tumourData$tumour~tumourData$usage, data = tumourData)

summary(tumourModel)
summary.lm(tumourModel)

oneway.test(tumour~usage, data = tumourData)

pairwise.t.test(tumourData$tumour, tumourData$usage, p.adjust.method = "BH")


#----------------Smart Alex Task 5---------------------


festivalData<-read.delim("GlastonburyFestivalRegression.dat", header = TRUE)


levels(festivalData$music)


festivalData$music <- as.factor(festivalData$music)


leveneTest(festivalData$change, festivalData$music, center = "median")


by(festivalData$change, festivalData$music, stat.desc)


festivalDataModel<-aov(change~music, data = festivalData)

summary(festivalDataModel)
summary.lm(festivalDataModel)

oneway.test(change~music, data = festivalData)

contrasts(festivalData$music)<-contr.SAS(4)


festivalContrast<-aov(change~music, data = festivalData)

summary.lm(festivalContrast)

#Post Hoc tests:

pairwise.t.test(festivalData$change, festivalData$music)

pairwise.t.test(festivalData$change, festivalData$music, p.adjust.method = "BH")



#----------------Smart Alex Task 6---------------------
quailData<-read.delim("Cetinkaya & Domjan.dat", header = TRUE)


by(quailData$Duration, quailData$Groups, stat.desc)


by(quailData$Efficiency, quailData$Groups, stat.desc)


quailData$Groups<-factor(quailData$Groups, levels = c(1:3), labels = c("Fetishistics", "NonFetishistics", "Control"))

#Create bar object and bar graph for bar graph 1:
bar <- ggplot(quailData, aes(Groups, Duration))

bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Group", y = "Mean Time Spent Near Terrycloth Object")

#Create bar object and bar graph for bar graph 2:
bar <- ggplot(quailData, aes(Groups, Efficiency))

bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Group", y = "Mean Copulatory Efficiancy")


leveneTest(quailData$Duration, quailData$Groups, center = "median")


leveneTest(quailData$Efficiency, quailData$Groups, center = "median")

quailModel.1<-aov(Duration~Groups, data = quailData)

quailModel.2<-aov(Efficiency~Groups, data = quailData)


summary(quailModel.1)

summary(quailModel.2)

#Post Hoc tests bonferroni:

pairwise.t.test(quailData$Duration, quailData$Groups, p.adjust.method = "bonferroni")

pairwise.t.test(quailData$Efficiency, quailData$Groups, p.adjust.method = "bonferroni")

# install the multcomp package
install.packages("multcomp")

# load the multcomp package
library(multcomp)

postHocs.1<-glht(quailModel.1, linfct = mcp(Groups = "Tukey"))

postHocs.2<-glht(quailModel.2, linfct = mcp(Groups = "Tukey"))

summary(postHocs.1)

confint(postHocs.1)

summary(postHocs.2)

confint(postHocs.2)



