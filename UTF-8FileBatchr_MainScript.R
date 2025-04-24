## Functions: File Batch Processing
## 2025-04-15
## Grace (Rei) Jia

# function name: filebatchr()

# Step 1: .csv file -- table.read() --> data frame --> build script file (.R)

# Step 2: from script.R --> can either make: (1) a plot OR (2) a list (out 1, out 2, out 3)
## - we want to be able to run this loop several times

# Step 3: we want to take the list from step 2 and put it into a summary data frame
# - there will be three columns in this data frame (out 1, out 2, and out 3)
# - the output from the first csv is going to fill the first row of this summary data frame
# - second and third .csv files will do the same thing but in their respective columns and fill data frame
# - if there are more than 3 outputs, you have to make sure there is enough space to finish the operation
# - need additional columns in this data frame because it doesn't tell us anything from the original files (need column for metadata/.csv files)
# - want a column for FILE NAME, # of ROWS that were in the original data file, row ID

# Step 4.1: Sample data frame -
# Col one: File Name | Col 2: # Rows | Col 3: ID | Col 4: Out 1 | Col 5: Out 2 | Col 6: Out 3

# Step 4.2: Plots
# Make plots from the data using a summary plot

# --------------------------------------------------------------------------

library(upscaler)
library(ggplot2)

set_up_log()
add_folder()
source_batch(folder="Functions")
#create_toy_data_files(nrow=15, ncol = 10, nfiles=8)

# folder 'OriginalData' created
# folder 'CleanedData' created
# folder 'Scripts' created
# folder 'Functions' created
# folder 'Plots' created
# folder 'Outputs' created
# folder 'DataObjects' created
# folder 'Markdown' created

build_function("create_toy_data_files")

#Function file "Functions/Createtoydatafiles.R" built.

build_function("crunch_data")

list.files()
list.files(pattern="\\.")
basename(list.files(path="CleanedData/ToydataFiles",
                  pattern="\\.csv$",
                  full.names=TRUE))

####################

list.files(pattern="\\.")

# create vector of file names with paths
file_names <- list.files(pattern="\\.csv$",
              path="CleanedData/ToyDataFiles",
              full.names=TRUE)
crunch_cols <- c(4,5)
param_names <- c("avg","skew","weird")

# use lapply to run it all with two lines of code
z <- lapply(file_names, read.table,sep=",") # lapply wants the LIST and the FUNCTION that will be applied to this function
# take output that we just created that operated on file names and use this input to 'crunch_data' which will go into new list structure.
final <- lapply(z,crunch_data)


# do the work in a for loop
output_df <- as.data.frame(matrix(rep(NA,length(file_names)*length(param_names)),nrow=length(file_names),ncol=length(param_names)))

names(output_df)=param_names

nobs <- rep(NA,length(file_names)) # empty vector for row counts

for (i in 1:length(file_names)){
  df <- read.table(file=file_names[[i]],
                   header = TRUE,
                   sep=",")
  . <- crunch_data(df=df,
                   crunch_cols=unlist(crunch_cols),
                   param_names = param_names)

  output_df[i,] <- .
  nobs[i] <- nrow(df)
}

output_df

# add initial metadata columns (ID,filename,nobs)
output_df <- cbind(ID=1:length(file_names),file=basename(unlist(file_names)),nobs=nobs,output_df)

output_df

# filebatcher(file_names=file_names,
#             fun=crunch_data,
#             crunch_cols=crunch_cols,
#             param_names=param_names)
