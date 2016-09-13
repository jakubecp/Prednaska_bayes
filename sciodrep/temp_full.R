#DATA loading, filtering and reshaping

rm(list = ls())
data = read.csv("Data/cholevinae_full – kopie.csv", header=TRUE, sep = ";") #old dataset
head(data)
summary(data)
class(data$DT_egg)
class (data$temp)

data_12 = data [data$year=="2012",] # data for 2012
data_13 = data [data$year=="2013",] # data for 2013
data_t15 = data [data$temp=="15",] # data for 15°C
data_t18 = data [data$temp=="18",] # data for 18°C
data_t21 = data [data$temp=="21",] # data for 21°C
data_t25 = data [data$temp=="25",] # data for 25°C
data_t28 = data [data$temp=="28",] # data for 28°C
summary (data_13)

data_13_t15 = data_13 [data_13$temp=="15",] # data for 15°C
data_13_t18 = data_13 [data_13$temp=="18",] # data for 15°C
data_13_t21 = data_13 [data_13$temp=="21",] # data for 15°C
data_13_t25 = data_13 [data_13$temp=="25",] # data for 15°C

devel = c(data_13$egg, data_13$L1, data$L2, data$L3, data$pupae)
DD = c (data_13$DT_egg, data_13$DT_L1, data$DT_L2, data$DT_L3, data$DT_pupae)
temp = c(data_13$temp, data_13$temp, data$temp, data$temp, data$temp)
Stage = c(rep ("egg", times=length(data_13$egg)), rep ("L1", times=length(data_13$L1)),
           rep ("L2", times=length(data$L2)), rep ("L3", times=length(data$L3)),
           rep ("pupae", times=length(data$pupae)))

dev.length = data.frame (devel, DD, Stage, temp)
dev.length$temp = as.factor(dev.length$temp)
dev.length = dev.length[complete.cases(dev.length),]
length (dev.length$DD[dev.length$Stage == "egg"])
length (dev.length$DD[dev.length$Stage == "L1"])
length (dev.length$DD[dev.length$Stage == "L2"])
length (dev.length$DD[dev.length$Stage == "L3"])
length (dev.length$DD[dev.length$Stage == "pupae"])

library (ggplot2)
library (plotrix)

dev.dur = c(median (dev.length$devel[dev.length$Stage == "egg" & dev.length$temp=="15"]),
median (dev.length$devel[dev.length$Stage == "egg" & dev.length$temp=="18"]),
median (dev.length$devel[dev.length$Stage == "egg" & dev.length$temp=="21"]),
median (dev.length$devel[dev.length$Stage == "egg" & dev.length$temp=="25"]),

median (dev.length$devel[dev.length$Stage == "L1" & dev.length$temp=="15"]),
median (dev.length$devel[dev.length$Stage == "L1" & dev.length$temp=="18"]),
median (dev.length$devel[dev.length$Stage == "L1" & dev.length$temp=="21"]),
median (dev.length$devel[dev.length$Stage == "L1" & dev.length$temp=="25"]),

median (dev.length$devel[dev.length$Stage == "L2" & dev.length$temp=="15"]),
median (dev.length$devel[dev.length$Stage == "L2" & dev.length$temp=="18"]),
median (dev.length$devel[dev.length$Stage == "L2" & dev.length$temp=="21"]),
median (dev.length$devel[dev.length$Stage == "L2" & dev.length$temp=="25"]),

median (dev.length$devel[dev.length$Stage == "L3" & dev.length$temp=="15"]),
median (dev.length$devel[dev.length$Stage == "L3" & dev.length$temp=="18"]),
median (dev.length$devel[dev.length$Stage == "L3" & dev.length$temp=="21"]),
median (dev.length$devel[dev.length$Stage == "L3" & dev.length$temp=="25"]),

median (dev.length$devel[dev.length$Stage == "pupae" & dev.length$temp=="15"]),
median (dev.length$devel[dev.length$Stage == "pupae" & dev.length$temp=="18"]),
median (dev.length$devel[dev.length$Stage == "pupae" & dev.length$temp=="21"]),
median (dev.length$devel[dev.length$Stage == "pupae" & dev.length$temp=="25"]))

#normality
qqnorm(data_13$DT_egg)
qqline(data_13$DT_egg)
qqnorm(data$DT_L1)
qqline(data$DT_L1)
qqnorm(data$DT_L2)
qqline(data$DT_L2)
qqnorm(data$DT_L3)
qqline(data$DT_L3)
qqnorm(data$DT_pupae)
qqline(data$DT_pupae)


#boxplots of development times
tiff (filename="exports/sciodrepoides_dev_time.tiff", 
      width=5000, height=5000, 
      compression="lzw", res= 800)
p = ggplot (dev.length, aes (Stage, devel))
p + geom_boxplot() + 
  stat_summary (fun.y=mean, colour="darkred", 
                geom="point", shape=18, size=3)+
  xlab("Developmental stage")+
  ylab("Development time (h)")
dev.off()
  


#mean development time and its standard errors
se <- function(x) sqrt(var(x)/length(x))
mean (data_13$egg, na.rm=TRUE)
mean (data_13$L1, na.rm=TRUE)
mean (data$L2, na.rm=TRUE)
mean (data$L3, na.rm=TRUE)
mean (data$pupae, na.rm=TRUE)

std.error (data_13$egg, na.rm=TRUE)
std.error (data_13$L1, na.rm=TRUE)
std.error (data$L2, na.rm=TRUE)
std.error (data$L3, na.rm=TRUE)
std.error (data$pupae, na.rm=TRUE)

#mean development time in different temperatures

data_13_t15 = data_13 [data_13$temp=="15",] # data for 15°C
data_13_t18 = data_13 [data_13$temp=="18",] # data for 15°C
data_13_t21 = data_13 [data_13$temp=="21",] # data for 15°C
data_13_t25 = data_13 [data_13$temp=="25",] # data for 15°C
summary (data_13_t25)

#egg
mean.dev = c(mean (data_13_t15$egg,na.rm=TRUE),
mean (data_13_t18$egg,na.rm=TRUE),
mean (data_13_t21$egg,na.rm=TRUE),
mean (data_13_t25$egg,na.rm=TRUE),
#L1
mean (data_13_t15$L1,na.rm=TRUE),
mean (data_13_t18$L1,na.rm=TRUE),
mean (data_13_t21$L1,na.rm=TRUE),
mean (data_13_t25$L1,na.rm=TRUE),
#L2
mean (data_t15$L2,na.rm=TRUE),
mean (data_t18$L2,na.rm=TRUE),
mean (data_t21$L2,na.rm=TRUE),
mean (data_t25$L2,na.rm=TRUE),
#L3
mean (data_t15$L3,na.rm=TRUE),
mean (data_t18$L3,na.rm=TRUE),
mean (data_t21$L3,na.rm=TRUE),
mean (data_t25$L3,na.rm=TRUE),
#pupae
mean (data_t15$pupae,na.rm=TRUE),
mean (data_t18$pupae,na.rm=TRUE),
mean (data_t21$pupae,na.rm=TRUE))

std.error.dev = c(std.error (data_13_t15$egg,na.rm=TRUE),
                  std.error (data_13_t18$egg,na.rm=TRUE),
                  std.error (data_13_t21$egg,na.rm=TRUE),
                  std.error (data_13_t25$egg,na.rm=TRUE),
                  #L1
                  std.error (data_13_t15$L1,na.rm=TRUE),
                  std.error (data_13_t18$L1,na.rm=TRUE),
                  std.error (data_13_t21$L1,na.rm=TRUE),
                  std.error (data_13_t25$L1,na.rm=TRUE),
                  #L2
                  std.error (data_t15$L2,na.rm=TRUE),
                  std.error (data_t18$L2,na.rm=TRUE),
                  std.error (data_t21$L2,na.rm=TRUE),
                  std.error (data_t25$L2,na.rm=TRUE),
                  #L3
                  std.error (data_t15$L3,na.rm=TRUE),
                  std.error (data_t18$L3,na.rm=TRUE),
                  std.error (data_t21$L3,na.rm=TRUE),
                  std.error (data_t25$L3,na.rm=TRUE),
                  #pupae
                  std.error (data_t15$pupae,na.rm=TRUE),
                  std.error (data_t18$pupae,na.rm=TRUE),
                  std.error (data_t21$pupae,na.rm=TRUE))

#barplot of development times across temperatures
#summarySE is function defined in script summarySE.R which is preparing data to
#be ploted with SE or confidence intervals...
sumary.dev <-  summarySE (dev.length, 
                        measurevar="devel", groupvars=c("Stage","temp") )

str(dev.length)
dev.length$intr = interaction (dev.length$Stage, dev.length$temp)

pdf ("exports/Fig.6.pdf", width=10, height=8)
p = ggplot (sumary.dev, aes (y=devel, x=temp, fill=Stage, label=Stage))
p + stat_summary(fun.y=mean, geom="bar", position=position_dodge())+
  xlab("Experimental temperature (°C)")+
  ylab("Developmental time")+
  scale_fill_brewer(type="seq", palette=8)+
  # geom_errorbar(aes(ymin=devel, ymax=devel+se),
  #               width=.2,                    # Width of the error bars
  #               position=position_dodge(.9))+
  geom_text(aes(), position = position_dodge(0.9), size=3, vjust = -0.5)+
  theme(legend.position="none")

dev.off()


#Plot of mean mortality for each treatment
#First Instar mortality
mort_15 <-(1-mean(data_t15$mortality_L1))*100 #until L2
mort_18 <-(1-mean(data_t18$mortality_L1))*100 #until L2
mort_21 <-(1-mean(data_t21$mortality_L1))*100 #until L2
mort_25 <-(1-mean(data_t25$mortality_L1))*100 #until L2
mort_28 <-100 #until L2
mort0 <- c(mort_15, mort_18, mort_21, mort_25)
temp0 <- c(15,18,21,25)
plot (mort0~temp0, type="o" , col="black", pch=16, 
      main = "mean mortality of first instar", ylim=c(0,100))

#SEcond Instar
mort_15 <-(1-mean(data_t15$mortality_L2))*100 #until L3
mort_18 <-(1-mean(data_t18$mortality_L2))*100 #until L3
mort_21 <-(1-mean(data_t21$mortality_L2))*100 #until L3
mort_25 <-(1-mean(data_t25$mortality_L2))*100 #until L3
mort_28 <-100 #until L3
mort1 <- c(mort_15, mort_18, mort_21, mort_25)
temp1 <- c(15,18,21,25)
plot (mort1~temp1, type="o" , col="black", pch=16, 
      main = "mean mortality of second instar", ylim=c(0,100))
#Third instar
mort_15 <-(1-mean(data_t15$mortality_L3))*100 #until L3
mort_18 <-(1-mean(data_t18$mortality_L3))*100 #until L3
mort_21 <-(1-mean(data_t21$mortality_L3))*100 #until L3
mort_25 <-(1-mean(data_t25$mortality_L3))*100 #until L3
mort_28 <-100 #until L3
mort2 <- c(mort_15, mort_18, mort_21, mort_25)
plot (mort2~temp1, type="o" , col="black", pch=16, 
      main = "mean mortality of third instar", ylim=c(0,100))
#until adulthood
mort_15 <-(1-mean(data_t15$mortality_total))*100 #until L3
mort_18 <-(1-mean(data_t18$mortality_total))*100 #until L3
mort_21 <-(1-mean(data_t21$mortality_total))*100 #until L3
mort_25 <-(1-mean(data_t25$mortality_total))*100 #until L3
mort_28 <-100 #until L3
mort3 <- c(mort_15, mort_18, mort_21, mort_25)
plot (mort3~temp1, type="o" , col="black", pch=16, 
      main = "mean mortality until adulthood", ylim=c(0,100))

mort = c(mort0, mort1, mort2, mort3)
mort= as.numeric (mort)
temp = c(temp0, temp1, temp1, temp1)
temp= as.numeric (temp)
instar = c("first", "first", "first", "first","second", "second", "second", "second", "third", "third", "third", "third", "adult",
           "adult", "adult", "adult")
data_mort = data.frame (cbind(mort, temp, instar))
data_mort$mort= as.vector (data_mort$mort)
data_mort$temp= as.vector (data_mort$temp)
data_mort$mort= as.numeric (data_mort$mort)
data_mort$temp= as.numeric (data_mort$temp)

is.factor(data_mort$mort)

#renaming factors for legend
dm = data_mort
levels (dm$instar)[levels(dm$instar)=="first"] = "First instar"
levels (dm$instar)[levels(dm$instar)=="second"] = "Second instar"
levels (dm$instar)[levels(dm$instar)=="third"] = "Third instar"
levels (dm$instar)[levels(dm$instar)=="adult"] = "Pupae"
names(dm)[names(dm)=="instar"] = "Stage"


#Generate and export graph for mortality
# tiff (filename="exports/sciodrepoides_mortality.tiff", 
#       width=5000, height=5000, 
#       compression="lzw", res= 800)

#optimized version in ggplot
ggplot (data= dm, aes(x=temp, y=mort, group= Stage, shape=Stage, fill=Stage)) + 
  geom_point (size=4, aes (temp, mort, group = factor(Stage), colour=Stage)) +
  geom_line(aes(temp, mort, group = factor(Stage), colour=Stage))+
  ylim(0,100)+
  xlab("Temperature (°C)")+
  ylab("Mortality (%)")
  #scale_colour_brewer(type="seq", palette=8)
# dev.off()
#classical version with a plot function
# plot (mort1~temp1, pch=0, 
#       ylim=c(0,100), xlim=c(15, 26), 
#       xlab="Temperature (°C)", ylab="Mortality (%)")
# points (temp1, mort2,  pch=1)
# points (temp1, mort3,  pch=2)
# lines (temp1, mort2,  pch=16, lty=3)
# lines (temp1, mort3,  pch=16, lty=2)
# lines (temp1, mort1,  pch=16, lty=1)
# legend (23,20, c("2nd instar", "3rd instar", "pupae"),
#         pch = c(0,1,2), lty = c(1,3,2), merge=TRUE)

## New dataset based on the location of origin
data_loc1 = data [data$loc== "Bestvi",]
data_loc2 = data [data$loc== "Praha",]
data_loc1_13 = data_13 [data_13$loc== "Bestvi",]
data_loc2_13 = data_13 [data_13$loc== "Praha",]
data_loc = rbind (data_loc1_13, data_loc2_13)
summary (data_loc2_13)
loc.1=lm(data_loc$DT_egg~data_loc$egg)
loc.2=lm(data_loc$DT_egg~data_loc$egg+data_loc$loc)
loc.3=lm(data_loc$DT_egg~data_loc$egg*data_loc$loc)
summary (loc.1)
summary (loc.2)
summary (loc.3)
AIC (loc.1, loc.2, loc.3)
BIC (loc.1, loc.2, loc.3)

#boxplot for only two localities and 2013
boxplot (data_loc1$DT_egg, data_loc1$DT_L1, data_loc1$DT_L2, data_loc1$DT_L3, data_loc1$DT_pupae)
boxplot (data_loc2$DT_egg, data_loc2$DT_L1, data_loc2$DT_L2, data_loc2$DT_L3, data_loc2$DT_pupae)

boxplot (data_loc1_13$DT_egg, data_loc1_13$DT_L1, data_loc1_13$DT_L2, data_loc1_13$DT_L3, data_loc1_13$DT_pupae)
boxplot (data_loc2_13$DT_egg, data_loc2_13$DT_L1, data_loc2_13$DT_L2, data_loc2_13$DT_L3, data_loc2_13$DT_pupae)

##Tmin + SET - DT~D
#Bestvina 2013
lm.1_1=lm(data_loc1_13$DT_egg~data_loc1_13$egg)
summary(lm.1_1)
lm.2_1=lm(data_loc1_13$DT_L1~data_loc1_13$L1)
summary(lm.2_1)
lm.3_1=lm(data_loc1_13$DT_L2~data_loc1_13$L2)
summary(lm.3_1)
lm.4_1=lm(data_loc1_13$DT_L3 ~data_loc1_13$L3)
summary(lm.4_1)
lm.5_1=lm(data_loc1_13$DT_pupae~data_loc1_13$pupae)
summary(lm.5_1)

#Praha 2013
lm.1_2=lm(data_loc2_13$DT_egg~data_loc2_13$egg)
summary(lm.1)
lm.2_2=lm(data_loc2_13$DT_L1~data_loc2_13$L1)
summary(lm.2)
lm.3_2=lm(data_loc2_13$DT_L2~data_loc2_13$L2)
summary(lm.3)
lm.4_2=lm(data_loc2_13$DT_L3 ~data_loc2_13$L3)
summary(lm.4_2)
lm.5_2=lm(data_loc2_13$DT_pupae~data_loc2_13$pupae)
summary(lm.5)

#Printing values of model coefficients
str(lm.1)
set1_13 = c(lm.1_1$coefficients[1], lm.2_1$coefficients[1], 
            lm.3_1$coefficients[1], lm.4_1$coefficients[1],
            0)
set2_13 = c(lm.1_2$coefficients[1], lm.2_2$coefficients[1], 
            lm.3_2$coefficients[1], 0,
            0)

tmin1_13 = c(lm.1_1$coefficients[2], lm.2_1$coefficients[2], 
            lm.3_1$coefficients[2], lm.4_1$coefficients[2],
            0)
tmin2_13 = c(lm.1_2$coefficients[2], lm.2_2$coefficients[2], 
            lm.3_2$coefficients[2], 0,
            0)

set_13 = data.frame (set1_13,set2_13)
tmin_13 = data.frame (tmin1_13,tmin2_13)





#Tmin + SET - DT~D
data = read.csv("Data/medians.csv", header=TRUE, sep = ";") #old dataset
lm.1=lm(data_13$DT_egg~data_13$egg)
summary(lm.1)
lm.2=lm(data_13$DT_L1~data_13$L1)
summary(lm.2)
lm.3=lm(data$DT_L2~data$L2)
summary(lm.3)
lm.4=lm(data$DT_L3 ~data$L3)
summary(lm.4)
lm.5=lm(data$DT_pupae~data$pupae)
summary(lm.5)

#Tmin + SET - DT~D
data = read.csv("Data/medians.csv", header=TRUE, sep = ";") #old dataset
lm.1=lm(data$DT[data$stage=="egg"]~data$dev.dur[data$stage=="egg"])
summary(lm.1)
lm.2=lm(data$DT[data$stage=="L1"]~data$dev.dur[data$stage=="L1"])
summary(lm.2)
lm.3=lm(data$DT[data$stage=="L2"]~data$dev.dur[data$stage=="L2"])
summary(lm.3)
lm.4=lm(data$DT[data$stage=="L3"]~data$dev.dur[data$stage=="L3"])
summary(lm.4)
lm.5=lm(data$DT[data$stage=="pupae"]~data$dev.dur[data$stage=="pupae"])
summary(lm.5)


#Printing of obtained parameter values from the linear models
str(lm.4)
set = c(lm.1$coefficients[1], lm.2$coefficients[1], 
        lm.3$coefficients[1], lm.4$coefficients[1],
        lm.5$coefficients[1])

tmin = c(lm.1$coefficients[2], lm.2$coefficients[2], 
             lm.3$coefficients[2], lm.4$coefficients[2],
             lm.5$coefficients[2])

sum_lm = summary (lm.1)
str (sum_lm)

std.error_tmin = c(summary (lm.1)$coefficients [2,2], summary (lm.2)$coefficients [2,2],
              summary (lm.3)$coefficients [2,2], summary (lm.4)$coefficients [2,2],
              summary (lm.5)$coefficients [2,2])

std.error_sum = c(summary (lm.1)$coefficients [1,2], summary (lm.2)$coefficients [1,2],
                   summary (lm.3)$coefficients [1,2], summary (lm.4)$coefficients [1,2],
                   summary (lm.5)$coefficients [1,2])

#SET and Tmin of Ikemoto model with their std. errors
dev.char = data.frame (set,std.error_sum, tmin,  std.error_tmin)
write.csv (dev.char, file="exports/dev_char.csv")
