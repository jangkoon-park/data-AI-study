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

library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)


#----Install Packages-----
install.packages("corpcor")
install.packages("GPArotation")
install.packages("psych")
install.packages("pastecs")



#------And then load these packages, along with the boot package.-----

library(corpcor)
library(GPArotation)
library(psych)


# 데이터 생성
library(reshape2)
data <- data.frame(
  subject = factor(1:10),
  time1 = rnorm(10, 70, 5),
  time2 = rnorm(10, 75, 5),
  time3 = rnorm(10, 80, 5)
)

#------And then load these packages, along with the boot package.-----
setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/17장" 
#----------Smart Alex Task 1-----------------------
#load data
tossData<-read.delim("Tosse.r.dat", header = TRUE)

#create new dataset without missing data 
tossData.2<-na.omit(tossData)

#create a correlation matrix
tossMatrix<-cor(tossData.2)

#Bartlett's test
cortest.bartlett(tossData.2)


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

#KMO test
#To use the function (make sure you have executed the function from the book chapter first):
kmo(tossData.2)

#Determinent:
det(cor(tossData.2))


#PCA

#pcModel<-principal(dataframe/R-matrix, nfactors = number of factors, rotate = "method of rotation", scores = TRUE)

#On raw data
pc1 <-  principal(tossData.2, nfactors = 28, rotate = "none")

#Extract 5 factors:
pc2 <-  principal(tossData.2, nfactors = 5, rotate = "none")

#Scree plot:
plot(pc1$values, type = "b") 

#Oblique rotation on 5 factors:
pc3 <- principal(tossData.2, nfactors = 5, rotate = "oblimin")
print.psych(pc3, cut = 0.3, sort = TRUE)

#Oblique rotation on 3 factors:
pc4 <- principal(tossData.2, nfactors = 3, rotate = "oblimin")
print.psych(pc4, cut = 0.3, sort = TRUE)

#----------Smart Alex Task 2-----------------------
#load data
williamsData<-read.delim("Williams.dat", header = TRUE)

#create new dataset without missing data 
williamsData.2<-na.omit(williamsData)

#create a correlation matrix
williamsMatrix<-cor(williamsData.2)

#Bartlett's test
cortest.bartlett(williamsData.2)

#KMO test
#To use the function (make sure you have executed the function from the book chapter first):
kmo(williamsData.2)

#calculate the Determinent:
det(cor(williamsData.2))

#PCA

#pcModel
#On raw data, extract 5 factors, varimax rotation:
pc1 <-  principal(williamsData.2, nfactors = 5, rotate = "varimax")

#Scree plot:
plot(pc1$values, type = "b") 

#Pattern Matrix in a nice format:
print.psych(pc1, cut = 0.3, sort = TRUE)





