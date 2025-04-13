# --------------------------------------
# FUNCTION year_abundance
# required packages: none
# description: calculates the number of birds seen
# inputs: df
# outputs: number of birds seen based on the df column
########################################
year_abundance <- function(df=NULL){

# assign parameter defaults
  if(is.null(df)){
    print("data frame does not exist")
    return(NULL)
  }
 # function body
#df <- read.csv('df')
total_sum <- sum(df$pointCountMinute)
print(total_sum)
return(total_sum)
         #return(print('...checking function: year_abundance()'))

} # end of function year_abundance
# --------------------------------------
# year_abundance()

