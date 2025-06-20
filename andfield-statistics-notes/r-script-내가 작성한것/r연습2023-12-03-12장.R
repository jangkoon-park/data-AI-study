# install.packages("car")
# install.packages("effects")
# install.packages("compute.es")
# install.packages("multcomp")
# install.packages("pastecs")
# install.packages("WRS", repos="http://R-Forge.R-project.org")
# install.packages("reshape")

#Initiate packages
library(car)
library(compute.es)
library(effects)
library(ggplot2)
library(multcomp)
library(pastecs)
library(WRS)
library(reshape)

#Installing the WRS package from R-Forge:
# Step 1: Install dependent packages:
# install.packages(c("MASS", "akima", "robustbase"))
#Step 2: Install suggested packages:
# install.packages(c("cobs", "robust", "mgcv", "scatterplot3d", "quantreg", "rrcov", "lars", "pwr", "trimcluster", "parallel", "mc2d", "psych", "Rfit"))
#Step 3: install WRS:
# install.packages("WRS", repos="http://R-Forge.R-project.org", type="source")

# source("http://www-rcf.usc.edu/~rwilcox/Rallfun-v14")

setwd("C:/Users/Owner/Documents/앤드필드_R/앤디필디_모든데이터나_예제_시험문제 모음/앤디필드_데이터/Data files")

imageDirectory<-"C:/Users/Owner/Documents/앤드필드_R/"  

gogglesData<-read.csv("goggles.csv", header = TRUE)



gogglesReg<-read.delim("GogglesRegression.dat", header = TRUE)


gogglesRegModel<-lm(attractiveness ~ gender + alcohol + interaction, data = gogglesReg)
summary(gogglesRegModel)
summary.lm(gogglesRegModel)



#--------Beer Goggles data----------
gogglesData<-read.csv("goggles.csv", header = TRUE)
gogglesData$alcohol<-factor(gogglesData$alcohol, levels = c("None", "2 Pints", "4 Pints"))

id<-(1:48)
gender<-gl(2, 24, labels = c("Female", "Male"))
alcohol<-gl(3, 8, 48, labels = c("None", "2 Pints", "4 Pints"))
attractiveness<-c(65,70,60,60,60,55,60,55,70,65,60,70,65,60,60,50,55,65,70,55,55,60,50,50,50,55,80,65,70,75,75,65,45,60,85,65,70,70,80,60,30,30,30,55,35,20,45,40)

gogglesData<-data.frame(gender, alcohol, attractiveness)

gogglesData$alcohol<-factor(gogglesData$alcohol, levels = c("None", "2 Pints", "4 Pints"))

# gogglesFemale<-subset(gogglesData, gender=="Male",)
# gogglesMale<-subset(gogglesData, gender=="Female",)

line <- ggplot(gogglesData, aes(alcohol, attractiveness, colour = gender))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4) + stat_summary(fun.y = mean, geom = "point", size = 3) + labs(x = "알콜 섭취량", y = "대화 상대의 매력 점수")

boxplot <- ggplot(gogglesData, aes(alcohol, attractiveness))
boxplot + geom_boxplot() + facet_wrap(~gender) + labs(x = "Alcohol Consumption", y = "Mean Attractiveness of Date (%)")


#Self Test
by(gogglesData$attractiveness, gogglesData$gender, stat.desc)
by(gogglesData$attractiveness, gogglesData$alcohol, stat.desc)
by(gogglesData$attractiveness, list(gogglesData$alcohol, gogglesData$gender), stat.desc, basic = FALSE)

#Levene's Test
leveneTest(gogglesData$attractiveness, gogglesData$gender, center = median)
leveneTest(gogglesData$attractiveness, gogglesData$alcohol, center = median)
leveneTest(gogglesData$attractiveness, interaction(gogglesData$alcohol, gogglesData$gender), center = median)



bar <- ggplot(gogglesData, aes(alcohol, attractiveness, fill = gender))
bar + stat_summary(fun.y = mean, geom = "bar", position="dodge") + stat_summary(fun.data = mean_cl_normal, geom = "errorbar", position=position_dodge(width=0.90), width = 0.2) + labs(x = "Alcohol Consumption", y = "Mean Attractiveness of Date (%)", fill = "Gender") 
imageFile <- paste(imageDirectory,"12 Goggles Interaction Bar.png",sep="/")
ggsave(file = imageFile)


bar <- ggplot(gogglesData, aes(gender, attractiveness))
bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Gender", y = "Mean Attractiveness of Date (%)") + scale_y_continuous(breaks=seq(0,80, by = 10))
imageFile <- paste(imageDirectory,"12 Goggles Gender Main Effect Bar.png",sep="/")
ggsave(file = imageFile)

bar <- ggplot(gogglesData, aes(alcohol, attractiveness))
bar + stat_summary(fun.y = mean, geom = "bar", fill = "White", colour = "Black") + stat_summary(fun.data = mean_cl_normal, geom = "pointrange") + labs(x = "Alcohol Consumption", y = "Mean Attractiveness of Date (%)") + scale_y_continuous(breaks=seq(0,80, by = 10))
imageFile <- paste(imageDirectory,"12 Goggles Alcohol Main Effect Bar.png",sep="/")
ggsave(file = imageFile)

id<-(1:48)
gender<-gl(2, 24, labels = c("Female", "Male"))
alcohol<-gl(3, 8, 48, labels = c("None", "2 Pints", "4 Pints"))
attractiveness<-c(65,70,60,60,60,55,60,55,70,65,60,70,65,60,60,50,55,65,70,55,55,60,50,50,50,55,80,65,70,75,75,65,45,60,85,65,70,70,80,60,30,30,30,55,35,20,45,40)

gogglesData<-data.frame(gender, alcohol, attractiveness)

contrasts(gogglesData$alcohol)<-cbind(c(-2, 1, 1), c(0, -1, 1))
contrasts(gogglesData$gender)<-c(-1, 1)
gogglesModel<-aov(attractiveness ~ gender+alcohol+gender:alcohol, data = gogglesData)
Anova(gogglesModel, type="III")

genderEffect<-effect("gender", gogglesModel)
summary(genderEffect)
alcoholEffect<-effect("alcohol", gogglesModel)
summary(alcoholEffect)
interactionMeans<-allEffects(gogglesModel)
summary(interactionMeans)

summary.lm(gogglesModel)



###단순 비교 
gogglesData$simple<-gl(6,8)
gogglesData$simple<-factor(gogglesData$simple, levels = c(1:6), labels = c("F_None","F_2pints", "F_4pints","M_None","M_2pints", "M_4pints"))


alcEffect1<-c(-2, 1, 1, -2, 1, 1)
alcEffect2<-c(0, -1, 1, 0, -1, 1)
gender_none<-c(-1, 0, 0, 1, 0, 0)
gender_twoPint<-c(0, -1, 0, 0, 1, 0)
gender_fourPint<-c(0, 0, -1, 0, 0, 1)
simpleEff<-cbind(alcEffect1, alcEffect2, gender_none, gender_twoPint, gender_fourPint)


contrasts(gogglesData$simple)<-simpleEff
simpleEffectModel<-aov(attractiveness ~ simple, data = gogglesData)

summary.lm(simpleEffectModel)



pairwise.t.test(gogglesData$attractiveness, gogglesData$alcohol, p.adjust.method = "bonferroni")
pairwise.t.test(gogglesData$attractiveness, gogglesData$alcohol, p.adjust.method = "BH")

postHocs<-glht(gogglesModel, linfct = mcp(alcohol = "Tukey"))
summary(postHocs)
confint(postHocs)


plot(gogglesModel)


id<-(1:48)
gender<-gl(2, 24, labels = c("Female", "Male"))
alcohol<-gl(3, 8, 48, labels = c("None", "2 Pints", "4 Pints"))
attractiveness<-c(65,70,60,60,60,55,60,55,70,65,60,70,65,60,60,50,55,65,70,55,55,60,50,50,50,55,80,65,70,75,75,65,45,60,85,65,70,70,80,60,30,30,30,55,35,20,45,40)


gogglesData<-data.frame(gender, alcohol, attractiveness)
gogglesData$row<-rep(1:8, 6)


gogglesMelt<-melt(gogglesData, id = c("row", "gender", "alcohol"), measured = c( "attractiveness"))
gogglesWide<-cast(gogglesMelt,  row ~ gender + alcohol)
gogglesWide$row<-NULL

t2way(2,3, gogglesWide)
 mcp2atm(2,3, gogglesWide)

t2way(2,3, gogglesWide, tr = .1)
mcp2atm(2,3, gogglesWide, tr = .1)

pbad2way(2,3, gogglesWide)
mcp2a(2,3, gogglesWide)

pbad2way(2,3, gogglesWide, est = median)
mcp2a(2,3, gogglesWide, est = median)



omega_factorial<-function(n,a,b, SSa, SSb, SSab, SSr)
{
  MSa<-SSa/(a-1)
  MSb<-SSb/(b-1)
  MSab<-SSab/((a-1)*(b-1))
  MSr<-SSr/(a*b*(n-1))
  varA<-((a-1)*(MSa-MSr))/(n*a*b)
  varB<-((b-1)*(MSb-MSr))/(n*a*b)
  varAB<-((a-1)*(b-1)*(MSab-MSr))/(n*a*b)
  varTotal<-varA + varB + varAB + MSr
  
  print(paste("Omega-Squared A: ", varA/varTotal))
  print(paste("Omega-Squared B: ", varB/varTotal))
  print(paste("Omega-Squared AB: ", varAB/varTotal))
}

omega_factorial(8,2,3,169,3332,1978,3488)


#Gender effects (within alcohol)


mes(66.875, 60.625, 10.3293963, 4.95515604, 8, 8)
mes(66.875, 62.5, 12.5178444, 6.5465367, 8, 8)
mes(35.625, 57.5, 10.8356225, 7.0710678, 8, 8)

##################################연습문제 1번 ######################################################################


#Read in the data:데이터 세팅
fugaziData<-read.delim("fugazi.dat", header = TRUE)

#factor 요인 설정 --> 연속으로 설정될수 있으니  범주형으로 설정
fugaziData$music<-factor(fugaziData$music, levels = c(1:3), labels = c("Fugazi", "Abba", "Barf Grooks"))
fugaziData$age<-factor(fugaziData$age, levels = c(1:2), labels = c("young", "old"))


# 그래프확인 
line <- ggplot(fugaziData, aes(music, liking, colour = age))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=age)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "음악", y = "좋아하는 정도")

boxplot <- ggplot(fugaziData, aes(music, liking))
boxplot + geom_boxplot() + facet_wrap(~age) + labs(x = "뮤직", y = "좋아한는 정도")

#Self Test 구룹으로 나눠서 데이터 확인
by(fugaziData$liking, fugaziData$music, stat.desc)
by(fugaziData$liking, fugaziData$age, stat.desc)
by(fugaziData$liking, list(fugaziData$music, fugaziData$age), stat.desc, basic = FALSE)
ㅋ
#Levene's Test 동질성 확인
leveneTest(fugaziData$liking, fugaziData$music, center = median)
leveneTest(fugaziData$liking, fugaziData$age, center = median)
leveneTest(fugaziData$liking, interaction(fugaziData$music, fugaziData$age), center = median)


# 아노바 대조군 설정
contrasts(fugaziData$music)<-cbind(c(-1, -2, 1), c(-1, 0, 1))
contrasts(fugaziData$age)<-c(-1, 1)
fugaziModel<-aov(liking ~ music+age+music:age, data = fugaziData)
Anova(fugaziModel, type="III")


##효과 확인
musicEffect<-effect("music", fugaziModel)
summary(musicEffect)
ageEffect<-effect("age", fugaziModel)
summary(ageEffect)
interactionMeans<-allEffects(fugaziModel)
summary(interactionMeans)
summary.lm(fugaziModel)


###단순 비교 
fugaziData$simple<-gl(6,15)
fugaziData$simple<-factor(fugaziData$simple, levels = c(1:6), labels = c("YOUNG_Fugazi","YOUNG_abba", "YOUNG_barf","OLD_Fugazi","OLD_abba", "OLD_barf"))

musicEffect1<-c(1,-2, 1, 1, -2, 1)
musicEffect2<-c(-1, 0, 1,-1, 0, 1)
age_Fugazi<-c(-1, 0, 0, 1, 0, 0)
age_abba<-c(0, -1, 0, 0, 1, 0)
age_barf<-c(0, 0, -1, 0, 0, 1)
simpleEff<-cbind(musicEffect1, musicEffect2, age_Fugazi, age_abba, age_barf)

contrasts(fugaziData$simple)<-simpleEff
simpleEffectModel<-aov(liking ~ simple, data = fugaziData)

summary.lm(simpleEffectModel)


pairwise.t.test(fugaziData$liking, fugaziData$music, p.adjust.method = "bonferroni")
pairwise.t.test(fugaziData$liking, fugaziData$music, p.adjust.method = "BH")

postHocs<-glht(fugaziModel, linfct = mcp(music = "Tukey"))
summary(postHocs)
confint(postHocs)

plot(fugaziModel)



omega_factorial(15,2,3,1,81864,310790,32553)



##################################연습문제 2번 ######################################################################
chickFlick<-read.delim("ChickFlick.dat", header = TRUE)


#factor 요인 설정 --> 연속으로 설정될수 있으니  범주형으로 설정
chickFlick$film<-factor(chickFlick$film, levels =c("Bridget Jones' Diary", "Memento") , labels =c("Bridget Jones' Diary", "Memento"))
chickFlick$gender<-factor(chickFlick$gender, levels =c("Male", "Female") , labels = c("Male", "Female"))
# chickFlick$gender<-factor(chickFlick$gender, levels =c("Male", "Female"), labels =  c(1:2))

#Levene's tests: 
leveneTest(chickFlick$arousal, interaction(chickFlick$film, chickFlick$gender), center = median)
leveneTest(chickFlick$arousal, chickFlick$gender, center = median)
leveneTest(chickFlick$arousal, chickFlick$film, center = median)

line <- ggplot(chickFlick, aes(film, arousal, colour = gender))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=gender)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "영화제목", y = "각성정도(감흥정도)")

boxplot <- ggplot(chickFlick, aes(film, arousal))
boxplot + geom_boxplot() + facet_wrap(~gender) + labs(x = "영화제목", y = "각성정도(감흥정도)")


boxplot <- ggplot(chickFlick, aes(gender, arousal))
boxplot + geom_boxplot() + facet_wrap(~film) + labs(x = "성별", y = "각성정도(감흥정도)")


boxplot <- ggplot(chickFlick, aes(gender, arousal))
boxplot + geom_boxplot()  + labs(x = "성별", y = "각성정도(감흥정도)")


by(chickFlick$arousal, chickFlick$film, stat.desc)
by(chickFlick$arousal, chickFlick$gender, stat.desc)
by(chickFlick$arousal, list(chickFlick$film, chickFlick$gender), stat.desc, basic = FALSE)

# 영화 대조군 설정
contrasts(chickFlick$film)<-c(-1, 1)
contrasts(chickFlick$gender)<-c(-1, 1)
chickFlickModel<-aov(arousal ~ film+gender+film:gender, data = chickFlick)
Anova(chickFlickModel, type="III")


chickFlick_filmEffect<-effect("film", chickFlickModel)
summary(chickFlick_filmEffect)
chickFlick_genderEffect<-effect("gender", chickFlickModel)
summary(chickFlick_genderEffect)
interactionMeans<-allEffects(chickFlickModel)
summary(interactionMeans)
summary.lm(chickFlickModel)                 

omega_factorial(10,2,2,87,1092,34.2,1467.7)




##################################연습문제 3번 ######################################################################
#Read in the data:
escapeData<-read.delim("Escape From Inside.dat", header = TRUE)

#Set Song Type and Songwriter to be factors:
escapeData$Song_Type<-factor(escapeData$Song_Type, levels = c(0:1), labels = c("Symphony", "Fly Song"))
escapeData$Songwriter<-factor(escapeData$Songwriter, levels = c(0:1), labels = c("Malcom", "Andy"))

#Levene's tests: 
leveneTest(escapeData$Screams, interaction(escapeData$Song_Type, escapeData$Songwriter), center = median)
leveneTest(escapeData$Screams, escapeData$Song_Type, center = median)
leveneTest(escapeData$Screams, escapeData$Songwriter, center = median)

#그래프확인
line <- ggplot(escapeData, aes(Song_Type, Screams, colour = Songwriter))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=Songwriter)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "노래종류", y = "소리 지르는 갯수")

boxplot <- ggplot(escapeData, aes(Songwriter, Screams))
boxplot + geom_boxplot() + facet_wrap(~Song_Type) + labs(x = "작곡가", y = "스크림 숫자")


boxplot <- ggplot(escapeData, aes(Song_Type, Screams))
boxplot + geom_boxplot() + facet_wrap(~Songwriter) + labs(x = "노래종류", y = "스크림 숫자")


#Self Test 구룹으로 나눠서 데이터 확인
by(escapeData$Screams, escapeData$Songwriter, stat.desc)
by(escapeData$Screams, escapeData$Song_Type, stat.desc)
by(escapeData$Screams, list(escapeData$Songwriter, escapeData$Song_Type), stat.desc, basic = FALSE)


# 아노바 대조군 설정 및 분산 분석
contrasts(escapeData$Songwriter)<-c(-1, 1)
contrasts(escapeData$Song_Type)<-c(-1, 1)
escapeModel<-aov(Screams ~ Songwriter+Song_Type+Songwriter:Song_Type, data = escapeData)
Anova(escapeModel, type="III")




##효과 확인
escape_SongwriterEffect<-effect("Songwriter", escapeModel)
summary(escape_SongwriterEffect)
escape_Song_TypeEffect<-effect("Song_Type", escapeModel)
summary(escape_Song_TypeEffect)
interactionMeans<-allEffects(escapeModel)
summary(interactionMeans)
summary.lm(escapeModel)                 




###단순 비교 닩순 비교를 왜 안했지 답변에서 확인해봐
# escapeData$simple<-gl(4,17)
# escapeData$simple<-factor(escapeData$simple, levels = c(1:4), labels = c("Fly_Andy","Fly_Malcom", "Symphony_Andy","Symphony_Malcom"))
# Song_Typeffect1<-c(1, -1, 0, 0)
# Song_Typeffect2<-c(0, 0, 1, -1)
# Songwritereffect1<-c(1, 0, -1, 0)
# Songwritereffect2<-c(0, 1, 0, -1)
# 
# simpleEff<-cbind(Song_Typeffect1,Song_Typeffect2, Songwritereffect1,Songwritereffect2)
# simpleEffectModel<-aov(Screams ~ simple, data = escapeData)
# 
# summary.lm(simpleEffectModel)
# 
# omega_factorial(10,2,2,87,1092,34.2,1467.7)



###단순 비교 
fugaziData$simple<-gl(6,15)
fugaziData$simple<-factor(fugaziData$simple, levels = c(1:6), labels = c("YOUNG_Fugazi","YOUNG_abba", "YOUNG_barf","OLD_Fugazi","OLD_abba", "OLD_barf"))

musicEffect1<-c(1,-2, 1, 1, -2, 1)
musicEffect2<-c(-1, 0, 1,-1, 0, 1)
age_Fugazi<-c(-1, 0, 0, 1, 0, 0)
age_abba<-c(0, -1, 0, 0, 1, 0)
age_barf<-c(0, 0, -1, 0, 0, 1)
simpleEff<-cbind(musicEffect1, musicEffect2, age_Fugazi, age_abba, age_barf)

contrasts(fugaziData$simple)<-simpleEff
simpleEffectModel<-aov(liking ~ simple, data = fugaziData)

summary.lm(simpleEffectModel)

omega_factorial(10,2,2,87,1092,34.2,1467.7)



############################################문제 4장 ########################################################


id<-(1:48)
gender<-gl(2, 24, labels = c("Female", "Male"))
alcohol<-gl(3, 8, 48, labels = c("None", "2 Pints", "4 Pints"))
attractiveness<-c(65,70,60,60,60,55,60,55,70,65,60,70,65,60,60,50,55,65,70,55,55,60,50,50,50,55,80,65,70,75,75,65,45,60,85,65,70,70,80,60,30,30,30,55,35,20,45,40)

gogglesData<-data.frame(gender, alcohol, attractiveness)
gogglesData$simple<-gl(6,8)
gogglesData$simple<-factor(gogglesData$simple, levels = c(1:6), labels = 
                             c("Male_0","Male_2", "Male_4","Female_0","Female_2", "Female_4"))


genderEffect1<-c(1, 1, 1, -1, -1, -1)
MaleEffect1<-c(0, 0, 0, -2, 1, 1)
MaleEffect2<-c(0, 0, 0, 0, 1, -1)
FemaleEffect1<-c(-2, 1, 1, 0, 0, 0)
FemaleEffect2<-c(0, 1, -1, 0, 0, 0)

simpleEff<-cbind(genderEffect1, MaleEffect1, MaleEffect2, FemaleEffect1, 
                 FemaleEffect2)

contrasts(gogglesData$simple)<-simpleEff
simpleEffectModel<-aov(attractiveness ~ simple, data = gogglesData)
summary.lm(simpleEffectModel)


############################################문제 5장 ########################################################

athleteData<-read.delim("wii.dat", header = TRUE)
athleteData$athlete<-factor(athleteData$athlete, levels =c("Athlete", "Non-Athlete"), labels = c("Athlete", "Non-Athlete"))
athleteData$stretch<-factor(athleteData$stretch, levels =c("No Stretching", "Stretching"), labels = c("No Stretching", "Stretching"))
athleteData$wii<-factor(athleteData$wii, levels =c("Playing Wii", "Watching Wii"), labels = c("Playing Wii", "Watching Wii"))

 
#Levene's tests: 

leveneTest(athleteData$injury, interaction(athleteData$athlete,athleteData$stretch,athleteData$wii), center = median)

leveneTest(athleteData$injury, interaction(athleteData$athlete,athleteData$stretch), center = median)
leveneTest(athleteData$injury, interaction(athleteData$athlete,athleteData$wii), center = median)
leveneTest(athleteData$injury, interaction(athleteData$stretch,athleteData$wii), center = median)
leveneTest(athleteData$injury, athleteData$athlete, center = median)
leveneTest(athleteData$injury, athleteData$stretch, center = median)
leveneTest(athleteData$injury, athleteData$wii, center = median)

line <- ggplot(athleteData, aes(stretch, injury, colour = athlete))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=athlete)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "스트레칭 여부", y = "아픈 숫자")

line <- ggplot(athleteData, aes(stretch, injury, colour = wii))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=wii)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "스트레칭 여부", y = "아픈 숫자")

line <- ggplot(athleteData, aes(wii, injury, colour = athlete))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=athlete)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "wii 여부", y = "아픈 숫자")

line <- ggplot(athleteData, aes(wii, injury, colour = stretch))
line + stat_summary(fun.y = mean, geom = "line", size = 1, aes(group=stretch)) + stat_summary(fun.data = mean_cl_boot, geom = "errorbar", width = 0.2, size = 0.75) + stat_summary(fun.y = mean, geom = "point", size = 4)+ labs(x = "wii 여부", y = "아픈 숫자")



threeWayInt <- ggplot(athleteData, aes(wii, injury, colour = stretch))
threeWayInt + stat_summary(fun.y = mean, geom = "point") + stat_summary(fun.y = mean, 
geom = "line", aes(group= stretch)) + stat_summary(fun.data = mean_cl_boot, geom = 
"errorbar", width = 0.2) + labs(x = "Wii Activity", y = "Mean Injury Score", colour = 
"Stretching Routine") + facet_wrap(~athlete) + scale_y_continuous(breaks=seq(0,10, by
= 1), limits = c(0, 10))



boxplot <- ggplot(athleteData, aes(stretch, injury))
boxplot + geom_boxplot() + facet_wrap(~athlete) + labs(x = "스트레칭 여부", y = "아픈 숫자")

boxplot <- ggplot(athleteData, aes(stretch, injury))
boxplot + geom_boxplot() + facet_wrap(~wii) + labs(x = "스트레칭 여부", y = "아픈 숫자")

boxplot <- ggplot(athleteData, aes(wii, injury))
boxplot + geom_boxplot() + facet_wrap(~athlete) + labs(x = "wii 여부", y = "아픈 숫자")

boxplot <- ggplot(athleteData, aes(wii, injury))
boxplot + geom_boxplot() + facet_wrap(~stretch) + labs(x = "wii 여부", y = "아픈 숫자")
          

# 아노바 대조군 설정
contrasts(athleteData$stretch)<-cbind(c(1, -1))
contrasts(athleteData$athlete)<-cbind(c(1, -1))
contrasts(athleteData$wii)<-c(-1, 1)

athleteModel<-aov(injury ~ stretch+athlete+wii+stretch:athlete+athlete:wii+stretch:wii+stretch:athlete:wii, data = athleteData)
Anova(athleteModel, type="III")

plot(athleteModel)
