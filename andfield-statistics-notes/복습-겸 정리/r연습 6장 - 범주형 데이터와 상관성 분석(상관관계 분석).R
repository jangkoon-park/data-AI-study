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
library(Hmisc)
library(boot)
library(polycor)
library(ggm)

# install.packages("BiocManager")
# BiocManager::install("graph")

#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/6장" 

#----------Smart Alex task 1---------

essayData = read.delim("EssayMarks.dat",  header = TRUE)

#Create a plot object called scatter:
scatter<-ggplot(essayData, aes(hours, essay))

#Add labels and with to your scatterplot:
scatter + geom_point(size = 3) + labs(x = "Hours Spent on Essay", y = "Essay Mark (%)") 

#Do a Shapiro-Wilks test to see whether the data are normal:

shapiro.test(essayData$essay)
shapiro.test(essayData$hours)

#Because the shapiro-Wilks tests were both non-sig we can use pearsons correltation:
cor.test(essayData$essay, essayData$hours, alternative = "greater", method = "pearson")

#correlation of hours spent on essay and grade:

essayData$grade<-factor(essayData$grade, levels = c("First Class","Upper Second Class", "Lower Second Class", "Third Class"))

cor.test(essayData$hours, as.numeric(essayData$grade), alternative = "less", method = "kendall")
cor.test(essayData$hours, as.numeric(essayData$grade), alternative = "less", method = "spearman")


#Smart Alex Task 2-------------

#load the data:

chickFlick = read.delim("ChickFlick.dat", header = TRUE)

#conduct two point-biserial correlations:
chickFlick$gender <- as.numeric(factor(chickFlick$gender, levels = c("Male", "Female")))
data_clean <- na.omit(chickFlick[, c("gender", "arousal")])

cor.test(data_clean$gender, data_clean$arousal)
# Male   Female         
# cor.test(chickFlick$gender, chickFlick$arousal)
chickFlick$film <- as.numeric(factor(chickFlick$film))
cor.test(chickFlick$film, chickFlick$arousal)
#Smart Alex Task 3--------

#load in the data

gradesData = read.csv("grades.csv", header = TRUE)

#Conduct a Spearman correlation:
cor.test(gradesData$gcse, gradesData$stats, alternative = "greater", method = "spearman")

#conduct a Kendall correlation:
cor.test(gradesData$gcse, gradesData$stats, alternative = "greater", method = "kendall")



#Smart Alex Task 3--------

#load in the data

gradesData = read.csv("grades.csv", header = TRUE)

#Conduct a Spearman correlation:
cor.test(gradesData$gcse, gradesData$stats, alternative = "greater", method = "spearman")

#conduct a Kendall correlation:
cor.test(gradesData$gcse, gradesData$stats, alternative = "greater", method = "kendall")


#-------R Souls Tip Writing Functions----

meanOfVariable<-function(variable)
{
  mean<-sum(variable)/length(variable)
  cat("Mean = ", mean)
  
}
meanOfVariable<-function(HarryTheHungyHippo)
{
  mean<-sum(HarryTheHungyHippo)/length(HarryTheHungyHippo)
  cat("Mean = ", mean)
}
lecturerFriends = c(1,2,3,3,4)

meanOfVariable(lecturerFriends)



