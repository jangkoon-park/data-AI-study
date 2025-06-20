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

# 
# install.packages("corpcor")
# install.packages("GPArotation")
# install.packages("psych")
# install.packages("pastecs")
# 


#------And then load these packages, along with the boot package.-----



setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/5장" 


#----------Smart Alex task 1---------

chickFlick <- read.delim(file="ChickFlick.dat", header=TRUE)

#Use by() to get descriptives for arousal, split by film
by(data=chickFlick$arousal, INDICES=chickFlick$film, FUN=describe)


#Shapiro-Wilks test for arousal split by film
by(data=chickFlick$arousal, INDICES=chickFlick$film, FUN=shapiro.test)


#Levene's test for comparison of variances of arousal scores for the two films.
leveneTest(chickFlick$arousal, chickFlick$film, center=median)

#To plot a histogram  for arousal for Bridget Jones' Diary we would execute:
library(ggplot2)

hist.arousal.Bridget <- ggplot(subset(chickFlick, chickFlick$film == "Bridget Jones' Diary"), 
                               aes(x = arousal)) + 
  geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + 
  labs(x = "Arousal", y = "Density") + 
  stat_function(fun = dnorm, 
                args = list(mean = mean(subset(chickFlick, chickFlick$film == "Bridget Jones' Diary")$arousal, na.rm = TRUE), 
                            sd = sd(subset(chickFlick, chickFlick$film == "Bridget Jones' Diary")$arousal, na.rm = TRUE)), 
                colour = "black", size = 1) + 
  theme(legend.position = "none")  # opts() 대신 theme() 사용

hist.arousal.Bridget



#To plot a histogram  for arousal for Memento we would execute:

hist.arousal.Memento <- ggplot(subset(chickFlick, chickFlick$film == "Memento"), 
                               aes(x = arousal)) + 
  geom_histogram(aes(y = ..density..), fill = "white", colour = "black", binwidth = 1) + 
  labs(x = "Arousal", y = "Density") + 
  stat_function(fun = dnorm, 
                args = list(mean = mean(subset(chickFlick, chickFlick$film == "Memento")$arousal, na.rm = TRUE), 
                            sd = sd(subset(chickFlick, chickFlick$film == "Memento")$arousal, na.rm = TRUE)), 
                colour = "black", size = 1) + 
  theme(legend.position = "none")  # opts() 대신 theme() 사용

hist.arousal.Memento


#----------Smart Alex task 2---------

#Read in R exam data.
rexam <- read.table(file="rexam.dat", header=TRUE)

#Set the variable uni to be a factor:
rexam$uni<-factor(rexam$uni, levels = c(0:1), labels = c("Duncetown University", "Sussex University"))

rexam$lognumeracy <- log(rexam$numeracy)
rexam$sqrtnumeracy <- sqrt(rexam$numeracy)
rexam$recnumeracy <- 1/(rexam$numeracy)

# Histogram for log numeracy
hist.lognumeracy <- ggplot(rexam, aes(lognumeracy)) + 
  theme(legend.position = "none") + 
  geom_histogram(aes(y=..density..), colour="black", fill="white") + 
  labs(x="Log Transformed Numeracy scores", y = "Density") + 
  stat_function(fun = dnorm, args = list(mean = mean(rexam$lognumeracy, na.rm = TRUE), sd = sd(rexam$lognumeracy, na.rm = TRUE)), colour = "black", size = 1)

# Histogram for square root numeracy
hist.sqrtnumeracy <- ggplot(rexam, aes(sqrtnumeracy)) + 
  theme(legend.position = "none") + 
  geom_histogram(aes(y=..density..), colour="black", fill="white") + 
  labs(x="Square Root of Numeracy scores", y = "Density") + 
  stat_function(fun = dnorm, args = list(mean = mean(rexam$sqrtnumeracy, na.rm = TRUE), sd = sd(rexam$sqrtnumeracy, na.rm = TRUE)), colour = "black", size = 1)

# Histogram for reciprocal numeracy
hist.recnumeracy <- ggplot(rexam, aes(recnumeracy)) + 
  theme(legend.position = "none") + 
  geom_histogram(aes(y=..density..), colour="black", fill="white") + 
  labs(x="Reciprocal of Numeracy Scores", y = "Density") + 
  stat_function(fun = dnorm, args = list(mean = mean(rexam$recnumeracy, na.rm = TRUE), sd = sd(rexam$recnumeracy, na.rm = TRUE)), colour = "black", size = 1)

# Shapiro-Wilks test for numeracy
shapiro.test(rexam$numeracy)

# Shapiro-Wilks test for log numeracy
shapiro.test(rexam$lognumeracy)

# Shapiro-Wilks test for sqrt numeracy
shapiro.test(rexam$sqrtnumeracy)

# Shapiro-Wilks test for rec numeracy
shapiro.test(rexam$recnumeracy)

# Print the histograms
print(hist.lognumeracy)
print(hist.sqrtnumeracy)
print(hist.recnumeracy)




