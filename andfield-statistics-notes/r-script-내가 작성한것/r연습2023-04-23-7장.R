# install.packages("QuantPsyc")
# install.packages("car")
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


setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/8장/"



library(QuantPsyc)
library(car)
library(boot)
library(Rcmdr)


album1<-read.delim("Album Sales 1.dat", header = TRUE)

#----run the simple linear regression model---
albumSales.1 <- lm(sales ~ adverts, data = album1)
summary(albumSales.1)
sqrt(0.3346)


#----access the album2 data----
album2<-read.delim("Album Sales 2.dat", header = TRUE)
album2

#---Run the multiple regression model----
albumSales.2<-lm(sales ~ adverts, data = album2)
albumSales.3<-lm(sales ~ adverts + airplay + attract, data = album2)
summary(albumSales.2)
summary(albumSales.3)


#---We can obtain standardized parameter estimates with the lm.beta() function---
lm.beta(albumSales.3)
#---Confidence intervals are obtained with the confint() function----
confint(albumSales.3)


anova(albumSales.2, albumSales.3)



album2$residuals<-resid(albumSales.3)
album2$standardized.residuals <- rstandard(albumSales.3)
album2$studentized.residuals <- rstudent(albumSales.3)
album2$cooks.distance<-cooks.distance(albumSales.3)
album2$dfbeta <- dfbeta(albumSales.3)
album2$dffit <- dffits(albumSales.3)
album2$leverage <- hatvalues(albumSales.3)
album2$covariance.ratios <- covratio(albumSales.3)

album2

write.table(album2, "Album Sales With Diagnostics.dat", sep = "\t", row.names = FALSE)
#look at the data (and round the values)
round(album2, digits = 3)




#----List of standardized residuals greater than 2--------------
album2$standardized.residuals>2| album2$standardized.residuals < -2

#---Create a variable called large.residual, which is TRUE (or 1) if the residual is greater than 2, or less than -2.----------
album2$large.residual <- album2$standardized.residuals > 2 | album2$standardized.residuals < -2

#---Count the number of large residuals-------------
sum(album2$large.residual)



album2[album2$large.residual,c("sales", "airplay", "attract", "adverts", "standardized.residuals")]


album2[album2$large.residual , c("cooks.distance", "leverage", "covariance.ratios")]


durbinWatsonTest(albumSales.3)


dwt(albumSales.3)


album2$fitted <- albumSales.3$fitted.values

# album2 데이터셋을 사용하여 히스토그램을 생성합니다.
histogram <- ggplot(album2, aes(studentized.residuals)) +
  geom_histogram(aes(y = ..density..), colour = "black", fill = "white") +
  labs(x = "Studentized Residual", y = "Density") +
  theme(legend.position = "none")

# 히스토그램 위에 정규분포 곡선을 추가합니다.
histogram + stat_function(
  fun = dnorm,
  args = list(mean = mean(album2$studentized.residuals, na.rm = TRUE),
              sd = sd(album2$studentized.residuals, na.rm = TRUE)),
  colour = "red",
  size = 1
)

# 그래프를 이미지 파일로 저장합니다.
ggsave(file = paste(imageDirectory, "07 album sales ggplot Hist.png", sep = "/"))


# album2 데이터셋의 studentized.residuals를 사용하여 QQ plot을 생성합니다.
qqplot.resid <- ggplot(album2, aes(sample = studentized.residuals)) +
  stat_qq() +
  labs(x = "Theoretical Values", y = "Observed Values")

# 생성한 QQ plot을 출력합니다.
print(qqplot.resid)

scatter <- ggplot(album2, aes(fitted, studentized.residuals))
scatter + geom_point() + geom_smooth(method = "lm", colour = "Red")+ labs(x = "Fitted Values", y = "Studentized Residual") 
ggsave(file=paste(imageDirectory,"07 Album sales ggplot scatter.png",sep="/"))


bootReg<-function(formula, data, i)
{
  d <- data[i,]
  fit <- lm(formula, data = d)
  return(coef(fit))
}

#------연습문제----------------------1번 

bootResults<-boot(statistic = bootReg, formula = sales ~ adverts + airplay + attract, data = album2, R = 2000,)


boot.ci(bootResults, type = "bca", index = 1)

#---And the three slope estimates---
boot.ci(bootResults, type = "bca", index = 2)
boot.ci(bootResults, type = "bca", index = 3)
boot.ci(bootResults, type = "bca", index = 4)


pubs<-read.delim("pubs.dat", header = TRUE)
pubs

pubsReg <-lm(mortality ~ pubs, data = pubs)
summary(pubsReg)
confint(pubsReg)

pubReg<-function(formula, data, i)
{
  d <- data[i,]
  fit <- lm(formula, data = d)
  return(coef(fit))
}

#obtain output of the regression:


pubsResults<-boot(statistic = pubReg, formula = mortality ~ pubs, data = pubs, R = 2000,)


boot.ci(pubsResults, type = "bca", index = 1)
boot.ci(pubsResults, type = "bca", index = 2)

#------연습문제----------------------2번 




Supermodel<-read.delim("Supermodel.dat", header = TRUE)
Supermodel
#----create a regression model to predict salery from Age, number of years being a Supermodel and beauty-----
Supermodel.1 <- lm(salary ~ age + beauty + years, data= Supermodel)
summary(Supermodel.1)


Supermodel.2 <- lm(salary ~  age +  years, data= Supermodel)
summary(Supermodel.2)


lm.beta(Supermodel.1)
lm.beta(Supermodel.2)

#변수들의 상관관계를 나타냄
vif(Supermodel.1)
1/vif(Supermodel.1)

#잔차들간의 상관 관계를 나타냄
dwt(Supermodel.1)

#vif(Supermodel.1) 와 dwt(Supermodel.1) 차이

resid(Supermodel.1)
rstandard(Supermodel.1)


vif(Supermodel.2)
1/vif(Supermodel.2)
dwt(Supermodel.2)
resid(Supermodel.2)
rstandard(Supermodel.2)


hist(rstandard(Supermodel.1))


#----Histogram-----
hist(rstandard(Supermodel.1))

Supermodel.1 <- lm(salary ~ age + beauty + years, data= Supermodel)
##---Plot of the standardized residuals----- 
plot(Supermodel.1$fitted.values,rstandard(Supermodel.1))


Supermodel.1 <- lm(salary ~ age + beauty + years, data= Supermodel)

# 적합된 값과 표준화 잔차 그래프
plot(Supermodel.1$fitted.values, rstandard(Supermodel.1))


abline(0,0)
plot(Supermodel.1)

Supermodel$cooks.distance<-cooks.distance(Supermodel.1)
Supermodel$residuals<-resid(Supermodel.1)
Supermodel$standardized.residuals <- rstandard(Supermodel.1)
Supermodel$studentized.residuals <- rstudent(Supermodel.1)
Supermodel$dfbeta <- dfbeta(Supermodel.1)
Supermodel$dffit <- dffits(Supermodel.1)
Supermodel$leverage <- hatvalues(Supermodel.1)
Supermodel$covariance.ratios <- covratio(Supermodel.1)



Supermodel$standardized.residuals>2| Supermodel$standardized.residuals < -2
Supermodel$large.residual <- Supermodel$standardized.residuals > 2| Supermodel$standardized.residuals < -2
sum(Supermodel$large.residual)


Supermodel[,c("salary", "age", "beauty", "years", "standardized.residuals")]



Supermodel[Supermodel$large.residual,c("salary", "age", "beauty", "years", "standardized.residuals")]




qqplot.resid <- ggplot(Supermodel, aes(sample = studentized.residuals)) +
  geom_qq() +
  stat_qq() +  # 선형 모델을 추가하기 위해 stat_qq() 함수 사용
  stat_qq_line() +  # 선형 모델의 직선을 추가하기 위해 stat_qq_line() 함수 사용
  labs(x = "Theoretical Values", y = "standardized.residuals")
qqplot.resid
#------연습문제----------------------3번 
rm(gfr)
gfr<-read.delim("GlastonburyFestivalRegression.dat", header=TRUE)
gfr

gfr$crusty<-gfr$music=="Crusty"
gfr$metaller<-gfr$music=="Metaller"
gfr$indie.kid<-gfr$music=="Indie Kid"

library(dplyr)
gfr <- subset(gfr, !is.na(change)) 
gfr
gfr.1 <- lm(gfr$change ~ gfr$crusty + gfr$metaller + gfr$indie.kid, data=gfr)
summary(gfr.1)



nrow(gfr)



vif(gfr.1)
1/vif(gfr.1)


dwt(gfr.1)


hist(rstandard(gfr.1))

##---Plot of the standardized residuals----- 
plot(gfr.1$fitted.values,rstandard(gfr.1))



abline(0,0)

#To obtain some other plots, we can use the plot() function:
plot(gfr.1)



gfr$cooks.distance<-cooks.distance(gfr.1)
gfr$residuals<-resid(gfr.1)
gfr$standardized.residuals<-rstandard(gfr.1)
gfr$studentized.residuals<-rstudent(gfr.1)
gfr$dfbeta<-dfbeta(gfr.1)
gfr$dffit<-dffits(gfr.1)
gfr$leverage<-hatvalues(gfr.1)
gfr$covariance.ratios<-covratio(gfr.1)

hist(rstandard(gfr.1))


gfr


qqplot.resid <- ggplot(gfr, aes(sample = studentized.residuals)) +
  geom_qq() +
  stat_qq() +  # 선형 모델을 추가하기 위해 stat_qq() 함수 사용
  stat_qq_line() +  # 선형 모델의 직선을 추가하기 위해 stat_qq_line() 함수 사용
  labs(x = "Theoretical Values", y = "standardized.residuals")
qqplot.resid

gfr$large.cooks.distance <-gfr$cooks.distance>1
sum(gfr$large.cooks.distanc)

gfr$standardized.residuals>2| gfr$standardized.residuals < -2
gfr$large.residual <- gfr$standardized.residuals > 2| gfr$standardized.residuals < -2
sum(gfr$large.residual)

#------연습문제----------------------4번 
rm(ChildAggression)

ChildAggression<-read.delim("ChildAggression.dat", header = TRUE)
nrow(ChildAggression)
ChildAggression
ChildAggression.1<-lm(Aggression ~ Sibling_Aggression + Parenting_Style, data = ChildAggression)

ChildAggression.2<-lm(Aggression ~ Sibling_Aggression+Parenting_Style+ Diet + Computer_Games + Television, data=ChildAggression)

ChildAggression.3<-lm(Aggression ~ Sibling_Aggression+Parenting_Style+ Diet + Computer_Games , data=ChildAggression)

summary(ChildAggression.1)
summary(ChildAggression.2)



vif(ChildAggression.1)
vif(ChildAggression.2)
dwt((ChildAggression.1))
dwt((ChildAggression.2))

anova(ChildAggression.1, ChildAggression.2)



ChildAggression$cooks.distance<-cooks.distance(ChildAggression.1)
ChildAggression$residuals<-resid(ChildAggression.1)
ChildAggression$standardized.residuals <- rstandard(ChildAggression.1)
ChildAggression$studentized.residuals <- rstudent(ChildAggression.1)
ChildAggression$dfbeta <- dfbeta(ChildAggression.1)
ChildAggression$dffit <- dffits(ChildAggression.1)
ChildAggression$leverage <- hatvalues(ChildAggression.1)
ChildAggression$covariance.ratios <- covratio(ChildAggression.1)

ChildAggression$large.cooks.distance <-ChildAggression$cooks.distance>1
sum(ChildAggression$large.cooks.distanc)

ChildAggression$cooks.distance<-cooks.distance(ChildAggression.2)
ChildAggression$residuals<-resid(ChildAggression.2)
ChildAggression$standardized.residuals <- rstandard(ChildAggression.2)
ChildAggression$studentized.residuals <- rstudent(ChildAggression.2)
ChildAggression$dfbeta <- dfbeta(ChildAggression.2)
ChildAggression$dffit <- dffits(ChildAggression.2)
ChildAggression$leverage <- hatvalues(ChildAggression.2)
ChildAggression$covariance.ratios <- covratio(ChildAggression.2)


ChildAggression$large.cooks.distance <-ChildAggression$cooks.distance>1
sum(ChildAggression$large.cooks.distanc)

ChildAggression$standardized.residuals>2| ChildAggression$standardized.residuals < -2
ChildAggression$large.residual <- ChildAggression$standardized.residuals > 2| ChildAggression$standardized.residuals < -2
sum(ChildAggression$large.residual)


hist(rstandard(ChildAggression.2))


qqplot.resid <- ggplot(ChildAggression, aes(sample = studentized.residuals)) +
  geom_qq() +
  stat_qq() +  # 선형 모델을 추가하기 위해 stat_qq() 함수 사용
  stat_qq_line() +  # 선형 모델의 직선을 추가하기 위해 stat_qq_line() 함수 사용
  labs(x = "Theoretical Values", y = "standardized.residuals")
qqplot.resid



#-----If we want to display only some of the variables we can use:----


nrow(ChildAggression[,c("Aggression", "Sibling_Aggression","Parenting_Style","Diet","Computer_Games", "Television", "standardized.residuals")])
#---Display the value of Aggression, Parenting_Style, Diet, Computer_Games and Television and the standardized residual, for those cases which have a residual greater than 2 or less than -2.-------------


nrow(ChildAggression[ChildAggression$large.residual,c("Aggression", "Sibling_Aggression","Parenting_Style","Diet","Computer_Games", "Television", "standardized.residuals")])
ChildAggression[ChildAggression$large.residual,c("Aggression", "Sibling_Aggression","Parenting_Style","Diet","Computer_Games", "Television", "standardized.residuals")]


plot(ChildAggression.2$fitted.values,rstandard(ChildAggression.2))

