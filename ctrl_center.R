
#HOMEWORK 9 FULL CODE
#-------------------------------------------------------------------------------
#GETTING LIBRARIES OR INSTALLING PACKAGES

library(devtools)
library(dplyr)
#install_github("ngotelli/upscaler", force=TRUE)
library(upscaler)

#-------------------------------------------------------------------------------
#BUILDING FUNCTIONS

#Starting with pseudo-code, generate functions for
#1) Cleaning the data for any empty/missing cases
#2) Extract the year from each file name
#3) Calculate Abundance for each year (Total number of individuals found)
#4) Calculate Species Richness for each year(Number of unique species found)
#5) Run a simple regression model for Species Richness (S) vs. Abundance for every year
#6) Generate histograms for both Abundance and Species Richness (S) and store the plots
# build_function <- function (function_name=NULL,
#                            file_prefix=NULL,
#                            file_suffix=NULL)
#build_function("fit_regression") # creates an R script template for the function
#source("Functions/FitRegression.R") # sources that script to load function in memory
# Open the file in Functions folder: FitRegression.R
#fit_regression() # runs the new function with its default values
#Create function templates as a batch operation
# build_function(c("data_clean",
#                  "extract_year",
#                  "year_abundance",
#                  "calc_sr",
#                  "regression_model",
#                  "gen_histo"))

#Source all function templates as a batch operation
source_batch("Functions")

#Run each function template
data_clean()
extract_year()
year_abundance()
calc_sr()
regression_model()
gen_histo()

#-------------------------------------------------------------------------------
#GETTING FILE NAMES FROM DIRECTORIES

#Within each year’s folder, you will only be using a file from each year labeled
#“countdata” in its title. Using for loops, iterate through each year’s folders
#to gather the file names of these “countdata” .csv files.

#establish main_dir with all the bird data
#full path to main dir
main_dir <- '/Users/sarahstover/Desktop/Comp Bio /Compbio25/Homework 9 Project/NEON_count-landbird'

#lists all the dirs in the main_dir
subdir_list <- list.dirs(main_dir, full.names = TRUE, recursive = FALSE)
# list for countdata file names (empty)
countdata_list <- list()

#loops through each subdir
for (subdir in subdir_list) {
  #list of files in the subdir with relative path name rather than just file name
  files <- list.files(subdir, full.names = TRUE)
  #loops through this list to search for countdata files
  for (file in files) {
    #does it contain "countdata" in the file name?
    if (grepl("countdata", basename(file), ignore.case = TRUE)) {
     #MAKES A LIST OF THE FILES WITH FULL PATH NAME
      countdata_list <- append(countdata_list, file)
      #read the file into R
    }
  }
}
#will use countdata_list for all of the files I need to extract info from


#-------------------------------------------------------------------------------
# EMPTY SUMMARY DATA FRAME

#Create an initial empty data frame to hold the above summary statistics-you
#should have columns for the file name, one for abundance, one for species
#richness, one for year, and the regression model summary statistics.
summary_df <- data.frame(file_name = character(length(countdata_list)),
                         abundance = numeric(length(countdata_list)),
                         species_richness = numeric(length(countdata_list)),
                         year = numeric(length(countdata_list)),
                         regression= numeric(length(countdata_list)))

#-------------------------------------------------------------------------------
#FILLING OUT THE SUMMARY DATA FRAME

#Using a for loop, run your created functions as a batch process for each folder,
#changing the working directory as necessary to read in the correct files,
#calculating summary statistics with your created functions, and then writing
#them out into your summary statistics data frame.

i = 1 #this will index the files properly in the df
for (file in countdata_list) {
  #adding file name to the df
  summary_df$file_name[i]<- file
  #extracting the year, adding to the df
  summary_df$year[i] <- extract_year(file)
  #reading the file so abundance and sr can be calculated
  file <- read.csv(file, header = TRUE )
  #cleaning the file
  clean_file <- data_clean(file)
  #calculating abundance using function
  summary_df$abundance[i] <- year_abundance(clean_file)
  #calculating species richness using function
  summary_df$species_richness[i] <- calc_sr(clean_file)

  i <- i+1 #adding to the index
  }

#------------------------------------------------------------------------------
#Creating a histogram and calculating the Regression

