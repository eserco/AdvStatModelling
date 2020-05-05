# clean R working environment:
rm(list=ls())

setwd("/Users/eserc/Desktop/HMC/second year/Ib/Advanced statistical modelling/Validity analysis/")

# Load data:
load("sub_116_small.rda")

# Load packages:
library(plyr)
library(mgcv)
library(itsadug)

# run the following code:
dat$Time <- dat$Timestamp - dat$Timestamp.start_trial
names(dat)[names(dat)=="waktu1"] <- "word.duration"


# time bins for plotting:
dat$Timebin <- (floor(dat$Time / 200)+.5)*200

# Calculate the grand averages:
avg <- ddply(dat, c("trial", "Timebin", "condition"), summarise,
             pupil = mean(PupilClean, na.rm=TRUE))
avg <- ddply(avg, c("Timebin", "condition"), summarise,
             m.pupil = mean(pupil, na.rm=TRUE),
             se.pupil=se(pupil, na.rm=TRUE))
head(avg)

# Plot:
plot(c(),xlim=range(avg$Timebin), ylim=range(avg$m.pupil),main="Pressed space bar",
     ylab="Pupilsize", xlab="Time from onset trial(ms)", 
     bty='n')

with(avg[avg$condition=="reward",], 
     plot_error(Timebin, m.pupil, se.pupil, col=2))
with(avg[avg$condition=="no_reward",], 
     plot_error(Timebin, m.pupil, se.pupil, shade=TRUE))

# Lines to indicate the time that the words and the answer screen 
# initially appear:
abline(v=c(0,5000,10000,15000), lty=3)

# Add legend (see help(legend) ):
legend('topleft', legend=c("reward", "no reward"), 
       lwd=1.5, col=2:1, pch=c(21,15), pt.bg="white", bty='n')


dat$wordTime <- dat$Time %% dat$word.duration
dat$Word     <- (dat$Time %/% dat$word.duration)+1
dat[dat$Time < 0 | dat$Word > 3,]$Word <- NA

# time bins for plotting:
dat$Timebin <- (floor(dat$wordTime / 200)+.5)*200

# Calculate the grand averages:
avg <- ddply(dat[!is.na(dat$Word),], c("trial", "Timebin", "Word", "condition"), summarise,
             pupil = mean(PupilClean, na.rm=TRUE))
avg <- ddply(avg, c("Timebin", "Word", "condition"), summarise,
             m.pupil = mean(pupil, na.rm=TRUE),
             se.pupil=se(pupil, na.rm=TRUE))
head(avg)

# Three panels:
par(mfrow=c(1,2))

# Plot:
plot(c(),c(),
     xlim=range(avg$Timebin), ylim=range(avg$m.pupil),
     main="Reward",
     ylab="Pupilsize", xlab="Time from onset trial(ms)", 
     bty='n')
with(avg[avg$condition=="reward" & avg$Word=='1',], 
     plot_error(Timebin, m.pupil, se.pupil, col='red'))
with(avg[avg$condition=="reward" & avg$Word=='2',], 
     plot_error(Timebin, m.pupil, se.pupil, col='purple'))
with(avg[avg$condition=="reward" & avg$Word=='3',], 
     plot_error(Timebin, m.pupil, se.pupil, col='blue'))

plot(c(),c(),
     xlim=range(avg$Timebin), ylim=range(avg$m.pupil),main="No Reward",
     ylab="Pupilsize", xlab="Time from onset trial(ms)", 
     bty='n')

with(avg[avg$condition=="no_reward" & avg$Word=='1',], 
     plot_error(Timebin, m.pupil, se.pupil, col='red'))
with(avg[avg$condition=="no_reward" & avg$Word=='2',], 
     plot_error(Timebin, m.pupil, se.pupil, col='purple'))
with(avg[avg$condition=="no_reward" & avg$Word=='3',], 
     plot_error(Timebin, m.pupil, se.pupil, col='blue'))

# Add legend (see help(legend) ):
legend('topleft', legend=c("reward", "no reward"), 
       lwd=1.5, col=c("blue","red"), pch=c(21,15), pt.bg="white", bty='n')


#question 2: Gam 
#adding parameter of family = "scat" makes the non normal ditributio into normal
m1 <- bam(PupilClean ~ s(wordTime) + s(word.duration) + ti(wordTime, word.duration) # <- add here the model formula
          , data=dat, discrete = TRUE)
summary(m1)

pvisgam(m1, view=c("wordTime","word.duration"))
points(dat$wordTime, dat$word.duration)

#make qqplot
qqnorm(resid(m1))
qqline(resid(m1))

#acf
acf(resid(m1))

#rsiduals
plot(fitted(m1),resid(m1))

#rsiduals wih less data
plot(fitted(m1)[1:100],resid(m1)[1:100])


#random slope
# a trial is consisted of many measurements so we need to use random effects
m1 <- bam(PupilClean ~ s(wordTime) + s(word.duration) + ti(wordTime, word.duration)+
             s(trialF, bs = "re") + (trialF, wordTime, bs = "re")# <- add here the model formula
          , data=dat, discrete = TRUE)
summary(m1)


#for the random slope for each trialf we use wortime slope in a random and linear way and it didnt make difference