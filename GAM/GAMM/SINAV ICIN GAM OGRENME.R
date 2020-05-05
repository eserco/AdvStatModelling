library(itsadug)
library(mgcv)
data(simdat)
# add missing values to simdat:
simdat[sample(nrow(simdat), 15),]$Y <- NA

simdat$Condition <- as.factor(simdat$Condition)
# Note: this is really not the best fitting model for the data:
m1 <- bam(Y ~ Group * Condition + s(Time) + s(Trial) + ti(Time, Trial) + s(Time, Subject, bs='fs', m=1, k=5), data=simdat, discrete=TRUE)

gamtabs(m1, type="HTML")



#If you have continious by categorical predictor interaction you can use the following
# you have to inlude parametric variable Group as normal like before. Dont forgt to use it
m4 <- bam(Y ~ Group + s(Time, by=Group), data=simdat)

#if you have multiple categorical predictors first get the interaction with the following
#IF you have 2 levels of a lets say group variable and 2 levels of an income variable. but you have missing data for one of the levels 
#of income variable. Which gives  you 3 possible combinations then use drop = TRUE to not generate level for the missing one

dataset$interaction <-interaction(dataset$Var1,dataset$Var2, drop= TRUE)


#while calculating the values of summed effects plot with plot_smooth function the first variable s(Age) as taken as complete function
#then if we have additional predictors, we add the mean value of each remaning smooths. So if we have s(LogFreq) then we take the coresponding y value for the
#mean X value and add to the y axis of s(Age). so in a sense the s(logfreq) lifts up the s(age) smooth function.

#when edf is significant the variable is significant in at least one place in the nonlinear graph

#when random effect is in the summary the edf is not the amount of functions

#you can add k to ti such as ti(x,y, c=(10,10))


