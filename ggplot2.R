#ggplot graphics

# command shift c to comment things out


#p1 <- ggplot(data= <DATA>) +
#  aes(<MAPPINGS>) +
#  <GEOM_FUNCTION>(aes(<MAPPINGS>),
#                  stat=<STAT>,
#                  position=<POSITION>) +
#  <COORDINATE_FUNCTION> +
#  <FACET_FUNCTION>

#  print(p1)
#ggsave(plot=p1,
#      filename="MyPlot",
#      width=5,
#       height=3,
#       units="in",
#       device="pdf")

library(ggplot2)
library(ggthemes)
library(patchwork)

d <- mpg # use built in mpg data frame
str(d)
table(d$fl)

# basic histogram plots
ggplot(data=d) +
  aes(x=hwy) +    #this graph is dealing with only 1 variable
  geom_histogram()
                  #light grey background diagnoses it as a ggplot, want to move away
                  #from that so it looks more professional

ggplot(data=d) +
  aes(x=hwy) +
  geom_histogram(fill="khaki",color="black")

# basic density plot
ggplot(data=d) +
  aes(x=hwy) +
  geom_density(fill="mintcream",color="blue")

# basic scatter plot
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth() +
  geom_smooth(method="lm",col="red")
# add a smoother, maybe should not use these plots, curve fits using local points BUT its arbitrary
#better to fit a statistical model
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth()

# add a linear regression line
ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth(method = "lm",col="red")

# basic boxplot
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot()
# basic boxplot with fill color
ggplot(data=d) +
  aes(x=fl, y=cty) +
  geom_boxplot(fill="thistle")

# basic barplot (long format)

ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill="thistle",color="black")

# bar plot with specified counts or meansw
x_treatment <- c("Control","Low","High")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment,y_response)

ggplot(data=summary_data) +
  aes(x=x_treatment,y=y_response) +
  geom_col(fill=c("grey50","goldenrod","goldenrod"),col="black")
      #the fill is a little bit different here

#want to do continuous functions???
# basic curves and functions
my_vec <- seq(1,100,by=0.1)

# plot simple mathematical functions
d_frame <- data.frame(x=my_vec,y=sin(my_vec)) #basically a simple function at the same time as the df
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

# plot probability functions
d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape=5, scale=3))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()

# plot user-defined functions
my_fun <- function(x) sin(x) + 0.1*x
d_frame <- data.frame(x=my_vec,y=my_fun(my_vec))
ggplot(data=d_frame) +
  aes(x=x,y=y) +
  geom_line()


#graph with all the defaults --> looks unprofessional, basic graph no changes
p1 <- ggplot(data=d, mapping=aes(x=displ,y=cty)) + geom_point()
print(p1)
p1 + theme_classic() # no grid lines
p1 + theme_linedraw() # black frame
p1 + theme_dark() # good for brightly colored points
p1 + theme_base() # mimics base R
p1 + theme_par() # matches current par settings in base
p1 + theme_void() # shows data only
p1 + theme_solarized() # good for web pages
p1 + theme_economist() # many specialized themes
p1 + theme_grey() # ggplots default theme
# use theme parameters to modify font and font size
p1 + theme_classic(base_size=40,base_family="serif")
# defaults: theme_grey, base_size=16,base_family="Helvetica")
# font families (Mac): Times, Ariel, Monaco, Courier, Helvetica, serif,sans
# defaults: theme_grey, base_size=16,base_family="Helvetica")
# font families (Mac): Times, Ariel, Monaco, Courier, Helvetica, serif,sans



# code for adding additional fonts, can look in R studio to see list of fonts
library(extrafont)
font_import()  # Imports all system fonts (run once)
# loadfonts(device = "win")  # For Windows
# fonts() # will list loaded fonts
p1 + theme_classic(base_size=35,
                   base_family="Chalkduster")

# use coordinate_flip to invert entire plot
p2 <- ggplot(data=d, mapping=aes(x=fl,fill=fl)) + geom_bar()
print(p2)
p2 + coord_flip() + theme_grey(base_size=20,base_family="sans") +
  geom_point(size=7,shape=21,color="black",fill="steelblue") +
  labs(title="My graph title here",
       subtitle="An extended subtitle that will print below the main title",
       x="My x axis label",
       y="My y axis label") +
  xlim(0,4) + ylim(0,20)
print(p1)

# use labs for different plot labels
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point() +
  labs(title="My graph title here",
       subtitle="An extended subtitle",
       x="Displacement",
       y="City Mileage",
       caption="Add a caption here") +
  theme_bw(base_size=25,base_family="Monaco")
#    xlim(0,4) + ylim(0,20)
print(p1)

# use attributes for point size shape, color
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point(size=4,
             shape=21,
             color="black",fill="cyan") +
  theme_bw(base_size=25,base_family="Monaco")
print(p1)

# use x and/or y limits to clip data set
p1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point(size=4,
             shape=21,
             color="black",fill="cyan") +
  xlim(4,7) +
  ylim(-10,40) +
  theme_bw(base_size=25,base_family="Monaco")
print(p1)

####----------------------------------------------------------------------------

library(ggplot2)
library(ggthemes)
library(patchwork)
d <- mpg # use built in mpg data frame
g1 <- ggplot(data=d) +
  aes(x=displ,y=cty) +
  geom_point() +
  geom_smooth()
print(g1)

g2 <- ggplot(data=d) +
  aes(x=fl) +
  geom_bar(fill="tomato",color="black")+
  theme(legend.position="none")
print(g2)

g3 <- ggplot(data=d) +
  aes(x=displ) +
  geom_histogram(fill="royalblue",
                 color="black")
print(g3)

g4 <- ggplot(data=d) +
  aes(x=fl,y=cty,fill=fl) +
  geom_boxplot() +
  theme(legend.position="none")

print(g4)

# place two plots horizontally
g1 + g2

# place 3 plots vertically
g1 + g2 + g3 + plot_layout(ncol=1)
# change relative area of each plot
g1 + g2 + plot_layout(ncol=1,heights=c(2,1))

g1 + g2 + plot_layout(ncol=2,widths=c(1,2))
# add a spacer plot
g1 + plot_spacer() + g2
# use nested layouts
g1 + {
  g2 + {
    g3 +
      g4 +
      plot_layout(ncol=1)
  }
} +
  plot_layout(ncol=1)

# - operator for subtrack placement
g1 + g2 - g3 + plot_layout(ncol=1)
# / and | for intuitive layouts
(g1 | g2 | g3)/g4
(g1 | g2)/(g3 | g4)
# Add title, etc. to a patchwork
g1 + g2 + plot_annotation('This is a title',
                          caption = 'made with patchwork')

# Change styling of patchwork elements
g1 + g2 +
  plot_annotation(
    title = 'This is a title',
    caption = 'made with patchwork',
    theme = theme(plot.title = element_text(size = 16))
  )

# Add tags to plots
g1 / (g2 | g3) +
  plot_annotation(tag_levels = 'A')

#Swapping axis orientation for a multipanel plot
g3a <- g3 + scale_x_reverse()
g3b <- g3 + scale_y_reverse()
g3c <- g3 + scale_x_reverse() + scale_y_reverse()

(g3 | g3a)/(g3b | g3c)

(g3 + coord_flip() | g3a + coord_flip())/(g3b + coord_flip() | g3c + coord_flip())

#REMEMBER: need to save the plots once you are done with them!!!
ggsave(filename="MyPlot.pdf",
       plot=g3,
       device="pdf",
       width=20,
       height=20,
       units="cm",
       dpi=300)

# mapping of a discrete variable to point color
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=class) +
  geom_point(size=3)
print(m1)

# mapping of a discrete variable to point shape (<= 6)
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,shape=class) +
  geom_point(size=3)
print(m1)

# mapping of a discrete variable to point size (not advised)
m1 <- ggplot(data=mpg) +                                   aes(x=displ,y=cty,size=class) +
  geom_point()
print(m1)


#MORE USEFUL WAY TO VISUALIZE --> THIS IS A BUBBLE PLOT, can use it on a physical map
#This is the plot that George suggested for Ericka's data
# mapping a continuous variable to point size
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,size=hwy) +
  geom_point()
print(m1)

# mapping a continuous variable to point color, HEAT MAP
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=hwy) +
  geom_point(size=5)
print(m1)

# mapping two variables to different aesthetics, still using the miles per gallon data
#change the shape of the points to represent the data, ggplot might not use shapes that
#are easy to differentiate if there are more than 6 or so catagories
m1 <- ggplot(data=mpg) + aes(x=displ,y=cty,shape=class,color=hwy) +
  geom_point(size=5)
print(m1)

# use shape for smaller number of categories
m1 <- ggplot(data=mpg) + aes(x=displ,y=cty,shape=drv,color=fl) +
  geom_point(size=5)
# use all 3 (size, shape, color) to indicate 5 attributes!
m1 <- ggplot(data=mpg) +
  aes(x=displ,
      y=cty,shape=drv,
      color=fl,
      size=hwy) +
  geom_point()
print(m1)

# mapping a variable to the same aesthetic in two different geoms
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=drv) +
  geom_point(size=2) +
  geom_smooth(method="lm")a
print(m1)

#### FACETING
#faceting variables for more effective grouping
# basic faceting with variables split by row, column, or both
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty) +
  geom_point()

#these will all give you different combinations
m1 +  facet_grid(class~fl) #which graph and which fuel type
m1 + facet_grid(class~fl, scales="free_y")
m1 + facet_grid(class~fl, scales="free")
m1 + facet_grid(.~class)
m1 + facet_grid(class~.)
# use facet wrap when variables are not crossed
m1 + facet_grid(.~class)
m1 +  facet_wrap(~class)
m1 + facet_wrap(~class + fl)
m1 + facet_wrap(~class + fl, drop=FALSE)
m1 + facet_grid(class~fl)
# use facet with other aesthetic mapping within rows or columns

m1 <- ggplot(data=mpg) +                                         aes(x=displ,y=cty,color=drv) +
  geom_point()

m1 + facet_grid(.~class)

# easy to switch to other geoms
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty,color=drv) +
  geom_smooth(se=FALSE,method="lm")

m1 + facet_grid(.~class)

# fitting with boxplots over a continuous variable
m1 <- ggplot(data=mpg) +
  aes(x=displ,y=cty) +
  geom_boxplot()

m1 + facet_grid(.~class)

# add a group and fill mapping for subgroups
m1 <- ggplot(data=mpg) + aes(x=displ,y=cty,group=drv,fill=drv) +
  geom_boxplot()

m1 + facet_grid(.~class)

# standard plot with all data
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() +
  geom_smooth()
print(p1)

# break out the drive types (note what group affects
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy, group=drv) +
  geom_point() +
  geom_smooth()
print(p1)

# break out the drive types (note what color affects
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy, color=drv) +
  geom_point() + geom_smooth()
print(p1)

# use both if you want points, lines, and confidence intervals colored
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy, color=drv, fill=drv) +
  geom_point() + geom_smooth()
print(p1)

# now use aesthetic mappings within each geom to over-ride defaults
# subset the data frame to pull out what you need

p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy,col=drv) +
  geom_point(data=d[d$drv=="4",]) + geom_smooth()
print(p1)

# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point(aes(color=drv)) + geom_smooth()
print(p1)

# Conversely, map the smoother, but not the points
p1 <- ggplot(data=d) +
  aes(x=displ,y=hwy) +
  geom_point() + geom_smooth(aes(color=drv))
print(p1)

# also, subset in the first layer to eliminate some data entirely
# instead of subsetting, just map an aesthetic
p1 <- ggplot(data=d[d$drv!="4",]) +
  aes(x=displ,y=hwy) +
  geom_point(aes(color=drv)) + geom_smooth()
print(p1)

###----------------------------------------------------------------------------
# WORKING WITH COLOR (GGPLOT III)

# the :: separates the particular package that the command after comes from

library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)

d <- mpg
#use to plot the counts of rows for categorical variable
table(d$drv)

p1 <- ggplot(d) +
  aes(x=drv) +
  geom_bar(color="black",fill="cornsilk")
print(p1)

# aesthetic mapping gives multiple groups for each bar
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar()
print(p1)

# stacked, but need to adjust color transparency, which is "alpha"
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(alpha = 0.3, position="identity")
print(p1)

# better to use position = fill for stacking, but with equivalent height
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="fill")
print(p1)

# best to use position = dodge for multiple bars
p1 <- ggplot(d) +
  aes(x=drv,fill=fl) +
  geom_bar(position="dodge",color="black",size=1)
print(p1)

# more typical "bar plot" has heights as the values themselves
d_tiny <- tapply(X=d$hwy,INDEX=as.factor(d$fl),FUN=mean) #calculate the means,
#we are passing the name of another function to this function
print (d_tiny)

d_tiny <- data.frame(hwy=d_tiny) # create a single-column data frame
print(d_tiny)

d_tiny <- cbind(fl=row.names(d_tiny),d_tiny) #
print(d_tiny)

p2 <- ggplot(d_tiny) +
  aes(x=fl,y=hwy,fill=fl) +
  geom_col()
print(p2)

# basic boxplot is simple and informative
p1 <- ggplot(d) +
  aes(x=fl,y=hwy,fill=fl) +
  geom_boxplot()
print(p1)

# now overlay the raw data
p1 <- ggplot(d) +
  aes(x=fl,y=hwy) +
  geom_boxplot(fill="thistle",outlier.shape=NA) +
  # geom_point()
  geom_point(position=position_jitter(width=0.1, height=0.7),
             color="grey60",size=2)

print(p1)
# Aesthetics
#
# Colors that are attractive - large geoms (fills) - pale colors - small geoms(lines,points) - bright colors
# Colors that highlight elements - pale, grey to de-emphasize - bright or saturated colors to emphasize
# Colors that are visible to the color blind
# Colors that convert well to black and white
#
# Information content
#
# Discrete scale
#
# colors to group similar treatments
# neutral colors (black,grey,white) to indicate control groups
# Symbolic colors (heat=red, cool = blue, photosynthesis/growth=green, oligotrophic=blue, eutrophic=brown, infected=red)
# Colors that map to chemical stains or gels, or even colors of organisms
#
# Continuous scale
#
# monochromatic (differing shades of 1 color)
# 2 tone chromatic scale (from color x to color y)
# 3 tone divergent scale (from color x through color y to color z)
#
# Use color information within and between graphs
#
# show color names, hex in base R
# show color schemes in colorbrewer
#
# Color visualizations
my_cols <- c("thistle","tomato","cornsilk","cyan","chocolate")
demoplot(my_cols,"map")
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"heatmap")
demoplot(my_cols,"spine")
demoplot(my_cols,"perspective")

# gray function versus gray colors

# built in greys (0 = black, 100 = white
my_greys <- c("grey20","grey50","grey80")
demoplot(my_greys,"bar")
my_greys2 <- grey(seq(from=0.1,to=0.9,length.out=10))
demoplot(my_greys2,"heatmap")


#-------------------------------------------------------------------------------

#ggplot PRELIMINARIES
library(ggridges) # ridge plots
library(ggbeeswarm) # beeswarm plots
library(GGally) # parallel coordinates plots
library(ggpie) # pie charts
library(ggmosaic) # mosaic plots
library(scatterpie) # scatter pies on map
library(waffle) # for waffle plots
library(DescTools) # for converting table to long
library(treemap) # for tree maps


d <- mpg
# use to plot the counts of rows for a categorical variable
table(d$drv)

d <- mpg
# violin plot
# symmetric density plot
p1 <- ggplot(data=d) +
  aes(x=drv, y=cty, fill=drv) +
  geom_violin() +
  geom_point(position=position_jitter(width=0.2,
                                      height=0.3),color="black",size=0.4)
p1

# ridgeline plot --> great for timeseries data, multiple groups of data
p2 <- ggplot(data=d) +
  aes(x=cty,y=drv,fill=drv) +
  ggridges::geom_density_ridges() +
  ggridges::theme_ridges()
p2

# beeswarm plot
p3 <- ggplot(data=d) +
  aes(x=drv,y=cty,color=drv) +
  ggbeeswarm::geom_beeswarm(method = "center",size=2)
p3

# bubble plot
#four pieces of information, good for continuous data
p4 <- ggplot(data=d) +
  aes(x=displ,y=hwy,size=cty,fill=drv) +
  geom_point(shape=21,color="black",stroke=0.5)
p4

# parallel coordinates plot
p5 <- GGally::ggparcoord(data=d,
                         columns = c(3,9), # c(3,5,8,9) looking for specific column by number
                         groupColumn = 7)
p5 #comparing 2 variables, displacement and highway miledge


# lollipop plot
table(d$fl) #table command is great for pulling out counts for the categorical variables
#the amount of rows that you want

#for this frankenstien of a plot we need to edit the data frame a little bit
fuel_data <- data.frame(
  table(d$fl),
  fuel=c("Natural Gas",
         "Diesel",
         "Ethanol",
         "Premium",
         "Regular"))
fuel_data <- fuel_data[,-1] # remove tabled column, do not want to use original set of labels
fuel_data$Freq <- fuel_data$Freq+100 # + 100 helps the data look better in the graph and also normalizes

#have to physically make the lollipops in the plot
p6 <- ggplot(data=fuel_data) +
  aes(x=fuel, y=Freq) +
  geom_segment(aes(x=fuel,
                   xend=fuel, y=0,
                   yend=Freq),
               color="grey",
               linewidth=2) +
  geom_point( color="orange", size=7) +
  labs(title="Fuel Type",
       x="",
       y="Count") +
  coord_flip() +
  theme_light(base_size=20,base_family=
                "Monaco") +
  theme(
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(hjust = 0))
p6

#think of the geoms as things we can use and puzzle together to make our own
#data plot or data type. There are no packages for a lolipop plot yet but we
#can make it on our own

# typical unsatisfactory pie chart, not good to show data bc everything is too relative,
#people are not good at interpreting pie charts....
p7 <- ggpie::ggpie(data=mpg,
                   group_key="class",
                   count_type="full",
                   label_info="ratio",
                   label_type="circle") # try circle vs none, STILL dreadful lmao
p7

# much better = a waffle plot, still not that ideal but improvement
#needs to have the data in the tabled form
tabled_data <- as.data.frame(table(class=mpg$class))

p8 <- ggplot(data=tabled_data) +
  aes(fill = class, values = Freq) +
  waffle::geom_waffle(n_rows = 8, size = 0.33, colour = "white") +
  coord_equal() +
  theme_void()
p8

# highly effective scatterpie diagrams
d <- data.frame(x=rnorm(5), y=rnorm(5))
d$A <- abs(rnorm(5, sd=1))
d$B <- abs(rnorm(5, sd=2))
d$C <- abs(rnorm(5, sd=3))

p9 <- ggplot(data=d) +
  scatterpie::geom_scatterpie(
    aes(x=x, y=y),
    pie_scale=4,
    cols=c("A", "B","C")) +
  coord_fixed()
# scale_fill_manual(values=c("coral","grey95","grey90"))
p9

# mosaic plots for proportional data (1 or 2 factors). All combinations of factors must be present!
# no zero values

# Simple 1-factor partition
# options hspine (default),vspine,vbar,hbar
city_tree <- expand.grid(Tree=c("Oak","Pine","Maple","Spruce","Beech"),City=c("Bur","Col","Win"))

city_tree$Freq <- c(100,2,25,
                    9,4,7,
                    3,30,30,
                    2,2,5,
                    6,6,6)
city_tree_long <- DescTools::Untable(city_tree)
d <- city_tree_long

p10 <- ggplot(data = d) +
  geom_mosaic(aes(x = product(Tree),
                  fill=Tree),
              divider="hspine") +
  labs(title='Tree Type')
p10

# 2-factor partition
# divider options mosaic("h"),mosaic("v"),ddecker()
d <- city_tree_long

p11 <- ggplot(data = d) +
  geom_mosaic(aes(x = product(Tree,City),
                  fill=Tree),
              divider=mosaic("v")) +
  labs(title='mosaic v')
p11














