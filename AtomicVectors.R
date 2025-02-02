#Introduction to R scripts
# 1/28/25
#SS

#using the assignment operator
x <- 5 # preferred
y = 4 # legal but not used except in function defaults
y = y + 1.1
print(y)
y <- y + 1.1
print(y)

z <- 3 #begin with lower case letters
plantHeight <- 10 #option "camelCaseFormatting"
plant.height <- 4.2 #avoid periods
plant_height <- 3.3 #optimal "snakecase formmatting"
. <- 5.5 # reserve this for a generic temporary variable (more later)
print(.)

# c() always "flattens" to an atomic vector

z <- c("perch", "bass", "trout")
print(z)
typeof(z)

#use both with an internal quote
z <- c("this is literally only 'one' character string", 'a second')
print(z)
typeof(z)
is.character(z)

#building logicals
#boolean, not with quotes, all caps
z <- c(TRUE, TRUE, FALSE)
print(z)
typeof(z)
is.logical(z)
is.integer(z)

z <- c(1.1, 1.2, 3, 4.4)
typeof(z)
is.numeric(z)
z <- as.character(z)
print(z)
typeof(z)

z <- runif(5)
names(z)
print(z)

#add names later after variable is created
z <- runif(5)
names(z) <- c("chow","pug", "beagle", "greyhound", "akita", NA)
print(z)
print(z[2]) #prints second element from the vector
print(z["pug"]) # prints the index that "pug" belongs to
#add names when cariable is built (with or without quotes)
z2 <- c(gold=3.3, silver=10, lead=2)
print(z2)

is.na(z) #tells you where the NAs are in the vector
mean(z) #will not work bc of NA
is.na(z) #again where are the NAs
!is.na(z) #tell you where the NAs are not
mean(!is.na(z)) #us ! for NOT missing values
mean(!is.na(z)) #wrong answer based on TRUE FALSE!

man(z[!is.na(z)]) #correct use of indexing


#Nan, -Inf, and Inf feom numeric division
z <- 0/0  #NaN
typeof(z)
print(z)
z <- 1/0 #Inf infinity
z <- -1/0 #-Inf
print(z)

a <- c(2, 2.0)
print(a)
typeof(a) #technically integer coerced to numeric
b <- c("purple", "green")
typeof(b)

d <- c(a, b)
print(d)
typeof(d)

# "mistatkes" in numeric variables convert to strings
#useful when working with logical variables

#comparison operators yield logical result
a > 0.5

# do math on a logical and it coerces to an integer!
#HOW MANY elements are greater than 0.5?
sum(a > 0.5) #sums up #TRUE and FALSE to get a numeric

#what proportion of the vector elements are greater than 0.5
mean(a > 0.5)

#break down the result
. <- 0.5
print(.)
. <- as.integer(.)
print(.)
print(sum(.))
print(mean(.))

mean(rnorm(1000) > 2)
mean(rnorm(10000) > 2)

#adding a constant to a vector
z <- c(10,20,30)
z + 1
#adding vectors
y <- c(1,2,3)
z + y
z^2
x <- c(1,2)
#adding vectors that are not the same size = recycling
z + x

# Atomic Vectors II
# 2025-01-30
# Sarah Stover

# create an empty vector, specify mode & length
z <-vector(mode="numeric",length=0)
print(z)

# now add elements to it
z <-c(z,5)
print(z)
#this dynamic string is very slow

# has 100 )s in a numeric order
z <- rep(0-100)
head(z) #first 6 zeros
z <- rep(NA,100)
head(z)
typeof(z) #coersion will occur naturally

z[1] <- "Washington" #this is a character so now all of z will be coerced into a character
head(z)
typeof(z)
typeof(z[2]) #changes whole thing --> atomic vectors have same thing in them

my_vec <- runif(100)
tail(my_vec)
my_names <- paste("Species", seq(1:length(my_vec)), sep="")
#make a sequence starting at the number 1 to the length of my current vector
#invoking names to the vector and then assigning names from the variables
names(my_vec) <- my_names
head(my_vec)
tail(my_vec)
str(my_vec)
#rep for repeating elements
rep(0.5, 6) # give the element (or vector) and # of times to repeat
rep(x=0.5,times=6) #using arg names is better for readability
rep(times=6,x=0.5) #if arg names included, order doesnt matter

my_vec <- c(1,2,3)
rep(x=my_vec, times=2) #applying to entire vector
rep(x=my_vec, each=2) #repeat each element individually
rep(x=my_vec, times=my_vec)

seq(from=2, to=4) #set limits for integer sequence
2:4 #infix function, shortcut w/ no explicit function wrappers
`:`(2,4) #does the same thing
#adding more parameters to the sequence
seq(from=2, to=4, by=0.5)
x <- seq(from=2, to=4, length=7)
my_vec <- 1:length(x)
print(my_vec)
seq_along(my_vec) #much faster for models and big data
seq_len(5) #also faster than 1:5

runif(2) #5 random uniform values between 0-1 r uniform!
runif(n=3,
      min=100,
      max=1000)

##Random num generator
rnorm(6)
rnorm(n=5, mean= 1000, sd=30) #ah my old friend)
#Explore distributions by sampling and plotting
install.packages("ggplot2")
library(ggplot2)
z <- runif(1000)
qplot(x=z)
z <- rnorm(1000)
qplot(x=z)

long_vec <- (10)
typeof(long_vec)
str(long_vec)

sample(x=long_vec)#wioth no toher params, this reorders the vector
sample(x=long_vec, size=3) #specify a number (sample without replacement)
sample(x=long_vec, size=16, replace=TRUE) #sample with replacement, generates duplicates
my_weights <- c(rep(20,5), rep(100,5)) #create a set of non-zero positive weights (int or real)
#this provides a second vector that provides the weights of the characters in the first vector
#will get many more values of the high numbers than the low values bc we have given them higher weights
print(my_weights)
sample(x=long_vec, replace=TRUE, prob=my_weights) #sampling with replacement and weights
sample(x=long_vec, replace=FALSE, prob=my_weights)

# pay attention to w/ or w/out replacement, equal probable or with weights


z <-c(3.1, 9.2, 1.3, 0.4, 7.5)
#possible index values
z[c(2,3)]
#neg index values to exclude elements
z[-c(2,3)]
#create a vector of logical elements to select conditions
z[z<3]
tester <- z<3
print(tester)
z[tester] #trues and falses from line 219 will come back as the real num that fit TRUE
which(z>3) #get out the indexes that have values that meet the inequality
z[which(z<3)] #get the values of the indexes


z[(-(length(z):length(z)-2))] #sequence depends on the length of the vector itself,
#but not the first two 2 element






