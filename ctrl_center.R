
#Within each year’s folder, you will only be using a file from each year labeled
#“countdata” in its title. Using for loops, iterate through each year’s folders
#to gather the file names of these “countdata” .csv files.

library(devtools)
install_github("ngotelli/upscaler", force=TRUE)
library(upscaler)

#assigning data folder to a name
main_folder <- "NEON_count-landbird"

# Get a list of all subdirectories (years) within the main folder
year_folders <- list.dirs(main_folder, full.names = TRUE, recursive = FALSE)

# Initialize a list to store the data frames
all_countdata_files <- list()

# Loop through each folder (for each year)
for (year_folder in year_folders) {

  # Get a list of all CSV files in the current folder containing "countdata" in the file name
  countdata_files <- list.files(year_folder, pattern = "countdata.*\\.csv$", full.names = TRUE)

  # Loop through each file
  for (file in countdata_files) {

    # Read the CSV file into the environment
    data <- read.csv(file)

    # Store the data in the list, using the file name (without the path) as the list name
    file_name <- basename(file)
    all_countdata_files[[file_name]] <- data

  }
}

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
build_function("fit_regression") # creates an R script template for the function
source("Functions/FitRegression.R") # sources that script to load function in memory

# Open the file in Functions folder: FitRegression.R
fit_regression() # runs the new function with its default values

#Create function templates as a batch operation
build_function(c("data_clean",
                 "extract_year",
                 "year_abundance",
                 "calc_sr",
                 "regression_model",
                 "gen_histo"))

#Source all function templates as a batch operation
source_batch("Functions")

#Run each function template
data_clean()
extract_year()
year_abundance()
calc_sr()
regression_model()
gen_histo()


#Create an initial empty data frame to hold the above summary statistics-you
#should have columns for the file name, one for abundance, one for species
#richness, one for year, and the regression model summary statistics.

#Using a for loop, run your created functions as a batch process for each folder,
#changing the working directory as necessary to read in the correct files,
#calculating summary statistics with your created functions, and then writing
#them out into your summary statistics data frame.



