
#Within each year’s folder, you will only be using a file from each year labeled
#“countdata” in its title. Using for loops, iterate through each year’s folders
#to gather the file names of these “countdata” .csv files.
library(devtools)
library(dplyr)
#install_github("ngotelli/upscaler", force=TRUE)
library(upscaler)

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
#build_function(c("data_clean",
#                 "extract_year",
#                 "year_abundance",
#                 "calc_sr",
#                 "regression_model",
#                 "gen_histo"))

#Source all function templates as a batch operation
#source_batch("Functions")

#Run each function template
#data_clean()
#extract_year()
#year_abundance()
#calc_sr()
#regression_model()
#gen_histo()

#------------------------------------------------------------------------------
#Within each year’s folder, you will only be using a file from each year labeled
#“countdata” in its title. Using for loops, iterate through each year’s folders
#to gather the file names of these “countdata” .csv files.

#establish main_dir with all the bird data
main_directory <- "NEON_count-landbird"

#lists all files from main dir
all_items <- list.files(main_directory, full.names = TRUE)
#filers out only the directories from main dir
subdir_list <- all_items[file.info(all_items)$isdir]
print(subdir_list)

# list for countdata file names (empty)
countdata_list <- c()
for (dir in subdir_list) {
  #get all the file names from the directory
  all_files<- list.files(dir, full.names = TRUE)
  #find all the ones that have "count data in the name"
  countdata_file <- all_files[grep("countdata", all_files)]
  #reading the csv file into the environment
  data <- read.csv(countdata_file)
  #adds the name to the empty countdata file names list
  countdata_list <- append(countdata_list, countdata_file)
  #cleans dataset
  countdata_file <- data_clean(countdata_file)

}

#checking!
print(countdata_list)

#Create an initial empty data frame to hold the above summary statistics-you
#should have columns for the file name, one for abundance, one for species
#richness, one for year, and the regression model summary statistics.
summary_df <- data.frame(file_name = character(0),
                         abundance = numeric(0),
                         species_richness = numeric(0),
                         year = numeric(0),
                         regression_summary_stat = numeric(0))








#Using a for loop, run your created functions as a batch process for each folder,
#changing the working directory as necessary to read in the correct files,
#calculating summary statistics with your created functions, and then writing
#them out into your summary statistics data frame.


