#this is a test of the dogfood files
#create our own crunch fucntion

#1) Summary of data
#2) linear regression
#3) create multiple gglot pdf files

# --------------------------------------
# FUNCTION crunch_data
# required packages: none
# description: operate on a single data frame
# inputs: df = dataframe
#         crunch_cols = numeric vector of columns to use
#         param_names = character vector of output labels
# outputs: results = list of output values
########################################
crunch_data <- function(df=NULL, crunch_cols = NULL, param_names=NULL){

  # assign parameter defaults
  if (is.null(df) | is.null(crunch_cols) | is.null(param_names)) {
    df <- data.frame(runif(10),runif(10),runif(10))
    crunch_cols <- list(2,3)
    param_names <- list("avg", "skew", "weird")
  }

  # function body
  avg <- mean(df[,2])
  skew <- sum(df[,2] - avg)^3/nrow(df)
  weird <- sum(df[,2]) +
    sum(df[,3]) + pi


  results <- list(avg, skew, weird)
  names(results) <- param_names

  return(results)

} # end of function crunch_data
# --------------------------------------
# crunch_data()

