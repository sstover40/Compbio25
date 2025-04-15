# --------------------------------------
# FUNCTION CreateToyDataFiles
# required packages: none
# description: build a set of toy csv files. what is in the columns for each csv has to be the same
# inputs: number of files, max rows, max col
# outputs: set of .csv files in a new subfolder
########################################
CreateToyDataFiles <- function(nrow = NULL,
                               ncol = NULL,
                               nfiles = NULL){
  if (is.null(nrow) | is.null(ncol) | is.null(nfiles)) {
    nrow = 10
    ncol = 10
    nfiles = 15
    }

# build file labels
  file_labels <- create_padded_labels(n=nfiles,
                                      string = "Toy_Data",
                                      suffix=".csv")

  #run for loop
  for( i in 1:nfiles){
  df <- as.data.frame(matrix(runif(nrow*ncol),
                            nrow=nrow,
                            ncol=ncol))
  #this is going to be the path to the file
  write.table(df, file=paste("CleanedData/ToyDataFiles/",
                             file_labels[i], sep=""))
  }


  l('...checking function: CreateToyDataFiles()')
  #using "l" saves it to the log
  return(file_labels)
}
# end of function CreateToyDataFiles
# -------------------------------------- the last line below runs the function
CreateToyDataFiles()
