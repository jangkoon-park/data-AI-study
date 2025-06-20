library(car)
library(ggplot2)
library(pastecs)
library(psych)
# install.packages("Hmisc")
# install.packages("polycor")
# install.packages("ggm")

#Initiate packages
library(Hmisc)
library(ggplot2)
library(boot)
library(polycor)
library(ggm)
library(Rcmdr)
# install.packages("Rcmdr", repos="http://cran.r-project.org")
# install.packages("Rcmdr", dependencies = TRUE)  library(Rcmdr) 에러 날때 직접 콘솔에 대고 실행해

setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/6장/"
# delim <- read.delim("C:/Users/Owner/Documents/앤드필드_R/5장/rexam.dat", header=TRUE)
rexam <- read.delim("rexam.dat", header=TRUE) 

#Set the variable uni to be a factor:
rexam$uni<-factor(rexam$uni, levels = c(0:1), labels = c("Duncetown University", "Sussex University"))

rexam
# exam computer lectures numeracy uni



adverts<-c(5,4,4,6,8)
packetsNA<-c(8,9,10,NA,15)
age<-c(5, 12, 16, 9, 14)
advertNA<-data.frame(adverts, packetsNA, age)
cor(advertNA, use = "everything",  method = "pearson")
cor(advertNA, use = "complete.obs",  method = "kendall")
cor(advertNA, use = "pairwise.complete.obs",  method = "kendall")

cor(x,y, use = "everything", method = "correlation type")
cor.test(x,y, alternative = "string", method = "correlation type", conf.level = 0.95)

examData = read.delim("Exam Anxiety.dat",  header = TRUE)
examData
examData2 <- examData[, c("Exam", "Anxiety", "Revise")]
cor(examData[, c("Exam", "Anxiety", "Revise")])


examMatrix<-as.matrix(examData[, c("Exam", "Anxiety", "Revise")])
Hmisc::rcorr(examMatrix)
Hmisc::rcorr(as.matrix(examData[, c("Exam", "Anxiety", "Revise")]))



cor.test(examData$Anxiety, examData$Exam)
cor.test(examData$Revise, examData$Exam)
cor.test(examData$Anxiety, examData$Revise)

liarData = read.delim("The Biggest Liar.dat",  header = TRUE)
liarData

cor(liarData$Position, liarData$Creativity, method = "spearman")

liarMatrix<-as.matrix(liarData[, c("Position", "Creativity")])
rcorr(liarMatrix)


adverts<-c(5,4,4,6,8) #//시청광고수
packets<-c(8,9,10,13,15) #//구매한 봉지수
advertData<-data.frame(adverts, packets)

cor(advertData$adverts, advertData$packets, method = "pearson")

cor.test(advertData$adverts, advertData$packets, alternative = "greater", method = "kendall")




bootTau<-function(liarData,i)cor(liarData$Position[i], liarData$Creativity[i], use = "complete.obs", method = "kendall")
boot_kendall<-boot(liarData, bootTau, 2000)
boot_kendall
boot.ci(boot_kendall)
boot.ci(boot_kendall, 0.99)

catData = read.csv("pbcorr.csv",  header = TRUE)

catData

cor(catData$time , catData$recode , method = "pearson")


examData = read.delim("Exam Anxiety.dat",  header = TRUE)
examData
examData2 <- examData[, c("Exam", "Anxiety", "Revise")]

pc<-pcor(c("Exam", "Anxiety", "Revise"), var(examData2))
pc
pc^2
pcor.test(pc, 1, 103)




grades = read.csv("grades.csv",  header = TRUE)

grades

# stats gcse
cor.test(grades$stats, grades$gcse, method = "pearson")
cor.test(grades$stats, grades$gcse,alternative = "greater", method = "pearson")
