#Probability Distributions
#6 Mar 2025
#SES


############################
# Function: my_histo
# Purpose: creates a ggplot histogram
# Requires: ggplot2
# Input: a numeric vector
# Output: a ggplot histogram

library(ggplot2)

my_histo <- function(x=NULL) {
  if(is.null(x)) df=data.frame(x=runif(1000)) else df <- data.frame(x=x)
  p1 <- ggplot(data=df) +
    aes(x=x) +
    geom_histogram(color="black",fill="goldenrod")
  print(p1)

}
my_histo()

###Poisson Distributions###

library(ggplot2)
library(MASS)
#-------------------------------------------------
# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# (observations per time or per unit area)
# Parameter lambda > 0

#Note: "zero=inflated poisson" has an additional process
#generating zeros (see ifelse())

#note: "zero-censored poisson" occurs when zeros are not recorded

# "d" function generates probability density
hits <- 0:10
myVec <- dpois(x=hits,lambda=1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

myVec <- dpois(x=hits,lambda=2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

hits <- 0:15
myVec <- dpois(x=hits,lambda=6)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


hits <- 0:15
myVec <- dpois(x=hits,lambda=0.2)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

sum(myVec)  # sum of density function = 1.0 (total area under curve)

# for a Poisson distribution with lambda=2,
# what is the probability that a single draw will yield X=0?

dpois(x=0,lambda=2)

# "p" function generates cumulative probability density; gives the
# "lower tail" cumulative area of the distribution

hits <- 0:30 #this should be >lambda!!!
myVec <- ppois(q=hits,lambda=20)

qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# for a Poisson distribution with lambda=2,
# what is the probability of getting 1 or fewer hits?

ppois(q=1, lambda=2)


# We could also get this through dpois
p_0 <- dpois(x=0,lambda=2)
p_0
p_1 <- dpois(x=1,lambda=2)
p_1
p_0 + p_1


# The q function is the inverse of p
# What is the number of hits corresponding to 50% of the probability mass
qpois(p=0.5,lambda=2.5)
qplot(x=0:10,y=dpois(x=0:10,lambda=2.5),geom="col",color=I("black"),fill=I("goldenrod"))

# but distribution is discrete, so this is not exact
ppois(q=2,lambda=2.5)

# finally, we can simulate individual values from a poisson
ranPois <- rpois(n=1000,lambda=2.5)
qplot(x=ranPois,color=I("black"),fill=I("goldenrod"))


# for real or simulated data, we can use the quantile
# function to find the empirical  95% confidence interval on the data

quantile(x=ranPois,probs=c(0.025,0.975))

#-------------------------------------------------
# Binomial distribution
# p = probability of a dichotomous outcome
# size = number of trials
# x = possible outcomes
# outcome x is bounded between 0 and number of trials

# use "d" binom for density function
hits <- 0:10
myVec <- dbinom(x=hits,size=10,prob=0.5)
qplot(x=0:10,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))



# and how does this compare to an actual simulation of 50 tosses of 100 coins?

myCoins <- rbinom(n=50,size=100,prob=0.5)
qplot(x=myCoins,color=I("black"),fill=I("goldenrod"))
quantile(x=myCoins,probs=c(0.025,0.975))

#Negative Binomial distribution

#-------------------------------------------------
# negative binomial: number of failures (values of MyVec)
# in a series of (Bernouli) with p=probability of success
# before a target number of successes (= size)
# generates a discrete distribution that is more
# heterogeneous ("overdispersed") than Poisson
hits <- 0:40
myVec <- dnbinom(x=hits, size=5, prob=0.5)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))

#another way to plot
plot(myVec, type = "b")

# geometric series is a special case where N= 1 success
# each bar is a constant fraction 1 - "prob" of the bar before it
myVec <- dnbinom(x=hits, size=1, prob=0.1)
qplot(x=hits,y=myVec,geom="col",color=I("black"),fill=I("goldenrod"))


# alternatively specify mean = mu of distribution and size,
# the dispersion parameter (small is more dispersed)
# this gives us a poisson with a lambda value that varies
# the dispersion parameter is the shape parameter in the gamma
# as it increases, the distribution has a smaller variance
# just simulate it directly

nbiRan <- rnbinom(n=1000,size=10,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))

nbiRan <- rnbinom(n=1000,size=0.1,mu=5)
qplot(nbiRan,color=I("black"),fill=I("goldenrod"))

#estimating paramaters from data

#p(data|hypothesis) is the standard approach for null hypothesis tests.

#Model paramaters can be thought of as a hypothesis about the distribution of the data: p(data|paramaters)

#This would be a goodness of fit test for data to a particular statistical distribution.

#More useful might be p(paramaters|data). For a given set of data, what is the probability that a particular statistical distribution (such as a normal with a specified mean and standard deviation), provides a fit to these data?

# Clearly, we want paramaters that maximize this probability. The paramaters that fit this definition are maximum likelihood estimators.

#Here is a simple example:

  library(MASS)
data <- c(100,100,104,99)
z <- fitdistr(data,"normal")
print(z)

#For this procedure:

#  Select a model that is appropriate for the data
#Use fitdistr to find maximum likelihood estimators for the paramaters.
#Use those paramaters to either plot the density function or simulate new data.

#Here are a few data from Lauren Ash’s dissertation: snout-vent length (SVL) measurements for 6 specimens of green frogs (Lithobates clamitans) collected from Berlin Pond in 2016.

frog_data <- c(30.15,26.3,27.5,22.9,27.8,26.2)

# get and print model parameters assuming a normal distribution
z<- fitdistr(frog_data,"normal")
print(z)

# plot the density function for the normal and annotate the plot with the original data
x <- 1:100
g_density <- dnorm(x=x,mean=z$estimate["mean"],sd=z$estimate["sd"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001)

# now do the same for a gamma distribution, which has a shape and rate parameter as outputs from fitdistr
z<- fitdistr(frog_data,"gamma")
print(z)

# plot the density function for the gamma and annotate the plot with the original data
x <- 1:100
g_density <- dgamma(x=x,shape=z$estimate["shape"],rate=z$estimate["rate"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001,color="red")



