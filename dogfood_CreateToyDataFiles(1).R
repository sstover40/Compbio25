# --------------------------------------
# FUNCTION create_toy_data_files
# required packages: none
# description: build a set of toy .csv files
# inputs: number of files, max rows, max columns
# outputs: a set of .csv files in a new subfolder
########################################
create_toy_data_files <- function(nrow=NULL,ncol=NULL,nfiles=NULL){

  # assign parameter defaults
  if (is.null(nrow) | is.null(ncol) | is.null(nfiles)) {
    nrow=15
    ncol=10
    nfiles=8
  }

file_labels <- create_padded_labels(n=nfiles, string="Toy_Data", suffix=".csv")

  # this way of making a data frame "coheres" the matrix into a data frame
  # - this is building a random matrix with 10 rows and 10 columns
  # - then it will get cohersed into a data frame as 10 separate atomic vectors that is making the data frame

for (i in 1:nfiles) {

    # build file labels
df <- as.data.frame(matrix(runif(nrow*ncol), # a matrix always needs an atomic vector!
                             nrow=nrow,
                             ncol=ncol))

write.table(df,file=paste("CleanedData/ToyDataFiles/",
                            file_labels[i],sep=""))

}

} # end of function create_toy_data_files
# --------------------------------------
create_toy_data_files()
