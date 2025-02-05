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




















