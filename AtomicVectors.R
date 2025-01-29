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
. <- a 0.5
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












