'**************************PLOT TEMPLATE***********************
ggplot(data = <DATA>) + 
  <GEOM_FUNCTION>(
    mapping = aes(<MAPPINGS>),
    stat = <STAT>, 
    position = <POSITION>
  ) +
  <COORDINATE_FUNCTION> +
  <FACET_FUNCTION>
**************************************************************'
  
#R for Data Science
library(ggplot2)
library(tidyverse)
#tidyverse_update()

install.packages(c("nycflights13", "gapminder", "Lahman"))

# mpg dataset = observations on 38 models of cards by the EPA
glimpse(mpg)

# Do cars w/ big engines use more fuel than cars w/ small engines? 
# What does the relationship between engine size and fuel efficiency look like? Is it positive? Negative? Linear? Nonlinear?

# displ = engine sie in liters
# hwy = mpg (efficiency) on the highway
ggplot(mpg) + 
  geom_point(aes(displ,hwy))
# negative relationship between engine size + hwy mpg


'***************************3.2.4 Exercises***************************'
# Run ggplot(data = mpg). What do you see?
ggplot(mpg) # blank canvas

# How many rows are in mpg? How many columns?
glimpse(mpg) #234 rows, 11 cols
  
# What does the drv variable describe? Read the help for
?mpg #whether a car is 4 wheel, rear wheel, or front wheel drive

# Make a scatterplot of hwy vs cyl.
ggplot(mpg) + 
  geom_point(aes(cyl,hwy))

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(mpg) + 
  geom_point(aes(class,drv)) # 2 categorical variables = scatterplot aren't useful here

'***************************3.3 Aesthetic Mappings***************************'
ggplot(mpg) + 
  geom_point(aes(displ,hwy))
# notice some cars w/ disp > 5 who have mpg > 22 --> seem to be outliers
# hypothesize that they are hybrids (class = compact or maybe subcompact)

# map a 3rd variable to a 2d scatterplot w/ an AESTHETIC = visual property of objects in a plot (shape, size, color of points)

# color scatterplot by class by mapping the color aesthetic to the class variable inside aes()
# this assigns a unique level (here, color) to the aesthetic = scaling
ggplot(mpg) + 
  geom_point(aes(displ, hwy, color = class, size = 0.5))
# the outliers appear to be 2-seaters, which are, not hybrids, but sports cards = largers engines like SUVs + pickup trucks
# but small bodies like midsize + compact cars = improved mpg
# hindsight = DPs were unlikely to be hybrids due to their large engines

# map size to class
ggplot(mpg) + 
  geom_point(aes(displ, hwy, size = class))
# warning bc class is UNORDERED DISCRETE variable and size is an ORDERED aesthetic = dont use discrete for size

# map alpha (transparency) to class
ggplot(mpg) + 
  geom_point(aes(displ, hwy, alpha = class))

# map shape to class
ggplot(mpg) + 
  geom_point(aes(displ, hwy, shape = class))
# ggplot2 only uses 6 shapes at a time (additional groups unplotted)

# manually set point color outside of aes()
ggplot(mpg) + 
  geom_point(aes(displ, hwy), color = 'blue')


'***************************3.3.1 Exercises***************************'
#'s gone wrong with this code? Why are the points not blue?
ggplot(mpg) + 
  geom_point(aes(displ, hwy, color = "blue")) # mapped color aesthetic to a string not a variable, must set outside aes()

# Which variables in mpg are categorical? Which variables are continuous?
glimpse(mpg)
# categorical (discrete) = manufacturer, model, trans, drv, class, fl
# continous = displ, cyl, year, cty, hwy

# Map a continuous variable to color, size, + shape. How do these aesthetics behave differently for 
# categorical vs. continuous variables?
ggplot(mpg) + 
  geom_point(aes(displ, hwy, color = year))
# different shades of 1 color as year progresses

ggplot(mpg) + 
  geom_point(aes(displ, hwy, size = year))
# size increases w/ year increase

ggplot(mpg) + 
  geom_point(aes(displ, hwy, shape = year))
# continous variables cannot be mapped to shape
  
# What happens if you map the same variable to multiple aesthetics?
ggplot(mpg) + 
  geom_point(aes(displ, hwy, size = year, color = year))
# it maps to both
  
# What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
ggplot(mpg) + 
  geom_point(aes(displ, hwy, stroke = cyl), shape = 21)
# modifies width of the border of a shape for those that have borders

# What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
ggplot(mpg) + 
  geom_point(aes(displ, hwy, color = displ < 5))
# splits points into binary logical classes

'***************************3.5 Facets***************************'
# split up displ vs. hwy by class into 2 rows of plots
ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_wrap(~ class, 2)

# split up displ vs. hwy by drv (x) + class (y)
ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_grid(drv ~ cyl)

# just facet on columns via . before ~
ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_grid(. ~ cyl)

'***************************3.5 Exercises***************************'
#What happens if you facet on a continuous variable?
ggplot(mpg) + 
  geom_point(aes(hwy,cty)) + 
  facet_wrap(~ displ, 2)
# get a plot for each value of the continuous variables

# What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot?
ggplot(mpg) + 
  geom_point(aes(drv, cyl))

ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_grid(drv ~ cyl)
# refer to those drv values that do not have a cyl value associated with them

# What plots does the following code make? What does . do?
ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_grid(drv ~ .)
# makes a plot of hwy by displ split into rows (. on RHS) by drv

ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_grid(. ~ cyl)
# makes a plot of hwy by displ split into cols (. on LHS) by cyl

# Take the first faceted plot in this section. What are the advantages to using faceting instead 
# of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?
ggplot(mpg) + 
  geom_point(aes(displ, hwy)) + 
  facet_wrap(~ class, nrow = 2)
# advantage = can see each grouping very clearly split out, disadvantage = may want variable y-axis scales
# larger dataset = too many plot possibly
  
' Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of 
 the individual panels? Why doesn`t facet_grid() have nrow and ncol argument?'

# they set # of rows or cols of plots. 
  
# When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?

# more space in columns (screens are wider than thehy are tall)

'***************************3.6 Geometric Objects***************************'
# smooth line fitted to data
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy))

# smooth lines fit to data split by drv value
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, linetype = drv))

# overlay lines over raw data
ggplot(mpg) + 
  geom_point(aes(displ, hwy, color = drv)) +
  geom_smooth(aes(displ, hwy, linetype = drv, color = drv))

# set the group aesthetic to a categorical variable to draw multiple objects.
ggplot(mpg) + 
  geom_smooth(aes(displ, hwy, group = drv))

# avoid repetition in code by placing x and y mappings to ggplot to plot them over multiple layers (geoms)
ggplot(mpg, aes(displ, hwy, linetype = drv, color = drv)) + 
  geom_point() +
  geom_smooth()

# 
ggplot(mpg, aes(displ, hwy)) + 
  # override possible global color for the point layer
  geom_point(aes(color = class)) +
  # subset data for smooth line for this layer only
  geom_smooth(data = filter(mpg, class == 'subcompact'), se = FALSE)

'***************************3.6 Exercises***************************'
## What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?
# geom_line, geom_boxplot, geom_histogram, geom_area
  
## Run this code in your head + predict what the output will look like
# scatterplot of hwy mpg by displ, with a line, with no confidence intervals
# different colored lines + points by drv
ggplot(mpg, aes(displ, hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

## What does show.legend = FALSE do? What happens if you remove it?
# it removes the legend to the right of the plot, 
  
## What does the se argument to ?geom_smooth() do?
# removes the confidence intervals
  
## Will these two graphs look different? Why/why not?
## ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
##   geom_point() + 
##   geom_smooth()

## ggplot() + 
##   geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
##   geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# yes, since they are using the same dataframe and mapping
# 1st function just makes it global for all subsequent layers

## Recreate the R code necessary to generate the following graphs.
ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth(se = F)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point() +
  geom_smooth(se = F, aes(group = drv))

ggplot(mpg, aes(displ, hwy, color = drv)) + 
  geom_point() +
  geom_smooth(se = F, aes(group = drv))

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = drv)) +
  geom_smooth(se = F)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color = drv)) +
  geom_smooth(se = F, aes(linetype = drv))

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(fill = drv), pch = 21, color = "white", size = 5, stroke = 3)

'***************************3.7 Statistical transformations***************************'
# recreate bar chart w/ stat_count()
ggplot(diamonds) + 
  geom_bar(aes(cut))

ggplot(diamonds) + 
  stat_count(aes(cut))
# works b/c every geom has a default stat + every stat has a default geom. 
# can typically use geoms w/out worrying about the underlying statistical transformation.

# change default stat of geom_bar to "identity" to map height to a y variable
demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(demo) +
  geom_bar(aes(cut, freq), stat = "identity")

# display bar chart of proportion rather than coutn
ggplot(diamonds) + 
  geom_bar(aes(cut, y = ..prop.., group = 1))

# use stat_summary() to summarize the y-values for each unique x-value to draw
#   attention to the summary you`re computing
ggplot(diamonds) + 
  stat_summary(
    aes(cut, depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

'***************************3.7 Exercises***************************'
## What is the default geom associated with stat_summary()? 
## How could you rewrite previous plot to use the geom function instead of the stat function?
?stat_summary  
# pointrange is default geom

ggplot(diamonds) + 
  geom_pointrange(stat = 'summary',
    aes(cut, depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

## What does geom_col() do? How is it different to geom_bar()?
?geom_col  
# it represents values in the data rather than # of cases in each group

## Most geoms and stats come in pairs that are almost always used in concert. 
## Read through the documentation and make a list of all the pairs. What do they have in common?


## What variables does stat_smooth() compute? What parameters control its behaviour?
?stat_smooth
# compute predicted y values, lower + upper bounds of CI (ymin, ymax), and the standard error
# controlled by x and y parameters

## In our proportion bar chart, we need to set group = 1. Why? 
## In other words what is the problem with these two graphs?
ggplot(diamonds) + 
 ?geom_bar(aes(cut, y = ..prop..))

ggplot(diamonds) + 
  geom_bar(aes(cut, color, y = ..prop..))
# group = 1 causes us to group by our x-axis levels correclty for proportions
# for proportions, need to consider all levels of a variable together. 
# data are 1st grouped by this variable, so each level of the variable is considered separately. 
# The proportion of Fair in Fair is 100%, as is the proportion of Good in Good, etc. 
# group = 1 prevents this so that proportions of each level will be relative to all levels

'***************************3.8 Position Adjustments***************************'
# can color bars w/ color or fill aesthetics

# color border w/ color
ggplot(diamonds) + 
  geom_bar(aes(cut, colour = cut))

#color bars w/ fill
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = cut))

# map fill to another aesthetic to create a stacked bar chart
# each rectangle represents a combo of cut + clarity
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = clarity))

# stacking is performed automatically by the position adjustment specified by "position" argument. 

# use position = identity and set alpha to low value to see overlapping
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = clarity), position = 'identity',  alpha = 0.2)

# use position = identity and set fill to "NA" to see overlapping
ggplot(diamonds) + 
  geom_bar(aes(cut, color = clarity), position = 'identity',  fill = NA)

# use position = fill to make each set of stacked bars the same height + each color a proportion
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = clarity), position = 'fill')

# splits out levels of fill variable into own bars stacked next to each other for each x variable level
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = clarity), position = 'dodge')

# spread out each DP in scatterplot with random noise via jitter to eliminate overlapping DPs
ggplot(mpg) + 
  geom_point(aes(displ,hwy), position = "jitter")
# makes graph less accurate at small scales, but more revealing at large scales
# geom_jitter() = shorthand for this
ggplot(mpg) + 
  geom_jitter(aes(displ,hwy))

'***************************3.8 Exercises***************************'
## What is the problem with this plot? How could you improve it?
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()
# use jitter to eliminate overlapping DPs
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter()

## What parameters to geom_jitter() control the amount of jittering?
?geom_jitter
# explicitly set the position adjustment: position=position_jitter(width=0.3, height=0)) 

# Compare and contrast geom_jitter() with geom_count().
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count()
# geom_count sizes up DP's with the count of rounded DP's at a specific location

## What's the default position adjustment for geom_boxplot()? 
?geom_boxplot
# dodge is default position

## Create a visualisation of the mpg dataset that demonstrates it.
ggplot(mpg, aes(class, hwy, color = class)) + 
  geom_boxplot(position = 'identity')
ggplot(mpg, aes(class, hwy, color = class)) + 
  geom_boxplot(position = 'dodge')

'***************************3.9 Coordinate systems***************************'
# make horizontal boxplots
ggplot(mpg, aes(class, hwy, color = class)) + 
  geom_boxplot() +
  coord_flip()

### correctly set aspect ratio for map of NZ
# install.packages("maps")
nz <- map_data("nz")

# original
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

# fixed
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

###
bar <- ggplot(diamonds) + 
  geom_bar(aes(cut, fill = cut), show.legend = FALSE, width = 1) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

# horizontal bars
bar + coord_flip()

# Coxcomb chart
bar + coord_polar()

'***************************3.9 Exercises***************************'
## Turn a stacked bar chart into a pie chart using coord_polar().
ggplot(diamonds) + 
  geom_bar(aes(cut, fill = clarity)) + 
  coord_polar()

## What does labs() do?
?labs
# modifies labels (title, axes, legend) --> xlab, ylab, ggittle, labs
ggplot(mtcars, aes(mpg, wt, colour = cyl)) + 
  geom_point() + 
  labs(colour = "Cylinders") + # legend
  labs(x = "New x label") # x-axis

## What's the difference between ?coord_quickmap() and coord_map()?
?coord_quickmap
# quickmap sets the aspect ratio of a plot to the appropriate lat/lon ratio to approximate the usual mercator
#   projection for regions that span only a few degrees and are not too close to the poles
# is much faster (particularly for complex plots like geom_tile) at the expense of correctness.

# With CORRECT mercator projection
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") + 
  coord_map()

# With the aspect ratio approximation
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") + 
  coord_quickmap()

#What does plot below tell you about relationship between city + highway mpg? 
ggplot(mpg, aes(cty, hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()
# tells us relationsip is a strong positive linear one

## Why is coord_fixed() important?
# forces a specified ratio between the physical representation of data units on the axes. 
#   - ratio represents # of units on y-axis equivalent to 1 unit on x-axis w/ default ratio = 1
#   - ensures that 1 unit on the x-axis is the same length as 1 unit on the y-axis. 
#   - Ratios > 1 make units on y longer than units on x + vice versa. 
#   - similar to eqscplot, but works for all types of graphics.

## What does geom_abline() do?
# adds a reference line w/ specified slope + intercept to the plot = default values --> intercept = 0 + slope = 1.