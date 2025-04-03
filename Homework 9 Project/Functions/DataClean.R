# --------------------------------------
# FUNCTION data_clean
# required packages: none
# description: this function goes into a list of .csv files and gets rid of any columns that have NAs
#if there are some columns with one or 2 NAs then you need to change the settings
# inputs: a data frame .csv file
# outputs: the same data frame but minus rows with NAs
########################################
data_clean <- function(x=NULL){

# assign parameter defaults
if (is.null(x)) {
  print("your data frame does not exist! try checking the path or file name")
}

# function body: need to get rid of rows with NAs in 2 catagories:
  # of species
  # of birds
#based on the tables cannot just get rid of rows that have NAs bc there is a
#column that is majority NAs
x <- data %>%
  #only removing rows with NAs in count and scientific name/species
  filter(!is.na(x$pointCountMinute) & !is.na(x$scientificName))

return(print('...checking function: data_clean(x)'))
return(x)

} # end of function data_clean
# --------------------------------------
# data_clean()
