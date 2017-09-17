library(tidyverse)
library(nyc)
library(nycflights13)

# explore the basic data manipulation verbs of dplyr
# nycflights13::flights --> data frame w/ all 336,776 flights departed from NYC in 2013 from Bureau of Transportation Statistics
flights

# Tibbles = data frames but slightly tweaked to work better in tidyverse. 

' 5 key dplyr functions to solve vast majority of data manipulation challenges:
   - filter() = Pick/subset observations by their values
   - arrange() = Reorder rows 
   - select() = Pick variables by names
   - mutate() = Create new variables w/ functions of existing variables
   - summarise() = Collapse many values down to a single summary

 ^^ can all be used in conjunction w/ group_by() = changes scope of each function from operating on entire datasets to operating on it
group-by-group. These six functions provide the verbs for a language of data manipulation.

All verbs work similarly:
  - 1st arg = data frame.
  - subsequent arguments describe what to do w/ the data frame, using variable names (without quotes)
  - result = a new data frame'

'******************************************************'
'5.2 FILTER'
'******************************************************'
# get just flights on Jan 1
filter(flights, month == 1, day == 1)
# cuts down to 842 flights

# save filter result dataframe 
jan <- filter(flights, month == 1, day == 1)

# to save results in a variable AND view output, wrap whole statement in ()'s
# get just Christmas day flights
(dec25 <- filter(flights, month == 12, day == 25))

# CPUs use finite precision arithmetic (can't store infinite # of digits)
# remember every number you see = an approximation
# so instead of relying on ==, use near():

# fails
sqrt(2)^2 == 2

# works
near(1/49 * 49, 1)

# all flights that departed in November or December
filter(flights, month == 11 | month == 12)

# alternate with IN statement
filter(flights, month %in% c(11,12))

#  De Morgan's law
#   - !(x & y) = !x | !y
#   - !(x | y) = !x & !y

# flights that weren't delayed (on arrival AND departure) by more than 2 hours
filter(flights, dep_delay <= 120 & arr_delay <= 120)
filter(flights, !(dep_delay > 120 | arr_delay > 120))

# Whenever starting to use complicated, multipart expressions in filter(), consider making them explicit variables instead 
# makes it much easier to check work

# filter() only includes rows where a condition == TRUE + excludes both FALSE + NA values. 
# to preserve missing values, ask for them explicitly
df <- tibble(x = c(1, NA, 3))
filter(df, is.na(x) | x > 1)

'******************************************************'
'5.2 EXERCISES'
'******************************************************'

## Find all flights that had an arrival delay of two or more hours
filter(flights, arr_delay >= 120)

## Find all flights that Flew to Houston (IAH or HOU)
filter(flights, dest == "IAH" | dest == "HOU")

## Find all flights that Were operated by United, American, or Delta
table(flights$carrier)
filter(flights, carrier %in% c("UA","AA","DL"))

## Find all flights that Departed in summer (July, August, and September)
filter(flights, month %in% c(7:9))

## Find all flights that Arrived more than two hours late, but didn't leave late
filter(flights, arr_delay > 120 & dep_delay <= 0)

## Find all flights that Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, dep_delay >= 60 & dep_delay-arr_delay > 30)

## Find all flights that Departed between midnight and 6am (inclusive)
filter(flights, dep_time <= 600 | dep_time >= 2400)

## Another useful dplyr filtering helper = ?between()
##  - shortcut for >= & <= 
## Can you use it to simplify the code needed to answer the previous challenges?
filter(flights, between(dep_time,600,2400))
filter(flights, between(month,7,9))

## How many flights have a missing dep_time? 
summary(flights$dep_time) # = 8255

## What other variables are missing? What might these rows represent?
summary(flights)
# other missing = dep_time, dep_delay, arr_time, arr_delay, air_time
# might represent cancelled flights

## Why is NA ^ 0 not missing? 
# bc anything to the 0-power = 1

## Why is NA | TRUE not missing? 
# bc at least 1 side is TRUE

## Why is FALSE & NA not missing?
# since 1 value if FALSE, result is FALSE since & needs both sides to be TRUE