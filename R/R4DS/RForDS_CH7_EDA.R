'Using visualisation + transformation to explore data in a systematic way = EDA, an iterative cycle.
  - Generate questions about your data.
  - Search for answers by visualising, transforming, + modeling data.
  - Use what you learn to refine questions and/or generate new questions.

EDA = not a formal process w/ strict set of rules ==> EDA is a state of mind. 

During initial phases of EDA, feel free to investigate every idea that occurs to you ==> Some will pan out, some will be dead ends. 

As exploration continues, you`ll hone in on a few particularly productive areas you'll eventually write up + communicate to others.

EDA = important part of any data analysis, even if questions are handed to you on a platter, b/c you always need to investigate
  quality of data. 

Data cleaning = just 1 application of EDA == ask questions about whether data meets expectations or not. 

To do data cleaning, you'll need to deploy ALL tools of EDA: visualisation, transformation, and modelling.'

library(tidyverse)

'Goal of EDA = to develop an understanding of your data using questions as tools to guide investigations 
  - questions focus attention on a specific part of a dataset + help decide which graphs, models, or transformations to make.

EDA = fundamentally a creative process 
  - like most creative processes, the key to asking quality questions = to generate a large quantity of questions. 
  - difficult to ask revealing questions at start of analyses b/c you do not know what insights are contained in a dataset. 
  - On the other hand, each new question asked exposes you to a new aspect of the data + increase chances of making a discovery. 

Can quickly drill down into the most interesting parts of data + develop a set of thought-provoking questions if you follow up each
  question w/ a new question based on what you find.

No rules about which questions to ask to guide your research ==> but 2 types of questions will always be useful for 
making discoveries w/in data.
  - What type of variation occurs within my variables?
  - What type of covariation occurs between my variables?

variable = a quantity, quality, or property you can measure.

value = the state of a variable when you measure it (may change from measurement to measurement)

observation/data point (DP) = a set of measurements made under similar conditions (usually all measurements in an observation made at 
  same time + on same object). 
    - An observation will contain several values, each associated w/ a different variable.  data point.

Tabular data = a set of values, each associated w/ a variable + an observation. 
  - Tabular = tidy if each value is placed in its own "cell", each variable in its own column, + each observation in its own row.
  - IRL, most data isn't tidy

Variation = tendency of values of a variable to change from measurement to measurement
  - seen easily IRL --> measure any continuous variable twice + get 2 different results
  - true even if you measure quantities that are constant, like speed of light. 
  - Each measurement will include a small amount of error that varies from measurement to measurement. 
  - Categorical variables can also vary if you measure across different subjects (e.g. eye colors of different people), or different
      times (e.g. energy levels of an electron at different moments). 
  - Every variable has its own pattern of variation, which can reveal interesting info
  - best way to understand that pattern = to visualise the distribution of the variable's values.'

## Categorical variables - only take on small set of values = FACTOR or CHARACTER vectors'
## Use bar chart for examining categorica distributions
library(tidyverse)
library(ggplot2)

ggplot(diamonds) + 
  geom_bar(aes(cut)) # ideal is most common value, fair is least common

# get values of counts in above bar plot
diamonds %>% count(cut)

## Continous variables = infinite set of unordered values (ex: #'s + datetime)
## Use histogram to see distributions of continous variables
ggplot(diamonds) + 
  geom_histogram(aes(carat), binwidth = .5)
# right skewed

# counts within each bin of .5
diamonds %>%
  count(cut_width(carat,.5))

## always explore a variety of binwidths when working w/ histograms
## different binwidths can reveal different patterns. 

# zoom into just diamonds w/ size < 3 carats w/ a smaller binwidth
diamonds %>%
  filter(carat < 3) %>%
  ggplot() + geom_histogram(aes(carat), binwidth = .1)

diamonds %>%
  filter(carat < 3) %>%
  count(cut_width(carat,.1))

## to overlay multiple histograms in the same plot --> use geom_freqpoly() instead of geom_histogram()
##  - performs same calculation but uses lines to displaying counts instead of bars
##  - much easier to understand overlapping lines than bars.
ggplot(diamonds) + 
  geom_freqpoly(aes(carat, color = cut), binwidth = .1)

##  key to asking good follow-up questions = rely on your curiosity (What do you want to learn more about?) as well as your 
##    skepticism (How could this be misleading?)

'In both bar charts + histograms, tall bars = common values of a variable + shorter bars = less-common values. 
  - Places w/ no bars = values not seen in the data. 

To turn this info into useful questions, look for anything unexpected:
  - Which values are the most common? Why?
  - Which values are rare? Why? Does that match your expectations?
  - Can you see any unusual patterns? What might explain them?'

diamonds %>%
  filter(carat < 3) %>%
  ggplot() + geom_histogram(aes(carat), binwidth = .01)
## several interesting questions:
##  - Why are there more diamonds at whole carats + common fractions of carats?
##  - Why are there more diamonds slightly to the right of each peak than slightly to the left of each peak?
##  - Why are there no diamonds bigger than 3 carats?

'Clusters of similar values suggest that *subgroups* exist in your data. To understand the subgroups, ask:
  - How are the observations within each cluster similar to each other?
  - How are the observations in separate clusters different from each other?
  - How can you explain or describe the clusters?
  - Why might the appearance of clusters be misleading?'

## length (in minutes) of 272 eruptions of the Old Faithful Geyser in Yellowstone National Park. 
ggplot(faithful) + 
  geom_histogram(aes(eruptions), binwidth = .25)
# Eruption times appear to be clustered into 2 groups
#   - short eruptions (~2 minutes) 
#   - long eruptions (4-5 minutes), 
# but little in between.

'Many of the questions above will prompt exploration of a relationship between variables, for example, to see if the values of 
  1 variable can explain the behavior of another variable.

*Outliers* = observations that are unusual = DPs that don`t seem to fit the pattern. 
  - Sometimes are data entry errors
  - other times suggest important new science. 

When you have a lot of data, outliers are sometimes difficult to see in a histogram.'

ggplot(diamonds) + 
  geom_histogram(aes(y), binwidth = .5)
# only evidence of outliers = the unusually wide limits on the x-axis.
# so many observations in the common bins that rare bins are so short you can't see them 

# make it easy to see unusual values --> zoom to small values of the y-axis w/ coord_cartesian():
ggplot(diamonds) + 
  geom_histogram(aes(y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50))
# see 3 unusual values --> 0, ~30, and ~60. Pluck them out
(unusual <- diamonds %>%
  filter(y < 3 | y > 30) %>%
  select(price,x,y,z) %>%
  arrange(desc(y)))
# y variable measures 1 of the 3 dimensions of these diamonds, in mm. 
# We know diamonds can't have a width of 0mm, so these values must be incorrect. 
# might also suspect measurements of 32mm and 59mm are implausible --> those diamonds are over an inch long, but don't cost
#   hundreds of thousands of dollars!

## It's good practice to repeat analysis w/ and w/out outliers. 
## If they have minimal effect on results, + you can't figure out why they're there, it's reasonable to replace them w/ missing 
##  values, + move on. 
## However, if they have a substantial effect on results, don't drop them w/out justification. 
##  - will need to figure out what caused them (e.g. a data entry error) + disclose that you removed them in your write-up.'

## coord_cartesian() also has an xlim() argument
## ggplot2 also has xlim() and ylim() functions that work slightly differently --> throw away the data outside the limits