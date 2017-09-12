s#R for Data Science
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
 the individual panels? Why doesn't facet_grid() have nrow and ncol argument?'

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