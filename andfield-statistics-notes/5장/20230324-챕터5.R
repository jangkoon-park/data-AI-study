# select * From epmployees

setwd("C:/Users/CJ/Documents/앤드필드/5장")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/데이터"

install.packages("car")
install.packages("ggplot2")
install.packages("pastecs")
install.packages("psych")

library(car)
library(ggplot2)
library(pastecs)
library(psych)
# library(Rcmdr)

averts <- c(5,4,4,6,8)
packets <- c(8,9,10,13,15)

avertData <- data.frame(averts,packets)

hist.avertData <- ggplot(avertData, aes(averts)) +  
  geom_histogram(aes(y=..packets..), colour="black", fill="white") + 
  labs(x="시청한 광고 수", y = "구매한 사탕봉지 수") +
  theme(legend.position = "none")

hist.avertData


