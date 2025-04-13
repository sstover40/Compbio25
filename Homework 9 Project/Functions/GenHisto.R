# --------------------------------------
# FUNCTION gen_histo
# required packages: none
# description: this makes a histogram using the summary_df
# inputs: a data-frame
# outputs: 2 ggplot2 histogram of species abundance and species richness
########################################

# Create histogram and add labels to bins
# Load necessary library
library(ggplot2)

gen_histo <- function(df=NULL){

  # assign parameter defaults
  if(is.null(df)){
    print("data frame does not exist")
    return(NULL)
  }
  # Plot the histogram for abundance
  abundance_plot <- ggplot(df, aes(x = as.factor(year), y = abundance)) +
    geom_bar(stat = "identity", fill = "#008080" ) +
    labs(x = "Year", y = "Abundance") +
    theme_minimal()

  # plot_2 <- ggplot(df, aes(x=year, y=species_richness)) +    #this graph is dealing with only 1 variable
  speciesRichness_plot <- ggplot(df, aes(x = as.factor(year), y = species_richness)) +
    geom_bar(stat = "identity", fill = "#FF9500" ) +
    labs(x = "Year", y = "Species Richness") +
    theme_minimal()

  #printing both graphs to check!
  print(abundance_plot)
  print(speciesRichness_plot)

  return(abundance_plot)
  return(speciesRichness_plot)
}

 # end of function gen_histo


# --------------------------------------
# gen_histo()
