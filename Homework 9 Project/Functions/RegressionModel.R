# --------------------------------------
# FUNCTION regression_model
# required packages: none
# description:
# inputs: data frame with specific variables (species_richness, abundance, and year)
# outputs: summary df of the regression model
########################################
regression_model <- function(df = NULL){

  # assign parameter defaults
  if(is.null(df)){
    print("data frame does not exist")
    return(NULL)
  }
  # Assuming your data is in a data frame called 'data'
  # with columns 'species_richness' for Species Richness (S)
  # and 'abundance' for Abundance

  # Fit the linear regression model
  Linear_regression_model <- lm(species_richness ~ abundance, data = df)

  # View the model summary to get the details
  model_summary <- summary(Linear_regression_model)

  # Extract things from the model summary
  coefficients <- model_summary$coefficients
  r_squared <- model_summary$r.squared
  adj_r_squared <- model_summary$adj.r.squared
  f_statistic <- model_summary$fstatistic[1]
  p_value <- pf(f_statistic, model_summary$fstatistic[2], model_summary$fstatistic[3], lower.tail = FALSE)

  # Create data frame with summary statistics
  LRmodel_summary <- data.frame(
    Term = rownames(coefficients),
    Estimate = coefficients[, "Estimate"],
    Std.Error = coefficients[, "Std. Error"],
    t.value = coefficients[, "t value"],
    Pr...t.. = coefficients[, "Pr(>|t|)"],
    R.squared = r_squared,
    Adjusted.R.squared = adj_r_squared,
    F.statistic = f_statistic,
    p.value = p_value
  )

  # Print the summary data frame
  print(LRmodel_summary)


  return(LRmodel_summary)

} # end of function regression_model
# --------------------------------------
# regression_model()
