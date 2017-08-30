#---
#  title: "Introduction to data"
#output: statsr:::statswithr_lab
#---

' Some define statistics as the field that focuses on turning info into knowledge. 
The 1st step in that process is to summarize + describe the raw info - the data. 

In this lab we explore flights, specifically a random sample of domestic flights that departed from
the 3 major NTC airports in 2013. We will generate simple graphical + numerical summaries of data 
on these flights + explore delay times. As this is a large data set, along the way you\'ll also learn 
the indispensable skills of data processing and subsetting. '


### Load packages
library(statsr) # data sets
library(dplyr) # data manipulation + EDA
library(ggplot2)
library(knitr)

### Data
' The [Bureau of Transportation Statistics] (http://www.rita.dot.gov/bts/about/) (BTS) is a statistical 
agency that is a part of the Research + Innovative Technology Administration (RITA). As its name implies, 
BTS collects + makes transportation data available, such as flights data '

#Load the `nycflights` data frame
data(nycflights)

'The data frame containing flights that shows up in your workspace is a *data matrix*, w/ each row 
representing an *observation* and each column representing a *variable* = a **data frame**'
names(nycflights)
'- `year`, `month`, `day`: Date of departure
- `dep_time`, `arr_time`: Departure and arrival times, local timezone.
- `dep_delay`, `arr_delay`: Departure and arrival delays, in minutes. Negative times represent early departures/arrivals.
- `carrier`: Two letter carrier abbreviation.
    + `9E`:           Endeavor Air Inc.
    + `AA`:      American Airlines Inc.
    + `AS`:        Alaska Airlines Inc.
    + `B6`:             JetBlue Airways
    + `DL`:        Delta Air Lines Inc.
    + `EV`:    ExpressJet Airlines Inc.
    + `F9`:      Frontier Airlines Inc.
    + `FL`: AirTran Airways Corporation
    + `HA`:      Hawaiian Airlines Inc.
    + `MQ`:                   Envoy Air
    + `OO`:       SkyWest Airlines Inc.
    + `UA`:       United Air Lines Inc.
    + `US`:             US Airways Inc.
    + `VX`:              Virgin America
    + `WN`:      Southwest Airlines Co.
    + `YV`:          Mesa Airlines Inc.
- `tailnum`: Plane tail number
- `flight`: Flight number
- `origin`, `dest`: Airport codes for origin and destination. 
- `air_time`: Amount of time spent in the air, in minutes.
- `distance`: Distance flown, in miles.
- `hour`, `minute`: Time of departure broken in to hour and minutes.'

#str(nycflights)
glimpse(nycflights)

'The `nycflights` data frame is a massive trove of info. Let\'s think about some questions we
might want to answer with these data:
  - Find out how delayed flights headed to a particular destination tend to be. 
  - Evaluate how departure delays vary over months. 
  - Determine which of the 3 major NYC airports has a better on time % for departing flights.'

## Analysis

'dplyr package offers seven verbs (functions) for basic data manipulation:
  - `filter()`
  - `arrange()`
  - `select()` 
  - `distinct()`
  - `mutate()`
  - `summarise()`
  - `sample_n()`'

### Departure delays in flights to Raleigh-Durham (RDU)

# examine distribution of departure delays of all flights with a 
ggplot(nycflights) + geom_histogram(aes(dep_delay))

'See it is very right-skewed, meaning most flights have litte/no delay'

# different bins
ggplot(nycflights) + geom_histogram(aes(dep_delay),binwidth = 15)
ggplot(nycflights) + geom_histogram(aes(dep_delay),binwidth = 150)


# focus on departure delays of flights headed to RDU only
rdu_flights <- nycflights %>%
                filter(dest == 'RDU')

ggplot(rdu_flights) + geom_histogram(aes(dep_delay))

# obtain numerical summaries for these flights:
rdu_flights %>%
  summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), n = n())
# summarise --> create a list of  user-defined elements `mean_dd`, `sd_dd`, `n`, where n = sample size
                                             
'**Summary statistics: 
  - `mean`
  - `median`
  - `sd`
  - `var`
  - `IQR`
  - `range`
  - `min`
  - `max`'

# flights headed to San Francisco (SFO) in February:
sfo_feb_flights <- nycflights %>%
                    filter(dest == 'SFO', month == 2)

'***********************QUIZ**********************************'

# How many flights meet these criteria? 
glimpse(sfo_feb_flights) #68 obs.

# Make a histogram + calculate appropriate summary statistics for arrival delays of `sfo_feb_flights`. 
ggplot(sfo_feb_flights) + geom_histogram(aes(arr_delay))
summary(sfo_feb_flights$arr_delay)
# The distribution is unimodal + right skewed, some flights are delayed more than 2 hours (x = minutes)
# See distribution several extreme values on the right side.
# More than 50% of flights arrive on time or earlier than scheduled. 

#calculate summary stats w/ dplyr
sfo_feb_flights %>%
  summarise(mean_ad = mean(arr_delay), sd_ad = sd(arr_delay), n = n())

# Calculate median + IQR for `arr_delay`s of flights in sfo_feb_flights, grouped by carrier. 
# Which carrier has the hightest IQR of arrival delays? 
sfo_feb_flights %>%
  group_by(carrier) %>%
  summarise(mean_ad = mean(arr_delay), sd_ad = sd(arr_delay), IQR(arr_delay), n = n())
# Delta and United Airlines

### Departure delays over months
                                             
# Which month would you expect to have the highest average delay departing from an NYC airport?
nycflights %>%
  group_by(month) %>%
  summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), med_dd = median(dep_delay), n = n())
# July

# Which month has the highest median departure delay from an NYC airport?
# Dec (look in same tibble as above)

# Is the mean or the median a more reliable measure for deciding which month(s) to avoid flying
#   if you really dislike delayed flights, and why? 
ggplot(nycflights) + 
  geom_histogram(aes(dep_delay)) + 
  ggtitle('Distribution of Delays from NYC')
# Median would be more reliable as the distribution of delays is skewed. </li> 

# visualize distribution of departure delays across months using side-by-side box plots
#   `month` is stored as a numerical variable --> force R to treat as categorical = factor
ggplot(nycflights) +
  geom_boxplot(aes(factor(month), dep_delay)) + 
  ggtitle('Delays from NYC by Month')

### On time departure rate for NYC airports
                                             
'Suppose you will be flying out of NYC + want to know which of the 3 major NYC airports has the best 
on-time departure rate of departing flights. Suppose also that for you a flight that is delayed < 5 
minutes is  basically "on time". You consider any flight delayed for 5 minutes of more to be "delayed".
                                             
In order to determine which airport has the best on time departure rate, we need to 1st classify each 
flight as "on time" or "delayed", group flights by origin airport, calculate on time departure rates for
each origin airport, + finally arrange the airports in descending order for on time departure percentage.'

nycflights <- nycflights %>%
  mutate(on_time = dep_delay < 5) # new column

nycflights %>% 
  group_by(origin) %>%
  summarise(on_time_dep_rate = sum(on_time)/n()) %>% # get departure rate by our summarized groups
  arrange(desc(on_time_dep_rate))

# If selecting an airport simply based on on time departure %, which would you choose? 
# LGA

#visualize distribution of on_time_dep_rate the 3 airports using a segmented bar plot.
ggplot(nycflights) + 
  geom_bar(aes(origin, fill = on_time))

# add new variable that contains average speed, `avg_speed` traveled by the plane for each flight (in mph).
glimpse(nycflights)
# `air_time` is given in minutes. 
nycflights <- nycflights %>%
  mutate(avg_speed = distance/(air_time/60))

# What is the tail number of the plane with the fastest avg_speed?

nycflights %>%
  arrange(desc(avg_speed)) %>%
  select(tailnum, avg_speed) # see just 2 columns
# N666DN

# Make a scatterplot of `avg_speed` vs. `distance`. 
ggplot(nycflights) + 
  geom_point(aes(avg_speed,distance))

# As average speed increases, distance of flights increases = an overall postive association 
#   between distance and average speed. 
# The relationship is non-linear, there are outliers, and the distribution of distances are not 
#   uniform over 0 to 5000 miles

'Suppose you define a flight to be "on time" if it gets to the destination on time or earlier than expected,
regardless of any departure delays'

# create a new variable `arr_type` w/ levels `"on time"` +`"delayed"` based on this definition. 
nycflights <- nycflights %>%
  mutate(arr_type = ifelse(arr_delay <= 0, 'on-time','delayed'))

# determine the on time arrival % based on whether the flight departed on time or not (flight was delayed
#   but arrived on time)
nycflights %>% group_by(on_time) %>% summarise(ot_arr_rate = sum(arr_type == "on time") / n()) %>% 
  arrange(desc(ot_arr_rate))
#18.34%