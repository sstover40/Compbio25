# --------------------------------------
# FUNCTION gen_histo
# required packages: none
# description: this makes a histogram using the summary_df
# inputs: a data-frame
# outputs: ggplot2 histogram
########################################
library(ggplot2)

# Create histogram and add labels to bins
ggplot(data, aes(x = year)) +
  geom_histogram(binwidth = 1, color = "black", fill = "lightblue") +
  geom_label(stat = "bin", aes(label = ..count.., y = ..count..), vjust = -0.5) +
  ggtitle("Histogram with Labels") +
  labs(x = "Year", y = "Count") +
  theme_minimal()

df <- summary_df
gen_histo <- function(df){
data <- df
  plot_1 <- ggplot(data, aes(x=df$year, y=df$abundance)) +    #this graph is dealing with only 1 variable
    geom_histogram(binwidth = 1, color = "black", fill="thistle") +
    geom_label(stat = "bin", aes(label = "year", y = "Abundance (by indiv sighting)")) +
    ggtitle("Bird Abundance") +
    labs(x = "year", y = "abundance") +
    theme_minimal()
  return(plot_1)

  # plot_2 <- ggplot(df, aes(x=year, y=species_richness)) +    #this graph is dealing with only 1 variable
      geom_bar(stat = "identity", fill="teal", color = "Black" ) +
      geom_label(x = "year", y = "Species Richness")
}

return(plot_1)
return(plot_2)
 # end of function gen_histo
# --------------------------------------
# gen_histo()
