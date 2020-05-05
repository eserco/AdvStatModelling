install.packages("plyr", repos = "http://cran.us.r-project.org")
install.packages("plotfunctions")
install.packages("ggplot2")

library(ggplot2)
library(plyr)
library(plotfunctions)

load("data_for_assignment1_2.rda")

head(datafile, n = 10) # inspect the first 10 elements
tail(datafile)         # inspect last 6 elements

#Question 1

#What are the measures that were recorded during the experiment?
#City1 and city 2 recognition response, accuracy between 1 and 2, and reaction time in miliseconds.

#Inspect the accuracy with the command summary(datafile$acc_vp). What is the min, max and mean accuracy?
#Answer can be found by summary(datafile$acc_vp) command which yields range of accuracies between 0 and 1.
#The mean is 0.5813

#Do the same for the reaction times (column datafile$rt_vp). What are the mean and median reaction times?
#What does the difference between the mean and median tell about the distribution of the reaction times?
#range for reaction times: 510 to 29519ms. Mean is 2132
#The difference between mean and median tells us about the skewness so in our case the data distribution is right skewed


#Question 1: Measurements

# convert these columns to factor (see help(factor) fore more information):
datafile$city1 <- as.factor(datafile$city1)
datafile$city2 <- as.factor(datafile$city2)
# inspect data:
str(datafile)

is.integer(datafile$rt_vp)
is.numeric(datafile$rt_vp)
class(datafile$rt_vp)

is.character(datafile$name_city1)
is.factor(datafile$name_city1)
class(datafile$name_city1)
unique(datafile$name_city1)

is.factor(datafile$city1)
levels(datafile$city1)
unique(datafile$city1)

#Question 2: Conditions

#2400 U and 2400 R cities for city1 column
#Belfast,Glasgow,Oxford,Poole has the highest variation considering the match between other possible cities
#is.element(x, y) is identical to x %in% y and setdiff and intersect is same.


