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


# install.packages("car")
# install.packages("effects")
# install.packages("compute.es")
# install.packages("multcomp")
# install.packages("pastecs")
# # install.packages("WRS", repos="http://R-Forge.R-project.org")
# # install.packages("reshape")
#  install.packages("ancova")
#Initiate packages
library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)
# library(ancova)
# library(WRS)
# library(reshape)

# 
# install.packages("corpcor")
# install.packages("GPArotation")
# install.packages("psych")
# install.packages("pastecs")
# 
# install.packages("melt")

# install.packages("ancova")

# 데이터 생성
library(reshape2)
data <- data.frame(
  subject = factor(1:10),
  time1 = rnorm(10, 70, 5),
  time2 = rnorm(10, 75, 5),
  time3 = rnorm(10, 80, 5)
)

# 데이터를 long 형식으로 변환
data_long <- melt(data, id.vars = "subject", variable.name = "time", value.name = "score")


repeated_measures_anova <- aov(score ~ time + Error(subject/time), data = data_long)
summary(repeated_measures_anova)

# 데이터를 long 형식으로 변환
data_long <- melt(data, id.vars = "subject", variable.name = "time", value.name = "score")


#------And then load these packages, along with the boot package.-----

setwd("C:/Users/CJ/Documents/앤드필드/데이터")
imageDirectory<-"C:/Users/CJ/Documents/앤드필드/12장" 


#-------Smart Alex Task 1-----

#Read in the data:
mixedAttitude<-read.delim("MixedAttitude.dat", header = TRUE)

#Set gender to be a factor:

mixedAttitude$gender<-factor(mixedAttitude$gender, levels = c(1:2), labels = c("Male", "Female"))

attitudeLong<-melt(mixedAttitude, id = c("Participant", "gender"), measured = c("beerpos", "beerneg", "beerneut", "winepos", "wineneg", "wineneut", "waterpos", "waterneg", "waterneu") )

names(attitudeLong)<-c("Participant", "Gender", "Groups", "Drink_Rating")

attitudeLong$Drink<-gl(3, 60, labels = c("Beer", "Wine", "Water"))
attitudeLong$Imagery<-gl(3, 20, 180, labels = c("Positive", "Negative", "Neutral"))


attitudeLong<-attitudeLong[order(attitudeLong$Participant),]

#Exploring Data

attitudeBoxplot <- ggplot(attitudeLong, aes(x = Drink, y = Drink_Rating, colour = Imagery)) +
  geom_boxplot() +
  labs(x = "Drink", y = "Mean Drink Rating", colour = "Imagery") +
  facet_wrap(~Gender)

attitudeBoxplot

#Descriptives

by(attitudeLong$Drink_Rating, list(attitudeLong$Drink, attitudeLong$Imagery, attitudeLong$Gender), stat.desc, basic = FALSE)

#using ezAnova:

NeutvsPosandNeg<-c(1, 1, -2)
PosvsNeg<-c(1, -1, 0)

contrasts(attitudeLong$Imagery)<-cbind(NeutvsPosandNeg, PosvsNeg)

WatervsBeerandWine<-c(1, 1, -2)
BeervsWine<-c(1, -1, 0)

contrasts(attitudeLong$Drink)<-cbind(WatervsBeerandWine, BeervsWine)


attitudeModel<-ezANOVA(data = attitudeLong, dv = .(Drink_Rating), wid = .(Participant),  between = .(Gender), within = .(Drink, Imagery), type = 3, detailed = TRUE)

attitudeModel

genderBar <- ggplot(attitudeLong, aes(Gender, Drink_Rating))
genderBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Gender", y = "Mean Rating of Drink") + scale_y_continuous(limits = c(-25,25)) 


GenderDrink <- ggplot(attitudeLong, aes(Drink, Drink_Rating, colour = Gender))
GenderDrink + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Type of Drink", y = "Mean Rating of Drink", colour = "Gender") + scale_y_continuous(limits = c(-25,25)) 


GenderImagery <- ggplot(attitudeLong, aes(Imagery, Drink_Rating, colour = Gender))
GenderImagery + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Type of Imagery", y = "Mean Rating of Drink", colour = "Gender") + scale_y_continuous(limits = c(-25,25)) 


GenderDrinkImagery <- ggplot(attitudeLong, aes(Drink, Drink_Rating, colour = Imagery))
GenderDrinkImagery + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Imagery)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Type of Drink", y = "Mean Rating of Drink", colour = "Type of Imagery") + scale_y_continuous(limits = c(-20,30)) + facet_wrap(~Gender)
-----#Using lme:
  
  PosvsNeut<-c(1, 0, 0)
NegvsNeut<-c(0, 1, 0)

contrasts(attitudeLong$Imagery)<-cbind(PosvsNeut, NegvsNeut)


BeervsWater<-c(1, 0, 0)
WinevsWater<-c(0, 1, 0)

contrasts(attitudeLong$Drink)<-cbind(BeervsWater, WinevsWater)

contrasts(attitudeLong$Gender)<-c(1, 0)


#Building the model

baseline<-lme(Drink_Rating ~ 1, random = ~1|Participant/Drink/Imagery, data = attitudeLong, method = "ML")
ImageryM<-update(baseline, .~. + Imagery)
DrinkM<-update(ImageryM, .~. + Drink)
GenderM<-update(DrinkM, .~. + Gender)
Imagery_Gender<-update(GenderM, .~. + Imagery:Gender)
Drink_Gender<-update(Imagery_Gender, .~. + Drink:Gender)
Imagery_Drink<-update(Drink_Gender, .~. + Imagery:Drink)
attitudeModel<-update(Imagery_Drink, .~. + Imagery:Drink:Gender)


anova(baseline, ImageryM, DrinkM, GenderM, Imagery_Gender, Drink_Gender, Imagery_Drink, attitudeModel)


summary(attitudeModel)

#-------Effect Sizes

rcontrast<-function(t, df)
{r<-sqrt(t^2/(t^2 + df))
print(paste("r = ", r))
}


rcontrast(-1.779832, 108)
rcontrast(1.855570, 108)
rcontrast(-0.170409, 108)
rcontrast(-1.704095, 108)




#-------Smart Alex Task 2-----


#Read in the data:
textMessages<-read.delim("Textmessages.dat", header = TRUE)

#Set Group to be a factor:

textMessages$Group<-factor(textMessages$Group, levels = c("Text Messagers":2), labels = c("Text Messagers", "Controls"))

textLong<-melt(textMessages, id = c("Participant", "Group"), measured = c("Baseline", "Six_months") )

names(textLong)<-c("Participant", "Group", "Time", "Grammar_Score")

textLong<-textLong[order(textLong$Participant),]

#Exploring Data

#Line graph:

textLine <- ggplot(textLong, aes(Time, Grammar_Score, colour = Group))
textLine + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Group)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Time", y = "Mean Grammar Score", colour = "Group")


#Descriptives

by(textLong$Grammar_Score, list(textLong$Time, textLong$Group), stat.desc, basic = FALSE)

#using ezAnova:

textModel<-ezANOVA(data = textLong, dv = .(Grammar_Score), wid = .(Participant),  between = .(Group), within = .(Time), type = 3, detailed = TRUE)

textModel

TimeBar <- ggplot(textLong, aes(Time, Grammar_Score))
TimeBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Time", y = "Mean Grammar Score")  

GroupBar <- ggplot(textLong, aes(Group, Grammar_Score))
GroupBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Group", y = "Mean Grammar Score")  


-----#Using lme:
  
  #Building the model
  
  baseline<-lme(Grammar_Score ~ 1, random = ~1|Participant/Time/Group, data = textLong, method = "ML")
TimeM<-update(baseline, .~. + Time)
GroupM<-update(TimeM, .~. + Group)
textModel<-update(GroupM, .~. + Time:Group)


anova(baseline, TimeM, GroupM, textModel)


summary(textModel)

#-------Effect Sizes

rcontrast(2.041172  , 48)




#-------Smart Alex Task 3-----
#Read in the data:
bigBrother<-read.delim("BigBrother.dat", header = TRUE)

#Set bb to be a factor:

bigBrother$bb<-factor(bigBrother$bb, levels = c(0:1), labels = c("No Treatment Control", "Big Brother Contestant"))

brotherLong<-melt(bigBrother, id = c("Participant", "bb"), measured = c("time1", "time2") )

names(brotherLong)<-c("Participant", "Group", "Time", "Personality_Score")

brotherLong<-brotherLong[order(brotherLong$Participant),]

#Exploring Data

#Line graph:

PersonalityTime <- ggplot(brotherLong, aes(Time, Personality_Score, colour = Group))
PersonalityTime + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Group)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Time", y = "Mean Personality Score (%)", colour = "Group") 

#Descriptives

by(brotherLong$Personality_Score, list(brotherLong$Time, brotherLong$Group), stat.desc, basic = FALSE)

#using ezAnova:

brotherModel<-ezANOVA(data = brotherLong, dv = .(Personality_Score), wid = .(Participant),  between = .(Group), within = .(Time), type = 3, detailed = TRUE)

brotherModel

TimeBar <- ggplot(brotherLong, aes(Time, Personality_Score))
TimeBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Time", y = "Mean Personality Score") 

GroupBar <- ggplot(brotherLong, aes(Group, Personality_Score))
GroupBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Group", y = "Mean Personality Score")  


-----#Using lme:
  
  #Building the model
  
  baseline<-lme(Personality_Score ~ 1, random = ~1|Participant/Time/Group, data = brotherLong, method = "ML")
TimeM<-update(baseline, .~. + Time)
GroupM<-update(TimeM, .~. + Group)
brotherModel<-update(GroupM, .~. + Time:Group)


anova(baseline, TimeM, GroupM, brotherModel)


summary(brotherModel)

#-------Effect Sizes

rcontrast(2.673718, 48)

#-------Smart Alex Task 4-----

pictureData<-read.delim("ProfilePicture.dat", header = TRUE)

pictureLong<-melt(pictureData, id = c("case", "relationship_status"), measured = c("couple", "alone") )

names(pictureLong)<-c("Case", "Relationship_Status", "Photo", "Friend_Requests")


pictureLong<-pictureLong[order(pictureLong$Case),]

#Exploring Data

#Line graph:

profileLine <- ggplot(pictureLong, aes(Relationship_Status, Friend_Requests, colour = Photo))
profileLine + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, geom = "line", aes(group= Photo)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2) + labs(x = "Relationship Status", y = "Mean Number of Friend Requests", colour = "photo")


#Descriptives

by(pictureLong$Friend_Requests, list(pictureLong$Relationship_Status, pictureLong$Photo), stat.desc, basic = FALSE)

#using ezAnova:

pictureModel<-ezANOVA(data = pictureLong, dv = .(Friend_Requests), wid = .(Case),  between = .(Relationship_Status), within = .(Photo), type = 3, detailed = TRUE)

pictureModel

PhotoBar <- ggplot(pictureLong, aes(Photo, Friend_Requests))
PhotoBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Photo", y = "Mean Number of Friends")  

RelationshipBar <- ggplot(pictureLong, aes(Relationship_Status, Friend_Requests))
RelationshipBar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_boot, geom = "pointrange") + labs(x = "Relationship_Status", y = "Mean Number of Friends")  


-----#Using lme:
  
  #Building the model
  
  baseline<-lme(Friend_Requests ~ 1, random = ~1|Case/Relationship_Status/Photo, data = pictureLong, method = "ML")
RelationshipM<-update(baseline, .~. + Relationship_Status)
PhotoM<-update(RelationshipM, .~. + Photo)
pictureModel<-update(PhotoM, .~. + Relationship_Status:Photo)


anova(baseline, RelationshipM, PhotoM, pictureModel)


summary(pictureModel)

#-------Effect Sizes

rcontrast(2.722811, 38)




