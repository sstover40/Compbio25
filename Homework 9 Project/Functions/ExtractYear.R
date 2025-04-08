# --------------------------------------
# FUNCTION extract_year
# required packages: none
# description: this extracts the year name from the file
# inputs: df or df file name
# outputs: the year in the file name
########################################
extract_year <- function(df){
  print(typeof(df))
#parameter defaults
  if(is.null(typeof(df))){
    print("data frame does not exist")
  }
# function body
#looks at file_name and gets the year using regular expressions
  year <- sub(".*(\\d{4})-.*", "\\1", df)
}
print(paste("Extracted year:", year))
return(year)
#return(print('...checking function: extract_year()'))

# end of function extract_year
# --------------------------------------
# extract_year()
