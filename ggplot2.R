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

# use coordinate_flip to invert entire plot
p2 <- ggplot(data=d, mapping=aes(x=fl,fill=fl)) + geom_bar()
print(p2)
p2 + coord_flip() + theme_grey(base_size=20,base_family="sans")

geom_point(size=7,shape=21,color="black",fill="steelblue") +
  labs(title="My graph title here",
       subtitle="An extended subtitle that will print below the main title",
       x="My x axis label",
       y="My y axis label") +
  xlim(0,4) + ylim(0,20)
print(p1)







