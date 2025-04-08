# --------------------------------------
# FUNCTION calc_sr
# required packages: none
# description: calculates species richness
# inputs: csv file
# outputs: total # of unique species or species richness
########################################
calc_sr <- function(df){
# assign parameter defaults
  if(is.null(typeof(df))){
    print("data frame does not exist")
  }
# function body
#df <- read.csv(df)
sr <- length(unique(df$scientificName))
print(sr)
return(sr)
#return(print('...checking function: calc_sr()'))

} # end of function calc_sr
# --------------------------------------
# calc_sr()
