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
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/17장" 


#********************* RAQ Example ********************

#load data
raqData<-read.delim("raq.dat", header = TRUE)

#create a correlation matrix
raqMatrix<-cor(raqData)
round(raqMatrix, 2)
#break down the matrix to make it easier to put in the book
round(raqMatrix[,1:8], 2)
round(raqMatrix[,9:16], 2)
round(raqMatrix[,17:23], 2)

#Bartlett's test

cortest.bartlett(raqData)
cortest.bartlett(raqMatrix, n = 2571)

#KMO test
# KMO Kaiser-Meyer-Olkin Measure of Sampling Adequacy
# Function by G. Jay Kerns, Ph.D., Youngstown State University (http://tolstoy.newcastle.edu.au/R/e2/help/07/08/22816.html)

kmo = function( data ){
  library(MASS) 
  X <- cor(as.matrix(data)) 
  iX <- ginv(X) 
  S2 <- diag(diag((iX^-1)))
  AIS <- S2%*%iX%*%S2                      # anti-image covariance matrix
  IS <- X+AIS-2*S2                         # image covariance matrix
  Dai <- sqrt(diag(diag(AIS)))
  IR <- ginv(Dai)%*%IS%*%ginv(Dai)         # image correlation matrix
  AIR <- ginv(Dai)%*%AIS%*%ginv(Dai)       # anti-image correlation matrix
  a <- apply((AIR - diag(diag(AIR)))^2, 2, sum)
  AA <- sum(a) 
  b <- apply((X - diag(nrow(X)))^2, 2, sum)
  BB <- sum(b)
  MSA <- b/(b+a)                        # indiv. measures of sampling adequacy
  AIR <- AIR-diag(nrow(AIR))+diag(MSA)  # Examine the anti-image of the correlation matrix. That is the  negative of the partial correlations, partialling out all other variables.
  kmo <- BB/(AA+BB)                     # overall KMO statistic
  # Reporting the conclusion 
  if (kmo >= 0.00 && kmo < 0.50){test <- 'The KMO test yields a degree of common variance unacceptable for FA.'} 
  else if (kmo >= 0.50 && kmo < 0.60){test <- 'The KMO test yields a degree of common variance miserable.'} 
  else if (kmo >= 0.60 && kmo < 0.70){test <- 'The KMO test yields a degree of common variance mediocre.'} 
  else if (kmo >= 0.70 && kmo < 0.80){test <- 'The KMO test yields a degree of common variance middling.' } 
  else if (kmo >= 0.80 && kmo < 0.90){test <- 'The KMO test yields a degree of common variance meritorious.' }
  else { test <- 'The KMO test yields a degree of common variance marvelous.' }
  
  ans <- list( overall = kmo,
               report = test,
               individual = MSA,
               AIS = AIS,
               AIR = AIR )
  return(ans)
} 

#To use this function:
kmo(raqData)

#Determinent (execute one of these):
det(raqMatrix)
det(cor(raqData))

pc1 <-  principal(raqData, nfactors = 23, rotate = "none")
pc1 <-  principal(raqData, nfactors = length(raqData), rotate = "none")
plot(pc1$values, type = "b") 

pc2 <-  principal(raqData, nfactors = 4, rotate = "none")
plot(pc2$values, type = "b") 

#Explore residuals
factor.model(pc2$loadings)
reproduced<-round(factor.model(pc2$loadings), 3) #format for book
reproduced[,1:9]  #format for book

factor.residuals(raqMatrix, pc2$loadings) 
resids<-round(factor.residuals(raqMatrix, pc2$loadings), 3) #format for book
resids[,1:9] #format for book


pc2$fit.off


residuals<-factor.residuals(raqMatrix, pc2$loadings)
residuals<-as.matrix(residuals[upper.tri(residuals)])
large.resid<-abs(residuals) > 0.05
sum(large.resid)
sum(large.resid)/nrow(residuals)
sqrt(mean(residuals^2))
hist(residuals)




residual.stats<-function(matrix){
  residuals<-as.matrix(matrix[upper.tri(matrix)])
  large.resid<-abs(residuals) > 0.05
  numberLargeResids<-sum(large.resid)
  propLargeResid<-numberLargeResids/nrow(residuals)
  rmsr<-sqrt(mean(residuals^2))
  
  cat("Root means squared residual = ", rmsr, "\n")
  cat("Number of absolute residuals > 0.05 = ", numberLargeResids, "\n")
  cat("Proportion of absolute residuals > 0.05 = ", propLargeResid, "\n")
  hist(residuals)
}

resids <- factor.residuals(raqMatrix, pc2$loadings )
residual.stats(resids)
residual.stats(factor.residuals(raqMatrix, pc2$loadings))


pc3 <-  principal(raqData, nfactors = 4, rotate = "varimax")
print.psych(pc3, cut = 0.3, sort = TRUE)


pc4 <- principal(raqData, nfactors = 4, rotate = "oblimin")
print.psych(pc4, cut = 0.3, sort = TRUE)
pc4$loadings%*%pc4$Phi


factor.structure <- function(fa, cut = 0.2, decimals = 2){
  structure.matrix <- fa.sort(fa$loadings %*% fa$Phi)
  structure.matrix <- data.frame(ifelse(abs(structure.matrix) < cut, "", round(structure.matrix, decimals)))
  return(structure.matrix)
}


factor.structure(pc4, cut = 0.3)


pc5 <- principal(raqData, nfactors = 4, rotate = "oblimin", scores = TRUE)
pc5$scores
head(pc5$scores, 10)
raqData <- cbind(raqData, pc5$scores)


cor(pc5$scores)
round(cor(pc5$scores), 2)

#self test
round(cor(pc5$scores, raqData$Q01),2)
round(cor(pc5$scores, raqData$Q06),2)
round(cor(pc5$scores, raqData$Q18),2)

#On an R matrix

#Reliability analysis

computerFear<-raqData[,c(6, 7, 10, 13, 14, 15, 18)]
statisticsFear <- raqData[, c(1, 3, 4, 5, 12, 16, 20, 21)]
mathFear <- raqData[, c(8, 11, 17)]
peerEvaluation <- raqData[, c(2, 9, 19, 22, 23)]


alpha(computerFear)
alpha(statisticsFear, keys = c(1, -1, 1, 1, 1, 1, 1, 1))
alpha(mathFear)
alpha(peerEvaluation)
alpha(statisticsFear) #for illustrative pruposes

#load data
internetData<-read.delim("Nichols & Nicki (2004).dat", header = TRUE)

internetMatrix<-cor(internetData)
round(internetMatrix, 2)

round(internetMatrix[,1:12], 2)
round(internetMatrix[,13:24], 2)
round(internetMatrix[,25:36], 2)

library(pastecs)

round(stat.desc(internetMatrix),2)

internetDescriptives<-stat.desc(internetData)
round(internetDescriptives,2)
# install.packages("gdata")
library(gdata)


internetData.2<-remove.vars(internetData, c("ias13", "ias22", "ias32", "ias23", "ias34"))

##############연습 문제 1

#Bartlett's test
cortest.bartlett(internetData.2)

#KMO test
#To use the function (make sure you have executed the function from the book chapter first):
kmo(internetData.2)

#Determinent:
det(cor(internetData.2))

#On raw data
pc1 <-  principal(internetData.2, nfactors = 31, rotate = "none")
pc1 <-  principal(internetData.2, nfactors = length(internetData.2), rotate = "none")
plot(pc1$values, type = "b") 

pc2 <-  principal(internetData.2, nfactors = 5, rotate = "none")

print.psych(pc2, cut = 0.3, sort = TRUE)


##############연습 문제 2

#load data
williamsData<-read.delim("Williams.dat", header = TRUE)

#create new dataset without missing data 
williamsData.2<-na.omit(williamsData)
# williamsData.2$sex <- ifelse(williamsData.2$sex == "female", 0, 1)
williamsData.2$sex <- NULL
williamsData.2$age  <- NULL
williamsData.2$subject  <- NULL
#create a correlation matrix
williamsMatrix<-cor(williamsData.2)

#Bartlett's test
cortest.bartlett(williamsData.2)
kmo(williamsData.2)
det(cor(williamsData.2))

#pcModel
#On raw data, extract 5 factors, varimax rotation:
pc1 <-  principal(williamsData.2, nfactors = 5, rotate = "varimax")

#Scree plot:
plot(pc1$values, type = "b") 

#Pattern Matrix in a nice format:
print.psych(pc1, cut = 0.3, sort = TRUE)




