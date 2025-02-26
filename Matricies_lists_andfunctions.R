#Matricies and lists
# 4/2/25
#SS


# a matrix is an atomic vector that is organized into rows and columns
my_vec <- 1:12
m <- matrix(data=my_vec, nrow=4) #two parameters,data and then dimensions
print(m)

m <- matrix(data=my_vec, ncol=3)
print(m)

#but! this matrix goes top to bottom not left to right, need to add another parameter
m <- matrix(data=my_vec, nrow=4, byrow=TRUE) #byrow is normally false
print(m)

#lists are atomic vectors but each element can hold different types and sizes
#can also have different data types in one list
my_list <- list (1:10, matrix(1:8, nrow=4, byrow=TRUE), letters[1:3], pi)
str(my_list)
print(my_list)
#hard thing about lists is pulling things out of a list thats been created


#using [] gives you a single item which is of type list
my_list[4]
#mylist[4] - 3  ERROR, [] gives you list component but does not give you the actual item
#gives you a smaller list with one item so have to use the [[]] syntax to get the item
my_list[[4]] - 3

my_list2 <- list(tester)

my_list2$little_m[2,3] #get row 2 column 3
my_list2$little_m #get the whole metrix
my_list2$little_m[2,] #show second row all columns
my_list2$little_m[,2] #show second column all wors
my_list2$little_m[,] #show the whole matrix
my_list2$little_m[] #will do the same as the prev line
my_list2$little_m[2] #only given single number not a dimension, reverts and treats it as
#an atomic vector that it originally was

#the "unlist" strings everything back into a single atomic vector, coercion is used
#if there are mixed data types
unrolled <- unlist(mylist2)
print(unrolled)


#the most common use of a list: output from a linear model is a list

library(ggplot2)
y_var <- runif(10)
x_var <- runif(10)
my_model <- lm(y_var~x_var) # ~ indicates variables that are predicated on each other
qplot(x = x_var, y = y_var)

#look at output in myModel, full results in summary
print(summary(my_model))
#will need to drill down to get what we want
str(summary(my_model))
#list of statistical objects will be returned, want to look at coefficients
summary(my_model)$coefficients
summary(my_model)$coefficients["x_var", "Pr(>|t|)"]
summary(my_model)$coefficients[2,4]

u <- unlist(summary(my_model))
print(u)
my_slope <- u$coefficients2
my_pval <- u$coefficients2

#again statistical output will be buried in a list so we need to dig it out to get stat values


#DATA FRAMES: specialized kind of list, different atomic vectores of different types
var_a <- 1:12
var_b <- rep(c("con", "LowN", "HighN"), each = 4)
var_c <- runif(12)
d_frame <- data.frame(var_a, var_b, var_c)
print(d_frame)
str(d_frame=)

#adding rows into an existing data frame --> pass in a list (cant do w/ atomic vector)

new_data <- list(var_a=13, var_b="HighN", var_c=0.668)
print(new_data)
str(new_data)

d_frame <- rbind(d_frame, new_data)
str(d_frame)
tail(d_frame)

### Data Frames
# a data frame is a list of equal-lengthed vectors, each of which is a column

var_a <- 1:12
var_b <- rep(c("Con","LowN","HighN"),each=4)
var_c <- runif(12)
d_frame <- data.frame(var_a,var_b,var_c)
print(d_frame)
str(d_frame)

# add another row with rbind
# make sure you add a list, with each item corresponding to a column

# newData <- data.frame(list(varA=13,varB="HighN",varC=0.668),stringsAsFactors=FALSE)
new_data <- list(var_a=13,var_b="HighN",var_c=0.668)
print(new_data)
str(new_data)

# now bind them
d_frame <- rbind(d_frame,new_data)
str(d_frame)
tail(d_rame)


# adding another column is a little easier

#newVar <- data.frame(varD=runif(13))
new_var <- runif(13)
d_frame <- cbind(d_frame,new_var)
head(d_frame)

### Important Distinctions Between Lists and Matrices

# create a matrix and data frame with same structures
z_mat <- matrix(data=1:30,ncol=3,byrow=TRUE)
z_dframe <- as.data.frame(z_mat) # coerce it

str(z_mat)    # an atomic vector with 2 dimensions
str(z_dframe) # note horizontal layout of variabes!

head(z_dframe) # note automatic variable names
head(z_mat) # note identical layout

# element referencing is the same in both
z_mat[3,3]
z_dframe[3,3]

# so is column referencing

z_mat[,3]
z_dframe[,3]
z_dframe$V3 # note use of $ and named variable column
# and row referencing
z_mat[3,]
z_dframe[3,] # note variable names and row number shown

# what happens if we reference only one dimension?

z_mat[2] # takes the second element of atomic vector (column fill)
z_dframe[2] # takes second atomic vector (= column) from list
z_dframe["V2"]
z_dframe$V2 # <- the $ references a variable not a string


### Eliminating missing values

# use complete.cases with atomic vector
zd <- runif(10)
zd[c(5,7)] <- NA
print(zd)

complete.cases(zd)

zD[complete.cases(zd)] # clean them out

which(!complete.cases(zd)) # find NA slots

# use with a matrix

m <- matrix(1:20,nrow=5)
m[1,1] <- NA
m[5,4] <- NA
print(m)

m[complete.cases(m),]

# now get complete cases for only certain columns!
m[complete.cases(m[,c(1,2)]),] # drops row 1
m[complete.cases(m[,c(2,3)]),] # no drops
m[complete.cases(m[,c(3,4)]),] # drops row 4
m[complete.cases(m[,c(1,4)]),] # drops 1&4


### Techniques for assignments and subsetting matrices and data frames

# same principle applied to both dimensions of a matrix
m <- matrix(data=1:12,nrow=3)
dimnames(m) <- list(paste("Species",LETTERS[1:nrow(m)],sep=""),paste("Site",1:ncol(m),sep=""))
print(m)

# subsetting based on elements
m[1:2,3:4]
# same subsetting based on character strings (but no negative elements)
m[c("SpeciesA","SpeciesB"), c("Site3","Site4")]

# use blanks before or after comma to indicate full rows or columns
m[1:2, ]

m[ ,3:4]

# use logicals for more complex subsetting

# e.g. select all columns for which the totals are > 15

# first try this logical
colSums(m) > 15
m[ , colSums(m) > 15]


# e.g. select all rows for which the row total is 22
m[rowSums(m)==22, ]

# note == for logical equal and != for logical NOT equal
m[rowSums(m)!=22, ]

# e.g., choose all rows for which numbers for site 1 are less than 3
# AND choose all columns for which the numbers for species A are less than 5

# first, try out this logical for rows
m[ ,"Site1"]<3

# add this in and select with all columns
m[m[ ,"Site1"]<3, ]

# and try this logical for columns
m["SpeciesA", ]<5

# add this in and select with all rows
m[ ,m["SpeciesA", ]<5]

# now combine both
m[m[ ,"Site1"]<3,m["SpeciesA", ]<5]

# and compare with full m
print(m)


# caution! simple subscripting to a vector changes the data type!
z <- m[1, ]
print(z)
str(z)

# to keep this as a matrix, must add the drop=FALSE option

z2 <- m[1, ,drop=FALSE]
print(z2)
str(z2)

# caution #2, always use both dimensions, or you will select a single matrix element

m2 <- matrix(data=runif(9),nrow=3)
print(m2)
m2[2, ]

# but now this will just pull the second element
m2[2]

# probably should specify row and column indicators
m2[2,1]
# also use logicals for assignments, not just subsetting
m2[m2>0.6] <- NA
print(m2)


# A few changes for working with data frames:
# need to know the name of the file you want, might also need to give a path name
#header = true means look in the first row of the data set to make column names
#sep - character in each row that sepaarates 1 column to the next
data <-read.csv(file="antcountydata.csv",header=TRUE,sep=",")
str(data)

# the data frame is a list of vectors, so it is set up like a matrix
data[3,2]

# you can specify just the column names

data_names <- data[c("state","county")]
str(dataNames)

# or in matrix style
data_names <- data[ ,c("county", "ecoregion")]
str(data_names)


# as before, with matrices, selecting only a single column changes it
# from a data frame to a vector
data_names <- data[ ,"county"]
str(data_names)

## Data curation
#* GitHub repository
#* Metadata
#* [Metadata template](https://gotellilab.github.io/Bio381/Scripts/Feb02/ExcelDataTemplate.xlsx)
#Example of Lauren's data

## Exporting and importing data

#First create a tiny data set in Excel:

# comments at the top
# beaucoup metadata: makiing this in an excel file
#ID, Treatment, Biomass, Notes
#1, Control, 30.3,
#2, HighN, 13.0,
#3, HighN, NA, broken scale
#4, Control, 35.3,

#- Save as .csv
#- Inspect in RStudio Editor

### Use `read.table` to bring in data
my_data <- read.table(file="path/to/data.csv",
                      header=TRUE,
                      sep=",",
                      comment.char="#")

# inspect object
str(my_data)

# now add a column
my_data$newVar <- runif(4)
head(my_data)


### Use `write.table` to export to a data file
write.table(x=my_data,
            file="Path/To/OutputFileName.csv",
            HEADER=TRUE,
            sep=",")


### Functions in R
#Everything in R is a function
# making user defined functions

sum(3,2) #an prefix function
3+2 # an operator which is actially a function
'+'(3,2)

y <- 3
print(y)
'<-'(yy,3)
print(yy)

sd #shows the code for the function
sd(c(3,2)) # call the function with parameters
# sd() # call function with default values for parameters

### The Anatomy Of A User-Defined Function
functionName <- function(parX=defaultX,parY=defaultY,parZ=defaultZ) {

  # curly bracket open marks the start of the function body

  # Body of the function goes here
  # Lines of R code and annotations
  # May also call functions
  # May also create functions
  # May also create local variables

  return(z)  # returns from the function a single element (z could be a list)

  # curly bracket close marks the end of the function body
}

# prints the function body
functionName

# calls the function with default values and returns object z
functionName()

# calls the function with user-specified values for each paramater
functionName(parX=myMatrix,parY="Order",parZ=c(0.3,1.6,2,6))
### Stylistic Conventions For Programming Functions
#Use prominent hash character fencing at start and at finish
#Give a header with the function name, description input, and output
#names inside functions can be short
#functions should be simple and short, no more than a screenful
#if too complex, break into multiple shorter functions
#provide default values for all function arguments
#ideally use random numbers as defaults for rapid testing

### A Sample Function For Hardy-Weinberg Equilibrium

##################################################
# FUNCTION: HardyWeinberg
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB
#-------------------------------------------------
HardyWeinberg <- function(p=runif(1)) {
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}
##################################################
HardyWeinberg()
HardyWeinberg(p=0.5) # pass to the parameter the value p
# print(p) # error because p does not exist in the global environment
pp <- 0.6 # variable pp is stored in global environment
HardyWeinberg(p=pp) # pass contents of variable pp to function parameter p
print(pp) # variable pp is still stored in memory


### Use Multiple `return()` Statements For Different Possible Return Values

##################################################
# FUNCTION: HardyWeinberg2
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB
#-------------------------------------------------
HardyWeinberg2<- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    return("Function failure: p must be >= 0.0 and <= 1.0")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}
##################################################
HardyWeinberg2()
HardyWeinberg2(1.1) # OK, print error to screen
z <- HardyWeinberg2(1.1) # uggh no error printed
print(z) # Error message was saved to variable z!


### Use `Stop` For True Error Trapping
##################################################
# FUNCTION: HardyWeinberg3
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB
#-------------------------------------------------
HardyWeinberg3<- function(p=runif(1)) {
  if (p > 1.0 | p < 0.0) {
    stop("Function failure: p must be >= 0.0 and <= 1.0")
  }
  q <- 1 - p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits=3)
  return(vecOut)
}
##################################################
HardyWeinberg3()
#  z <- HardyWeinberg3(1.1)

my_func <- function(a=3,b=4) { #this { indicates the start of the func. body
  z <- a + b
  return(z)
}
my_func()

my_funcBad <-function(a=3) {
  z <- a + b
  return(z)
}
my_func_bad() # crashes because it can't find b
b <- 100
my_func_bad() # OK now because b exists as a global variable

# But it is fine to create variables locally
my_func_ok <- function(a=3) {
  bb <- 100
  z <- a + bb
  return(z)
}

my_func_ok() # no problems now
print(bb) # but this variable is still hidden from the global environment

##################################################
# FUNCTION: fit_linear
# fits simple regression line
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#-------------------------------------------------
fit_linear <- function(x=runif(20),y=runif(20)) {
  my_mod <- lm(y~x) # fit the model
  my_out <- c(slope=summary(my_mod)$coefficients[2,1],
              p_value=summary(my_mod)$coefficients[2,4]) #summary of points in my mod
}
  plot(x=x,y=y) # quick and dirty plot to check output
  return(my_out)
##################################################
fit_linear()

##################################################
# FUNCTION: fit_linear2
# fits simple regression line
# inputs: numeric vector of predictor (x) and response (y)
# outputs: slope and p-value
#-------------------------------------------------
  ##################################################
  # FUNCTION: fit_linear2
  # fits simple regression line
  # inputs: numeric vector of predictor (x) and response (y)
  # outputs: slope and p-value
#-------------------------------------------------
fit_linear2 <- function(p=NULL) {
  if(is.null(p)) {
    p <- list(x=runif(20),y=runif(20))
  }
my_mod <- lm(p$x~p$y) # fit the model
my_out <- c(slope=summary(my_mod)$coefficients[2,1],
            p_value=summary(my_mod)$coefficients[2,4])
plot(x=p$x,y=p$y) # quick and dirty plot to check output
return(my_out)
  }

  ##################################################
fit_linear2()
my_pars <-list(x=1:10,y=sort(runif(10)))
fit_linear2(my_pars)

z <- c(runif(99),NA)
mean(z) # oops, mean doesn't work if there is an NA
mean(x=z,na.rm=TRUE) # change the default value for na.rm
mean(x=z,na.rm=TRUE,trim=0.05) # check out the "trim" option in help
l <- list(x=z,na.rm=TRUE,trim=0.05) # bundle paramaters as a list
do.call(mean,l) # use the do.call function with the function name and the parameter list


### Logical operators
# Simple inequalities
5 > 3
5 < 3
5 >= 5
5 <= 5
5 == 3
5 != 3

# use & for AND
FALSE & FALSE
FALSE & TRUE
TRUE & TRUE
5 > 3 & 1!=2
1==2 & 1!=2

# use | for OR
FALSE | FALSE
FALSE | TRUE
TRUE | TRUE
1==2 | 1!=2

# works with vectors
1:5 > 3
a <- 1:10
b <- 10:1
a > 4 & b > 4

# use "long form" to evaluate left to write until a the first true/false is evaluated
# evaluates all elements and gives a vector of results
a < 4 & b > 4

# evaluates until the first logical result is created
a < 4 && b > 4

# similar format for "long form" for OR

# vector result
a < 4 | b > 4

# single result
a < 4 || b > 4


# xor for exclusive or testing of vectors
# works for (TRUE FALSE) but not (FALSE FALSE) or (TRUE TRUE)
xor(FALSE,FALSE)
xor(FALSE,TRUE)
xor(TRUE,TRUE)
a <- c(0,0,1)
b <- c(0,1,1)
xor(a,b)

# compare with a | b
# works for (TRUE FALSE) or (TRUE TRUE)
a | b

### Set Operations
# boolean algebra on sets of atomic vectors (logical,numeric, character strings)

a <- 1:7
b <- 5:10

# union to get all elements
union(a,b)

# intersect to get common elements
intersect(a,b)

# setdiff to get distinct elements in a
setdiff(a,b)

setdiff(b,a)

# setequal to check for identical elements
setequal(a,b)

# more generally, to compare any two objects
z <- matrix(1:12,nrow=4,byrow=TRUE)
z1 <- matrix(1:12,nrow=4,byrow=FALSE)

# This just compares element by element
z==z1

# Use identical for entire structures
identical(z,z1)
z1 <- z
identical(z,z1)

# most useful for if statements is %in% or is.element
# these two are equivalent, but I prefer the %in% for readability
d <- 12
d %in% union(a,b)
is.element(d,union(a,b))

# check for partial matching with vector comparisons

d <- c(10,12)
d %in% union(a,b)
d %in% a

### `If` statements
if (condition) {expression1}
if (condition) {expression1} else {expression2}

if (condition1) {expression1} else
  if (condition2) {expression2} else

#note that final unspecified `else` captures rest of the (unspecified) conditions
#`else` statement must appear on the same line as the expression
# typically enclose multiple statements in brackets `{}` for compound expression

z <- signif(runif(1),digits=2)
print(z)
z > 0.5
if (z > 0.5) cat(z, "is a bigger than average number","\n")

if (z > 0.8) cat(z,"is a large number","\n") else
  if (z < 0.2) cat(z,"is a small number","\n") else
  {cat(z,"is a number of typical size","\n")
     cat("z^2 =",z^2,"\n")}

# if statement requires a single logical value. With a vector,
# it will assign TRUE/FALSE based on very first element only.

z <- 1:10

# this does not do anything
if (z > 7) print(z)

# probably not what you want
if (z < 7) print(z)
#in the old days it only would make a comparison on the first element

# use subsetting!
print(z[z < 7])


# `ifelse` to fill vectors
ifelse(test,yes,no)

#test is an object that can be coerced to a logical yes/no
#yes return values for true elements of test
#no return vales for false elements of test
#Suppose we have an insect population in which each female lays, on average, 10.2 eggs, following a Poisson distribution with $\lambda = 10.2$. However, there is a 35% chance of parasitism, in which case no eggs are laid. Here is the distribution of eggs laid for 1000 individuals:

tester <- runif(1000) # start with random uniform elements
eggs <- ifelse(tester>0.35,rpois(n=1000,lambda=10.2),0)
hist(eggs)
#if the random number is <0.35 (FALSE) then 0 is the else, rpois (poisson distribution)
#is the first statement being TRUE
#can operate on a vector!!!!

#Suppose we have a vector of p values (say from a simulation), and we want to create a vector to highlight the significant ones for plotting purposes.

pVals <- runif(1000)
z <- ifelse(pVals<=0.025,"lowerTail","nonSig")
z[pVals>=0.975] <- "upperTail"
table(z)


# Here is how I would probably do this
z1 <- rep("nonSig",1000)
z1[pVals<=0.025] <- "lowerTail"
z1[pVals>=0.975] <- "upperTail"
table(z1)

######################################################################







