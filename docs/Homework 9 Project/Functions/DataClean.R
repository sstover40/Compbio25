# --------------------------------------
# FUNCTION data_clean
# required packages: none
# description: this function goes into a list of .csv files and gets rid of any columns that have NAs
#if there are some columns with one or 2 NAs then you need to change the settings
# inputs: a data frame .csv file
# outputs: the same data frame but minus rows with NAs
########################################
data_clean <- function(df = NULL) {
  # Check if input is NULL
  if (is.null(df)) {
    print("Data frame does not exist")
    return(NULL)
  }

  # Remove rows where pointCountMinute or scientificName is NA
  df_clean <- df[complete.cases(df[, c("pointCountMinute", "scientificName")]), ]

  print("...checking function: data_clean(df)")
  return(df_clean)
}

 # end of function data_clean
# --------------------------------------
# # data_clean()
#     # function body:
#     #want to rename files and also need to get rid of rows with NAs in 2 catagories:
#     # of species
#     # of birds
#     #based on the tables cannot just get rid of rows that have NAs bc there is a
#
#     #column that is majority NAs
#     df_clean <- df[,complete.cases("pointCountMinute", "scientificName" )]
#     #read the data frame
#     #only removing rows with NAs in count and scientific name/species
#
#     return(df_clean)
#     return(print('...checking function: data_clean(df)'))
