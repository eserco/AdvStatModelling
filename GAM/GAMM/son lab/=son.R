library(plyr)
library(lme4)

datafile <- read.table("behavioral-data.txt", header=TRUE, sep="\ ", stringsAsFactors=FALSE)
# always immediately check whether the data looks as expected:
head(datafile)

# Check the size of the data
dim(datafile) 
nrow(datafile)
ncol(datafile)

# List the column names:
names(datafile)
# which is for data.frames (but not for vectors) the same as:
colnames(datafile)
# .. and not very informative here:
# rownames(datafile)

# List the structure of the data
str(datafile)
summary(datafile)

# Print the first and the last 3 rows in the data
head(datafile, 3)
tail(datafile, 3)

datafile <- droplevels(datafile[datafile$Probe.RT > 50,])

table( datafile$Subject )

# calculate the number of correct responses per participant
check <- tapply(datafile$acc, list(datafile$Subject), sum)
# inspect:
range(check)

datafile$logRT <- log(datafile$Probe.RT)
datafile$inverseRT <- -1000/datafile$Probe.RT

par(mfrow=c(1,2)) # it will allow you to combine two graphs in one
qqnorm(datafile$logRT, main = "Q-Q Plot of Log RT", ylim=c(5,10))
qqline(datafile$logRT)
qqnorm(datafile$inverseRT, main = "Q-Q Plot of Inverse RT", ylim=c(-3,3))
qqline(datafile$inverseRT)
