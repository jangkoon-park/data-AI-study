# install.packages("car")
# install.packages("ggplot2")
# install.packages("pastecs")
# install.packages("psych")
install.packages("Rcmdr")

library(car)
library(ggplot2)
library(pastecs)
library(psych) 

# library(Rcmdr)


imageDirectory<-"C:/Users/CJ/Documents/앤드필드/데이터"


dlf <- read.delim("C:/Users/CJ/Documents/앤드필드/데이터/DownloadFestival.dat", header=TRUE)

#Remove the outlier from the day1 hygiene score
dlf$day1 <- ifelse(dlf$day1 > 20, NA, dlf$day1)



#Histograms for hygiene scores on day 1, day 2 and day 3.

#Histogram for day 1:


hist.day1 <- ggplot(dlf, aes(day1)) +
  theme(legend.position = "none") +
  geom_histogram(aes(y=..density..), colour="black", fill="white") +
  labs(x="Hygiene score on day 1", y = "Density")

hist.day1

hist.day2 <- ggplot(dlf, aes(day2)) +
  theme(legend.position = "none") +
  geom_histogram(aes(y=..density..), colour="black", fill="white") +
  labs(x="Hygiene score on day 1", y = "Density")

hist.day2

#Histogram for day 3:
hist.day3 <- ggplot(dlf, aes(day3)) +
  theme(legend.position = "none") +
  geom_histogram(aes(y=..density..), colour="black", fill="white") +
  labs(x="Hygiene score on day 1", y = "Density")

hist.day3

#Add the curves to the Histograms:

hist.day1 + stat_function(fun = dnorm, args = list(mean = mean(dlf$day1, na.rm = TRUE), sd = sd(dlf$day1, na.rm = TRUE)), colour = "black", size = 1)

ggsave(file = paste(imageDirectory,"05 DLF Day 1 Hist.png",sep="/"))

hist.day2 + stat_function(fun = dnorm, args = list(mean = mean(dlf$day2, na.rm = TRUE), sd = sd(dlf$day2, na.rm = TRUE)), colour = "black", size = 1)
  
  ggsave(file = paste(imageDirectory,"05 DLF Day 2 Hist.png",sep="/"))


hist.day3 + stat_function(fun = dnorm, args = list(mean = mean(dlf$day3, na.rm = TRUE), sd = sd(dlf$day3, na.rm = TRUE)), colour = "black", size = 1)

ggsave(file = paste(imageDirectory,"05 DLF Day 3 Hist.png",sep="/"))


#Q-Q plot for day 1:
# qqplot.day1 <- qplot(sample = dlf$day1, stat="qq")
# qqplot.day1

qqplot.day1 <- ggplot(dlf, aes(sample = day1)) +
  stat_qq() +
  labs(x="Theoretical Quantiles", y = "Sample Quantiles")

qqplot.day1


ggsave(file = paste(imageDirectory,"05 DLF Day 1 QQ.png",sep="/"))

#Q-Q plot for day 2:

qqplot.day2 <- ggplot(dlf, aes(sample = day2)) +
  stat_qq() +
  labs(x="Theoretical Quantiles", y = "Sample Quantiles")
qqplot.day2


ggsave(file = paste(imageDirectory,"05 DLF Day 2 QQ.png",sep="/"))

#Q-Q plot of the hygiene scores on day 3:
qqplot.day3 <- ggplot(dlf, aes(sample = day3)) +
  stat_qq() +
  labs(x="Theoretical Quantiles", y = "Sample Quantiles")
qqplot.day3

ggsave(file = paste(imageDirectory,"05 DLF Day 3 QQ.png",sep="/"))


describe(dlf$day1)
describe(cbind(dlf$day1, dlf$day2, dlf$day3))
describe(dlf[,c("day1", "day2", "day3")])

library(pastecs)
stat.desc(dlf$day1, basic = FALSE, norm = FALSE)
stat.desc(cbind(dlf$day1, dlf$day2, dlf$day3), basic = TRUE, norm = TRUE)
round(stat.desc(dlf[, c("day1", "day2", "day3")], basic = FALSE, norm = TRUE), digits = 3)
