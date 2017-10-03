'Using visualisation + transformation to explore data in a systematic way = EDA, an iterative cycle.
  - Generate questions about your data.
  - Search for answers by visualising, transforming, + modeling data.
  - Use what you learn to refine questions and/or generate new questions.

EDA = not a formal process w/ strict set of rules ==> EDA is a state of mind. 

During initial phases of EDA, feel free to investigate every idea that occurs to you ==> Some will pan out, some will be dead ends. 

As exploration continues, you`ll hone in on a few particularly productive areas you`ll eventually write up + communicate to others.

EDA = important part of any data analysis, even if questions are handed to you on a platter, b/c you always need to investigate
  quality of data. 

Data cleaning = just 1 application of EDA == ask questions about whether data meets expectations or not. 

To do data cleaning, you`ll need to deploy ALL tools of EDA: visualisation, transformation, and modeling.'

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

Variable = a quantity, quality, or property you can measure.

Value = the state of a variable when you measure it (may change from measurement to measurement)

Observation/data point (DP) = a set of measurements made under similar conditions (usually all measurements in an observation made at 
  same time + on same object). 
    - An observation will contain several values, each associated w/ a different variable.  data point.

Tabular data = a set of values, each associated w/ a variable + an observation. 
  - Tabular = tidy if each value is placed in its own "cell", each variable in its own column, + each observation in its own row.
  - IRL, most data isn`t tidy

Variation = tendency of values of a variable to change from measurement to measurement
  - seen easily IRL --> measure any continuous variable twice + get 2 different results
  - true even if you measure quantities that are constant, like speed of light. 
  - Each measurement will include a small amount of error that varies from measurement to measurement. 
  - Categorical variables can also vary if you measure across different subjects (e.g. eye colors of different people), or different
      times (e.g. energy levels of an electron at different moments). 
  - Every variable has its own pattern of variation, which can reveal interesting info
  - best way to understand that pattern = to visualise the distribution of the variable`s values.'

## Categorical variables - only take on small set of values = FACTOR or CHARACTER vectors'
## Use bar chart for examining categorical distributions
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

## To overlay multiple histograms in the same plot --> use geom_freqpoly() instead of geom_histogram()
##  - performs same calculation but uses lines to displaying counts instead of bars
##  - much easier to understand overlapping lines than bars.
ggplot(diamonds) + 
  geom_freqpoly(aes(carat, color = cut), binwidth = .1)

## Key to asking good follow-up questions = rely on your curiosity (What do you want to learn more about?) as well as your 
##  skepticism (How could this be misleading?)

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
  coord_cartesian(ylim = c(0, 50)) # don't remove any values

# see 3 unusual values --> 0, ~30, and ~60. Pluck them out
(unusual <- diamonds %>%
  filter(y < 3 | y > 30) %>%
  select(price,x,y,z) %>%
  arrange(desc(y)))
# y variable measures 1 of the 3 dimensions of these diamonds, in mm. 
# We know diamonds can't have a width of 0mm, so these values must be incorrect. 
# Might also suspect the measurements of 32mm and 59mm are implausible --> those diamonds are over an inch long, but 
# don't cost hundreds of thousands of dollars!

## It's good practice to repeat analysis w/ and w/out outliers. 
## If they have minimal effect on results, + you can't figure out why they're there, it's reasonable to replace them w/ missing 
##  values, + move on. 
## However, if they have a substantial effect on results, don't drop them w/out justification. 
##  - will need to figure out what caused them (e.g. a data entry error) + disclose that you removed them in your write-up.'

## coord_cartesian() also has an xlim() argument
## ggplot2 also has xlim() and ylim() functions that work slightly differently --> throw away the data outside the limits

'*********************************
7.3.4 Exercises
*********************************'
## Explore distribution of each of the x, y, and z variables in diamonds. What do you learn? 
## Think about a diamond and how you might decide which dimension is the length, width, and depth.
diamonds %>% # length
  ggplot + geom_histogram(aes(x), binwidth = .5) # bimodal and right skewed

diamonds %>% # y = width
  ggplot + geom_histogram(aes(y), binwidth = .1) +
    coord_cartesian(xlim = c(3, 10)) # multimodal

diamonds %>% # depth
  ggplot + geom_histogram(aes(z), binwidth = .25) + 
  coord_cartesian(xlim = c(1, 8)) # bi or multi modal

## Explore the distribution of price. Do you discover anything unusual or surprising?
##  (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)
diamonds %>%
  ggplot + geom_histogram(aes(price), binwidth = 1000) # random values below $1k

diamonds %>%
  ggplot + geom_histogram(aes(price), binwidth = 100) + # drop around $1k?
  coord_cartesian(xlim = c(250, 2000)) # random drop at $1500, low values = from 250 to about $200-300 to $600 

diamonds %>%
  ggplot + geom_histogram(aes(price), binwidth = 10) # drop around $1k?

## How many diamonds are 0.99 carat? How many are 1 carat? What do you think is the cause of the difference?
diamonds %>%
  group_by(carat) %>%
  summarise(count = n()) %>%
  filter(carat == .99 | carat == 1)
# 23 are .99 caracts, while over 1.5k are 1 carat. Maybe this is data entry error (rounding)

## Compare and contrast coord_cartesian() vs xlim() or ylim() when zooming in on a histogram. 
# xlim and ylim throw away data outside the limits

## What happens if you leave binwidth unset?
# it gets a default value of 30

# What happens if you try and zoom so only half a bar shows?

'*********************************
7.4  Missing values
*********************************'
'W/ unusual values, 2 options.
  - Drop the entire row with the strange values:'
diamonds2 <- diamonds %>% 
  filter(between(y, 3, 20))
# not recommended b/c just b/c 1 measurement is invalid doesn't mean all measurements are. 
# Additionally, if you have low quality data, by time you've applied this approach to every variable you might find you
#   don't have any data left!

' - Replacing the unusual values with missing values = RECOMMENDED 
    - easiest way = use mutate() to replace the variable w/ a modified copy or ifelse() to replace unusual values with NA:'
diamonds2 <- diamonds %>% 
  mutate(y = ifelse(y < 3 | y > 20, NA, y))

'ggplot2 = missing values should never silently go missing
  - not obvious where to plot missing values, so ggplot2 doesn't include them, but does warn they've been removed
  - use na.rm = TRUE to remove the warning

Other times you want to understand what makes observations w/ missing values different to observations w/ recorded values. 

Ex: For flights, missing values in dep_time indicate the flight was cancelled, so you might want to compare scheduled departure
  times for cancelled + non-cancelled times w/ a new variable with is.na()'

nycflights13::flights %>% 
  mutate(cancelled = is.na(dep_time),
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60
  ) %>% 
  ggplot() + 
    geom_freqpoly(aes(sched_dep_time, color = cancelled), binwidth = 1/4)

'This plot isn't great b/c there are many more non-cancelled flights than cancelled flights. 

*********************************
  7.4 Exercises
*********************************'
## What happens to missing values in a histogram? What happens to missing values in a bar chart? Why is there a difference?
nycflights13::flights %>%
  ggplot() + 
    geom_histogram(aes(dep_time)) # histogram = removed w/ STAT_BIN = removed when # of observations in each bin is calculated
# numerica values of NA are not realized, so they're not plotted

diamonds %>%
  mutate(cut = if_else(runif(n()) < 0.1, NA_character_, as.character(cut))) %>%
  ggplot() +
  geom_bar(mapping = aes(x = cut)) # bar plot = NA gets own bar --> NA is its own category

## What does na.rm = TRUE do in mean() and sum()?
# removes NA values before doing the calculation

'*********************************
  7.5  Covariation
*********************************'