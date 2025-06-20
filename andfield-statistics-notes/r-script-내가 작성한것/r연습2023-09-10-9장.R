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


# invisibility<-read.delim("invisibility.dat", header = TRUE)
# invisibility$Cloak<-factor(invisibility$Cloak, levels = c(0:1), labels = c("No Cloak", "Cloak"))


spiderWide<-read.delim("SpiderWide.dat", header = TRUE)
spiderLong<-read.delim("SpiderLong.dat", header = TRUE)

rmMeanAdjust<-function(dataframe)
{
  varNames<-names(dataframe)
  
  pMean<-(dataframe[,1] + dataframe[,2])/2
  grandmean<-mean(c(dataframe[,1], dataframe[,2]))
  adj<-grandmean-pMean
  varA_adj<-dataframe[,1] + adj
  varB_adj<-dataframe[,2] + adj
  
  output<-data.frame(varA_adj, varB_adj)
  names(output)<-c(paste(varNames[1], "adj", sep = "_"), paste(varNames[2], "_adj", sep = "_"))
  return(output)
}


rmMeanAdjust(spiderWide)


spiderWide$pMean<-(spiderWide$picture + spiderWide$real)/2
grandMean<-mean(c(spiderWide$picture, spiderWide$real))
spiderWide$adj<-grandMean-spiderWide$pMean
head(spiderWide)

spiderWide

spiderLong

#t.test.GLM<-lm(Anxiety ~ Group, data = spiderLong)
#summary(t.test.GLM)


by(spiderLong$Anxiety, spiderLong$Group , stat.desc,basic =FALSE , norm=TRUE)


t.test_t<-t.test(Anxiety ~ Group, data = spiderLong)


yuen(spiderWide$real, spiderWide$picture, tr=.2, alpha=.05)

yuenbt(spiderWide$real, spiderWide$picture, tr=.2, alpha=.05, nboot = 2000,side =T)

pb2gen(spiderWide$real, spiderWide$picture, alpha=.05, nboot=2000, est=mom)


t<-t.test_t$statistic[[1]]
df<-t.test_t$parameter[[1]]
r <- sqrt(t^2/(t^2+df))
round(r, 3)


#-----------------스파이더 차이  정규성 검정-------
spiderWide<-read.delim("SpiderWide.dat", header = TRUE)
spiderWide$diff<- spiderWide$real - spiderWide$picture 

spiderWide$diff  <- as.numeric(spiderWide$diff)

is.numeric(spiderWide$diff)

shapiro.test(spiderWide$diff)
# W = 0.95579, p-value = 0.7225

# Generate two sets of data
scores <- c(10  , 0 ,  5 , 15  ,15  ,20 , -5 , 10 ,  0 ,  5 , 20,-11 )
par(mar = c(1, 1, 1, 1))  
qqnorm(scores) 
qqline(scores)
# Create a Q-Q plot

hist(spiderWide$diff, main="Histogram of Exam Scores",
     xlab="Score Range", ylab="Frequency",
     col="lightblue", border="black",
     xlim=c(0, 50), breaks=11)


# Generate some sample data (in this case, random exam scores) 
# 특이치 20 삭제함
scores <- c(10  , 0 ,  5 , 15  ,15  ,20 , -5 , 10 ,  0 ,  5 ,-11 )

# Create a histogram with relative frequency
hist(scores, ylim = c(0, 0.1), xlim=c(-30, 30) ,main="Exam Scores Distribution", xlab="Scores", ylab="Relative Frequency", col="skyblue", border="black", freq=FALSE)


summary(spiderWide)
dep.t.test<-t.test(spiderWide$real, spiderWide$picture, paired=TRUE)



# -----------------boardFritzon-------------------------------------
boardFritzon<-read.delim("Board&Fritzon(2005).dat", header = TRUE)


boardFritzon$diff<- boardFritzon$x1 - boardFritzon$x2
# 
boardFritzon$diff  <- as.numeric(boardFritzon$diff)
# 
is.numeric(boardFritzon$diff)
# boardFritzon
# 
qqnorm(boardFritzon$diff) 
qqline(boardFritzon$diff)

#정규성 따름

dFritzon_x1  <- boardFritzon[, c("x1","sd1","n1","Outcome")] 
dFritzon_x1[,"person"] <- "ceo"
dFritzon_x2  <- boardFritzon[, c("x2","sd2","n2","Outcome")] 
dFritzon_x2[,"person"] <-  "psy"

colnames(dFritzon_x1) <- c("x"  ,"sd" ,"n","Outcome","person")
colnames(dFritzon_x2) <- c("x"  ,"sd" ,"n","Outcome","person")
dFritzon_all <- rbind(dFritzon_x1, dFritzon_x2)

dFritzon_all$group <- factor(dFritzon_all$person)

t.boardFritzon_test_t<-t.test(dFritzon_all$x ~ dFritzon_all$person, data = boardFritzon )

t.boardFritzon_test_t



# -----------------boardFritzon----해답---------------------------------

madData<-read.delim("Board&Fritzon(2005).dat", header = TRUE)

ttestfromMeans<-function(out,x1, x2, sd1, sd2, n1, n2)
{ df<-n1 + n2 - 2
poolvar <- (((n1-1)*sd1^2)+((n2-1)*sd2^2))/df
t <- (x1-x2)/sqrt(poolvar*((1/n1)+(1/n2)))
sig <- 2*(1-(pt(abs(t),df)))
outcome <-out
paste("Outcome= ",outcome, " t(df = ", df, ") = ", t, ", p = ", sig, sep = "")
}

ttestfromMeans(madData$Outcome ,madData$x1, madData$x2, madData$sd1, madData$sd2,
               madData$n1,madData$n2)




# -----------------9장 연습문제----해답---------1번------------------------
Penis<-read.delim("Penis.dat", header = TRUE)


Penis_cal <- data.frame(book1 = Penis$book[Penis$book  == 1], happy1 =  Penis$happy[Penis$book  == 1]
                        ,book2 = Penis$book[Penis$book  == 2], happy2 =  Penis$happy[Penis$book  == 2]  
                       
                        )

Penis_cal$diff <- Penis_cal$happy1-Penis_cal$happy2

Penis_cal <- subset(Penis_cal, diff != 13)


# IQR을 계산합니다.
iqr <- IQR(Penis_cal$diff)

# 이상치를 계산합니다.
outliers <- Penis_cal$diff[abs(Penis_cal$diff - median(Penis_cal$diff)) > 1.5 * iqr]

# 이상치를 출력합니다.
outliers


# Z-score를 계산합니다.
zscore <- (Penis_cal$diff - mean(Penis_cal$diff)) / sd(Penis_cal$diff)

# 이상치를 계산합니다.
outliers <- Penis_cal$diff[zscore > 0.8 | zscore < -0.8]

# 이상치를 출력합니다.
outliers

shapiro.test(Penis_cal$diff)


qqnorm(Penis_cal$diff) 
qqline(Penis_cal$diff)



t.Penis_t<-t.test(happy ~ book, data = Penis )

# -----------------9장 연습문제----해답---------2번------------------------
fieldHold<-read.delim("Field&Hole.dat", header = TRUE)


# women statbook
shapiro.test(fieldHold$women )
qqnorm(fieldHold$women ) 
qqline(fieldHold$women )


shapiro.test(fieldHold$statbook )
qqnorm(fieldHold$statbook ) 
qqline(fieldHold$statbook )


fieldHold$diff <-  fieldHold$women -fieldHold$statbook

shapiro.test(fieldHold$diff )
qqnorm(fieldHold$diff ) 
qqline(fieldHold$diff )

fieldHold_x1  <- fieldHold["women"] 
fieldHold_x1[,"type"] <- "women"

fieldHold_x2  <- fieldHold["statbook"] 
fieldHold_x2[,"type"] <-  "statbook"

colnames(fieldHold_x1) <- c("happy_point"  ,"type")
colnames(fieldHold_x2) <- c("happy_point"  ,"type")

fieldHold_all <- rbind(fieldHold_x1, fieldHold_x2)




t.fieldHold_t<-t.test(fieldHold_all$happy_point ~ fieldHold_all$type, data = fieldHold_all , paired=TRUE)

t<-t.fieldHold_t$statistic[[1]]
df<-t.fieldHold_t$parameter[[1]]
r <- sqrt(t^2/(t^2+df))
round(r, 3)


