library(tidyverse)
library(nycflights13)

## Ctrl + Shift + P. ==> resends previously sent chunk from the editor to the console. 
##  - very convenient when exploring 
## send a whole block once with Ctrl + Enter, then modify + press Ctrl + Shift + P to resend block.

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

'******************************************************'
'5.3 ARRANGE()'
'******************************************************'
# arrange() works similarly to filter() except instead of selecting rows, it changes their order. 
# takes a data frame + a set of col name/more complicated expressions to order by. 
# provide more than 1 column name = mulitple levels

# arrange flights by YMD in ASC
arrange(flights, year, month, day)

# arrange flights GREATEST arrival delay
arrange(flights, desc(arr_delay))

# missing values = always sorted at end
df <- tibble(x = c(5, 2, NA))
arrange(df, x)

arrange(df, desc(x))

'******************************************************'
'5.3 EXERCISES'
'******************************************************'

# How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).
summary(flights)
arrange(flights, desc(is.na(arr_delay)))

# Sort flights to find the most delayed flights. 
arrange(flights, desc(dep_delay))

# Find the flights that left earliest.
arrange(flights, dep_time)

# Sort flights to find the fastest flights.
arrange(flights, desc(air_time/distance))

# Which flights travelled the longest? 
arrange(flights, desc(distance))

# Which travelled the shortest?
arrange(flights, distance)

'******************************************************'
'5.4 SELECT()'
'******************************************************'
## allows you to rapidly zoom in on a useful subset using operations based on names of variables.
## useful w/ 100s-1000s of variables

# select only date cols
select(flights, year, month, day)
select(flights, year:day)

# select all cols except date cols
select(flights, -(year:day))

## Helper functions you can use within select():
##  - starts_with(), ends_with() , contains()
##  - matches(): selects variables that match a  RegEx
##  - num_range("x", 1:3) matches x1, x2 and x3.
select(flights, contains("dep"))

## can use select() to rename vars, but it drops all vars not explicitly mentioned
## instead use rename(df, new = old)
rename(flights, miles = distance)

## can use select() in conjunction w/ the everything() helper. 
## useful w/ a handful of variables you'd like to move to the start of the data frame
select(flights, air_time, everything()) 

'******************************************************'
'5.4 EXERCISES'
'******************************************************'
## Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.
select(flights, "dep_time","dep_delay","arr_time","arr_delay")
select(flights, c(4,6,7,9))
select(flights, starts_with("dep"), starts_with("arr"))
select(flights, ends_with("time"), ends_with("delay"), -starts_with('sched'), -starts_with('air'))
select(flights, contains("dep_"), contains("arr_"), -starts_with('sched'))

## What happens if you include the name of a variable multiple times in a select() call?
select(flights, year, year)
# only shows up once
  
## What does one_of() function do? Why might it be helpful in conjunction with this vector?
select(flights, one_of(c("year", "month", "day", "dep_delay", "arr_delay")))

## Does the result of running the following code surprise you? 
select(flights, contains("TIME"))

## How do the select helpers deal with case by default? How can you change that default?
select(flights, contains("TIME", ignore.case = F))
select(flights, contains("TIME", ignore.case = T))

'******************************************************'
'5.5 MUTATE()'
'******************************************************'
## mutate adds new variables as functions of existing ones --> only at end of dataset

# create smaller dataset to see mutate() results
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time)
# new cols
mutate(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = (distance / air_time) * 60,
       # refer to new vars in even newer var
       hours = air_time / 60,
       gain_per_hour = gain / hours)

## to only keep new vals use transmute()
transmute(flights_sml, 
       gain = arr_delay - dep_delay,
       speed = (distance / air_time) * 60,
       # refer to new vars in even newer var
       hours = air_time / 60,
       gain_per_hour = gain / hours)

'Many functions for creating new variables you can use w/ mutate(). 
  - Key property = function must be *vectorised* = take a vector of values as input, return a vector w/ same # of values as output. 
  - Selection of functions that are frequently useful:
  - Arithmetic operators: +, -, *, /, > ==> all vectorised, using "recycling rules" 
    - "recycling rules" = If 1 parameter is shorter than the other, it will be automatically extended to be the same length. 
    - most useful when 1 argument is a single number: air_time / 60, hours * 60 + minute, etc.
    - Arithmetic operators are also useful in conjunction w/ the aggregate functions 
    - Ex: x / sum(x) calculates a proportion of a total, y - mean(y) computes difference from the mean.
  - Modular arithmetic: %/% (integer division) + %% (remainder)
    - x == y * (x %/% y) + (x %% y). 
    - Modular arithmetic = handy tool b/c allows you to break integers up into pieces. 
    - Can compute hour and minute from dep_time with:'
transmute(flights, hour = air_time %/% 60, minute = air_time %% 60)
transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)

' - Logs: log(), log2(), log10() = incredibly useful for dealing w/ data that ranges across multiple orders of magnitude. 
    - also convert multiplicative relationships to additive
    - All else being equal, log2() = easiest to interpret --> difference of 1 on log scale = doubling on original scale +
        a difference of -1 corresponds to halving.
  - Offsets: lead() + lag() allow you to refer to leading or lagging values
    - allows you to compute running differences (e.g. x - lag(x)) or find when values change (x != lag(x)).
    - most useful in conjunction w/ group_by()'
x <- 1:10
lag(x,4) # lag vector by 4 positions (chop off last n elements)
lead(x,4) # lead vector by 4 positions (chop off 1st n elements)

'  - Cumulative + rolling aggregates = running sums, products, mins,  maxes w/ cumsum(), cumprod(), cummin(), cummax()
    - dplyr provides cummean() for cumulative means
    - For rolling aggregates (i.e. sum computed over a rolling window), try RcppRoll package'
cumsum(x)
cummean(x)

' - Logical comparisons, <, <=, >, >=, !=
    - If doing a complex sequence of logical operations it`s often a good idea to store the interim values in new variables 
        so you can check that each step is working as expected.
  - Ranking: # of ranking functions, but start w/ min_rank() = does most usual type of ranking (e.g. 1st, 2nd, 2nd, 4th). 
    - The default gives smallest values small ranks --> use desc(x) to give the largest values the smallest ranks.'
y <- c(1, 2, 2, NA, 3, 4)
?min_rank(y)
'[1]  1  2  2 NA  4  5 ==> 1st lowest, tied for 2nd, tied for 2nd (no 3rd), NA, 4th lowest (bc no 3rd), 5th least'
min_rank(desc(y)) 
'[1]  5  3  3 NA  2  1 ==> least greatest, tied for 3rd least greatest NA, 2nd least greatest, 1st least greatest'

'   - If min_rank() doesn`t do what you need, look at variants row_number(), dense_rank(), percent_rank(), cume_dist(), ntile(). '
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)

'******************************************************'
'5.5 EXERCISES()'
'******************************************************'
## Currently dep_time and sched_dep_time are convenient to look at, but hard to compute w/ b/c they're not really continuous numbers. 
## Convert them to a more convenient representation of number of minutes since midnight.
mutate(flights, 
       dep_midnight = (dep_time %/% 100)*60 + (dep_time %% 100),
       sched_dep_time_after_midnight = (sched_dep_time %/% 100)*60 + (sched_dep_time %% 100)) %>% 
  select(dep_time,dep_midnight,sched_dep_time,sched_dep_time_after_midnight) 

## Compare air_time with arr_time - dep_time. What do you expect to see? What do you see? What do you need to do to fix it?
mutate(flights, 
       air_time_2 = ((arr_time %/% 100)*60 + (arr_time %% 100)) - ((dep_time %/% 100)*60 + (dep_time %% 100))) %>%
  select(air_time, air_time_2)
# even after converting from clock format to minutes after midnight, they should be the same


## Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?
# expect sched_dep_time - dep_time = dep_delay
mutate(flights, dep_delay2 = dep_time - sched_dep_time) %>%
  select(sched_dep_time, dep_time, dep_delay, dep_delay2)
# 2nd dep_delay is off due to clock formatting of time vars

##  Find the 10 most delayed flights using a ranking function. How do you want to handle ties? 
# most delayed
as.data.frame(head(arrange(flights, desc(dep_delay)),15))

as.data.frame(head(arrange(flights, desc(dep_delay)),15)) %>%
  mutate(delayed_rank = min_rank(-dep_delay)) %>%
  select(1:5, delayed_rank)
# there are no ties for the top 10 most delayed

## What does 1:3 + 1:10 return? Why?
1:3 + 1:10
# mismatched length of data not currently vectorized
  
## What trigonometric functions does R provide?
'cos(x)
sin(x)
tan(x)

acos(x)
asin(x)
atan(x)
atan2(y, x)

cospi(x)
sinpi(x)
tanpi(x)'

'******************************************************
5.6 Grouped summaries with summarise()
******************************************************'
## summarize collapses dataframes to single rows
summarize(flights, delay = mean(dep_delay, na.rm = T))

## not terribly useful unless paired w/ group_by --> changes unit of analysis from a complete dataset to individual groups. 
## when using dplyr verbs on a grouped data frame they'll be automatically applied "by group". 

# get average delay by date
group_by(flights, year, month, day) %>%
  summarize(delay = mean(dep_delay, na.rm = T))

## group_by() + summarise() provide 1 of the tools used most commonly when working w/ dplyr: grouped summaries.

# explore the relationship between the distance and average delay for each destination w/ pipes
group_by(flights, dest) %>%
    summarize(count = n(),
              dist = mean(distance, na.rm = T),
              delay = mean(dep_delay, na.rm = T)) %>%
  filter(count > 20, dest != "HNL") %>%
  ggplot(aes(dist,delay)) + # graph scatterplot of relationship
    geom_point(aes(size = count), alpha = 1/3) + # make each point grow according to count of flights leaving each destination   
    geom_smooth(se = FALSE) # remove CI bands

## x %>% f(y) turns into f(x, y), and x %>% f(y) %>% g(z) turns into g(f(x, y), z) and so on.

## aggregation functions obey the usual rule of missing values: if there's ANY missing value in the input, output = a missing value. 
## Fortunately, all aggregation functions have na.rm arguments

# for missing values that represent cancelled flights, removing the cancelled flights
non_cancelled_flights <- filter(flights, !is.na(arr_delay), !is.na(dep_delay)) 

non_cancelled_flights %>% group_by(year,month,day) %>%
  summarize(mean = mean(dep_delay))

## Whenever you do any aggregation = always good idea to include either a count (n()), or count of non-missing values (sum(!is.na(x))).
## helps check that you're not drawing conclusions based on very small amounts of data. 

# look at planes (identified by their tail number) that have the highest average delays
delays <- non_cancelled_flights %>% 
  group_by(tailnum) %>%
  summarize(delay = mean(dep_delay))# %>%

delays %>%
  ggplot() + 
    geom_freqpoly(aes(delay), binwidth = 10)
# some planes have delays > 5 hrs (> 300 minutes)

# draw scatterplot of flights vs avg delay
delays2 <- non_cancelled_flights %>% 
  group_by(tailnum) %>%
  summarize(delay = mean(dep_delay, na.rm = T),
            n = n())

delays2 %>%
  ggplot() + 
  geom_point(aes(n,delay), alpha = 1/10)
# very few DPs > 400 min delay

## Look at average performance of batters in baseball as related to at-bats
batting <- as.tibble(Lahman::Batting)

# plot skill of batter (measured by ba) against # of opportunities to hit the ball (at-bat, ab),
# 1) get BA + ABs per each player
batters <- batting %>%
  group_by(playerID) %>%
  summarize(ba = sum(H, na.rm = T) / sum(AB, na.rm = T),
            ab = sum(AB, na.rm = T))

# plot it
batters %>%
  filter(ab > 100) %>%
  ggplot(aes(ab,ba)) + 
    geom_point() + 
    geom_smooth(se = F)
## as ABs increase, BA barely increases, and its a wide range for small #'s of ABs (not surprising)
## 2 patterns
##    1) As above, variation in our aggregate decreases as we get more DPs.
##    2) Have positive correlation between skill (BA) + opportunities to hit the ball (AB)
##        - This is b/c teams control who gets to play will obviously pick best players.

## This also has important implications for ranking. 

# *naively* sort players w/ best BA 
batters %>%
  arrange(desc(ba)) %>%
  mutate(ba_rank = min_rank(-ba))
# clearly lucky, not necessarily skilled:

## R provides many other useful summary functions:
##  - median()

##  - sometimes useful to combine aggregation w/ logical subsetting
non_cancelled_flights %>%
  group_by(year, month, day) %>%
  summarize(overall_avg_delay = mean(arr_delay),
            positive_avg_delay = mean(arr_delay[arr_delay > 0]))
#     -see negative delays highly change data results

##  - measures of spread = sd(), IQR(), mad() - median absolute deviation
##      - 2nd two are more robust (less sensitive to outliers)
# Why is distance to some destinations more variable than to others?
non_cancelled_flights %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance),
            distance_iqr = IQR(distance),
            distance_mad = mad(distance)) %>%
  arrange(desc(distance_sd))

## measures of rank = min(), max(), quantile(x, .25) = value which 25% of data in x are below 
##    - quantiles = generalization of median
# When do the first and last flights leave each day?
non_cancelled_flights %>%
  group_by(year, month, day) %>%
  summarize(first_flight = min(dep_time),
            last_flight = max(dep_time))

## measures of position = first(), last(), nth(x,position) --> similar to x[1],x[2], etc.
##  - also similar to x[length(x)]
##  - THESE allow you to set default values for positions that don't exist (3rd element from [1,2])
non_cancelled_flights %>%
  group_by(year, month, day) %>%
  summarize(first_flight = first(dep_time,default = 2400),
            last_flight = last(dep_time, default = 2399))

## position functions = complementary to filtering on ranks. 
##    - Filtering gives you all variables, w/ each observation in a separate row:
non_cancelled_flights %>%
  filter(year,month,day) %>%
  mutate(rank = min_rank(desc(dep_time))) %>%
  filter(rank %in% range(rank)) %>%
  select(1:9,rank)

## n() returns counts/size of current group
## count non-missing values -> sum(!is.na(x))
## count distinct values --> n_distinct(x)

# Which destinations have the most carriers?
non_cancelled_flights %>%
  group_by(dest) %>%
  summarise(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))

# which airports had most destinations
non_cancelled_flights %>% 
  count(dest) %>%
  arrange(desc(n))

## can optionally provide a weight variable

# use weights to count sum total number of miles a plane flew: 
non_cancelled_flights %>% 
  count(tailnum, wt = distance)

## Counts + proportions of logical values: sum(x > 10), mean(y == 0). 
##  - When used w/ numeric functions, TRUE converted to 1, FALSE to 0. 
##  - This makes sum() + mean() very useful as sum(x) gives # of TRUEs in x + mean(x) 
##      gives the proportion.

#  How many flights left before 5am on each day? 
#   - (usually indicates delayed flights from previous day)
non_cancelled_flights %>% 
  group_by(year,month,day) %>%
  summarize(early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
non_cancelled_flights %>%
  group_by(year,month,day) %>%
  summarise(prop_delay_over_1hr = mean(arr_delay > 60))

'*******************5.6.5 Grouping by multiple variables***************************'
## multiple levels of grouping = makes it easier to progressively roll-up a dataset

daily <- flights %>%
  group_by(year,month,day)

(per_day <- daily %>%
    summarize(num_flights = n()))

(per_month <- per_day %>%
    summarize(num_flights = sum(num_flights)))


(per_year <- per_month %>%
    summarize(num_flights = sum(num_flights)))

## Be careful when progressively rolling up summaries --> OK for sums + counts, 
##    - but need to think about weighting means + variances
##    - not possible to do it exactly for rank-based statistics like median. 
##    - i.e. sum of groupwise sums = overall sum, but median of groupwise medians != overall median.

'****************UNGROUPING**************************'
daily %>% 
  ungroup() %>% # not longer grouped by date at all
  summarize(num_flights = n()) # total flights in whole ungrouped dataset

'******************************************************'
'5.6 EXERCISES'
'******************************************************'
## Brainstorm 5+ different ways to assess typical delay characteristics of a group of flights. 
## Consider the following scenarios:
##  - Flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
non_cancelled_flights %>%
  group_by(flight) %>%
  summarise(prop_early_over_half = mean(arr_delay < -15, na.rm = T),
            prop_late_over_half = mean(arr_delay > 15,  na.rm = T)) %>%
  filter(prop_early_over_half == .5 & prop_late_over_half == .5)
# there are none

##  - A flight is always 10 minutes late.
non_cancelled_flights %>%
  group_by(flight) %>%
  filter(arr_delay == 10)

## A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
non_cancelled_flights %>%
  group_by(flight) %>%
  summarise(prop_early_over_half = mean(arr_delay < -30, na.rm = T),
            prop_late_over_half = mean(arr_delay > 30,  na.rm = T)) %>%
  filter(prop_early_over_half == .5 & prop_late_over_half == .5)

## 99% of the time a flight is on time. 1% of the time it's 2 hours late.
non_cancelled_flights %>%
  group_by(flight) %>%
  summarise(prop_on_time = mean(arr_delay == 0, na.rm = T),
            prop_2hrs_late = mean(arr_delay == 120,  na.rm = T)) %>%
  filter(prop_on_time == .99 & prop_2hrs_late == .01)

## Which is more important: arrival delay or departure delay?

## Come up w/ another approach to get the same output as: (without using count()).
non_cancelled_flights %>% count(dest)

non_cancelled_flights %>% group_by(dest) %>% summarize(count = n())

## Come up w/ another approach to get the same output as: (without using count()).
non_cancelled_flights %>% count(tailnum, wt = distance) 

non_cancelled_flights %>% group_by(tailnum) %>% summarize(distance = sum(distance))

## Definition of cancelled flights ==> (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal. 
# only need flights that did not depart, as they cannot arrive if they didn't depart

## Look at # of cancelled flights per day. Is there a pattern? Is the proportion of cancelled
##  flights related to the average delay?
flights %>%
  group_by(year,month,day) %>%
  summarise(cancelled_flights = sum(!is.na(dep_delay)),
            prop_cancelled = mean(is.na(dep_delay)),
            avg_delay = mean(dep_delay, na.rm = T)) %>%
  arrange(desc(prop_cancelled)) %>%
  ggplot(aes(avg_delay,prop_cancelled)) +
    geom_point()
# looks like a slight positive one, with outliers

## Which carrier has the worst delays? Challenge: 
non_cancelled_flights %>% 
  group_by(carrier) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = T)) %>%
  arrange(desc(avg_delay))

## can you disentangle the effects of bad airports vs. bad carriers? Why/why not? 
non_cancelled_flights %>% group_by(carrier, dest) %>% summarise(n())

## What does the sort argument to count() do. When might you use it?

'*****************5.7 Grouped mutates (and filters)********************'
## Grouping = most useful in conjunction w/ summarise(), but can also do convenient operations
##    w/ mutate() and filter():
  
# Find the worst members of each group: find words delay for each day
flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

## Find all groups bigger than a threshold: find all flights to destinations w/ > 365 flights to it
(popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365))

## Standardise to compute per group metrics:
popular_dests %>% 
  filter(arr_delay > 0) %>% # get all delayed flights
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% # how much did this delay contribute to overall
  select(year:day, dest, arr_delay, prop_delay)

## grouped filter = a grouped mutate followed by an ungrouped filter. 
##  - generally avoid them except for quick + dirty manipulations
##  - otherwise hard to check you've done the manipulation correctly.

## window functions = Functions that work most naturally in grouped mutates + filters 
##  - (vs. the summary functions used for summaries).

'******************************************************'
'5.7 EXERCISES'
'******************************************************'
## Refer back to the lists of useful mutate + filtering functions. Describe how each operation changes when you combine it with grouping.

## Which plane (tailnum) has the worst on-time record?
non_cancelled_flights %>% 
  group_by(tailnum) %>%
  rank(desc(arr_delay))
  #filter(rank(desc(mean(is.na(arr_delay))))
What time of day should you fly if you want to avoid delays as much as possible?

For each destination, compute the total minutes of delay. For each, flight, compute the proportion of the total delay for its destination.

Delays are typically temporally correlated: even once the problem that caused the initial delay has been resolved, later flights are delayed to allow earlier flights to leave. Using lag() explore how the delay of a flight is related to the delay of the immediately preceding flight.

Look at each destination. Can you find flights that are suspiciously fast? (i.e. flights that represent a potential data entry error). Compute the air time a flight relative to the shortest flight to that destination. Which flights were most delayed in the air?

Find all destinations that are flown by at least two carriers. Use that information to rank the carriers.

For each plane, count the number of flights before the first delay of greater than 1 hour.