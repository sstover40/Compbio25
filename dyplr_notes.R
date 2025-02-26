#resources-
#rgraphgallery --> every kind of plot with examples
#rstudio package cheatsheets: have dyplr ggplot etc
#Data analysis and visualization in R for ecologists


#dyplyr is for data manipulation and structuring dataframes
#core verbs you might use are goiing to be :
# filter(), groupby(), select(), summarize(), arrange(), mutate()

#start w/ built in dataset
library(tidyverse)

#call package name before function will help specify which one youre using if its masked by
#another package
dplyr::filter()

data(starwars)
class(starwars)

#this dataset is a tibble: do less as a tradeoff to make data simple - no row names, no variables
#these types are good if you are working with a large dataset

glimpse(starwars) #alternative to str() or head() functions
head(starwars)

#cleaning up our dataset
#base R has the complete.cases function  - this will remove rows with NAs

starwarsClean <- starwars[complete.cases(starwars[1:10]),]

#you can check for NAs
is.na(starwarsClean[,1])
anyNA(starwarsClean[,1:10]) #positionality of the NAs

#filter() function- subset based on values
#uses >, >=, <, <=, ==, !=
#logical operatoers like & and |
#automatically excluse NAs, have to specify if they are to be included

filter(starwarsClean, gender=="masculine" & height < 180)
filter(starwars, gender=="masculine", height < 180, height > 100)
filter(starwars, eye_color %in% c("blue", "brown")) #can use %in% for multiple conditions similar to ==

#arrange() reorders the rows

arrange(starwarsClean, by = height) #default is accending order
arrange(starwarsClean, by = desc(height)) #non-default

arrange(starwarsClean, height, desc(mass)) #any additional columns will break ties in preceding columnb

starwars1 <- arrange(starwars, height)
tail(starwars1)

##select() choose variables their names
#can do this in base r
###selecting
starwarsClean[1:10,] #only want first 10 rows but keep every column
select(starwarsClean, 1:10) #same thing
select(starwarsClean, name:species)

filter(starwars, sex=="female" & gender== "masculine" | sex=="male" & gender== "feminine")
#no trans characters :(

select(starwarsClean, -(films: starships)) #subset everything except particular variables

#rearrange columns
select(starwarsClean, homeworld, name, gender, species, everything())
select(starwarsClean, contains("color")) #other helpers include
#ends_with, starts_with, matches (reg ex), num_range

#rename columns
select(starwars, haircolor = hair_color) #rename keeps all variables

#mutate() create new variables with functions of existing variables
#create a column that's height divided by mass
mutate(starwarsClean, ratio= height/mass)

starwars_lbs<- mutate(starwarsClean, mass_lbs= mass*2.2)
select(starwars_lbs, 1:3, mass_lbs, everything()) #using select allows us to bring it to the begining

#if you only wanted the new variable and nothing else, you can use the transmute function
transmute(starwarsClean, mass_lbs= mass*2.2)
transmute(starwarsClean, mass, mass_lbs=mass*2.2)

#summarize() and groupby() collapse many values down to single summary
summarize(starwarsClean, meanHeight = mean(height))
summarize(starwars, meanHeight = mean(height)) #does not work if dataset isnt clean
#workaround -
summarize(starwars, meanHeight = mean(height, na.rm=TRUE), TotalNumber = n())

#use group_by() for additional calc

starwarsGender <- group_by(starwars, gender)
head(starwarsGender)
summarize(starwarsGender, meanHeight=mean(height, na.rm = TRUE), number= n())

##pipe statements or piping
#these are sq of actions that will change dataset, will let you pass an intermediate result
#onto the next function in a sequence
#can serve as "and then"
#you should avoid this when you need to manipulate more than one object at a time,
# or if there are meaningful intermediates.

#formatting: should always have a space befroe it and usually followed by a new line

starwarsClean %>%
  group_by(gender) %>%
  summarize(meanHeight=mean(height, na.rm = TRUE), number= n())

#case_when() is useful for multiple conditional ifelse statements
#this will keep species to Human and those that are not will be changed to non-human
starwarsClean %>%
  mutate(sp=case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human")) %>%
  select(name, sp, everything())

#long to wide format and vice-versa
glimpse(starwarsClean)

#make dataset wider
wideSW <- starwarsClean %>%
  select(name, sex, height) %>%
#this will make a new table that has column names "male" "female" and then values from height
  pivot_wider(names_from = sex, values_from = height, values_fill = NA)
wideSW

pivotSW<- starwars %>%
  select(name, homeworld) %>%
  mutate(rn=row_number()) %>%
  ungroup() %>%
  pivot_wider(names_from=homeworld, values_from=name)
head(pivotSW)

#added a column for each homeworld name and then filled in name in row that had someone from that homeworld

#make dataset longer
glimpse(wideSW)

wideSW %>%
  pivot_longer(cols= male:female, names= "sex", values_to = "height", values_drop_na = T)











