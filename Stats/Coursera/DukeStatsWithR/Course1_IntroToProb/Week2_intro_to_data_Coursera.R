#---
#  title: "Introduction to data"
#output: statsr:::statswithr_lab
#---

' Some define statistics as the field that focuses on turning info into knowledge. 
The first step in that process is to summarize + describe the raw
info - the data. In this lab we explore flights, specifically a random
sample of domestic flights that departed from the 3 major 
NTC airports in 2013. We will generate simple graphical + numerical 
summaries of data on these flights + explore delay times. As this is a large 
data set, along the way you\'ll also learn the indispensable skills of data 
processing and subsetting. '

## Getting started

### Load packages

#explore data w/ `dplyr` + visualize it w/ `ggplot2` 

#```{r load-packages, message=FALSE}
library(statsr) #data sets
library(dplyr) #data manipulation
library(ggplot2) #plots
library(knitr)
#```

### Data

' The [Bureau of Transportation Statistics] (http://www.rita.dot.gov/bts/about/) 
(BTS) is a statistical agency that is a part of the Research + Innovative 
Technology Administration (RITA). As its name implies, BTS collects + makes 
transportation data available, such as flights data '

#Load the `nycflights` data frame
  
#  ```{r load-data}
data(nycflights)
#```

' The data frame containing our [nrow(nycflights) = 32735] flights that shows up in your 
workspace is a *data matrix*, w/ each row representing an *observation* + each 
column representing a *variable*. R calls this data format a **data frame**, which is 
a term that will be used throughout the labs '

#```{r names}
names(nycflights)
#```

'This returns the names of the variables in this data frame. The **codebook**
  (description of the variables) is included below. This info can also be
found in the help file for the data frame which can be accessed w/ ?nycflights

- `year`, `month`, `day`  : Date of departure
- `dep_time`, `arr_time`  : Departure + arrival times, local timezone.
- `dep_delay`, `arr_delay`: Departure + arrival delays, in minutes. 
      + Negative times represent early departures/arrivals.

- `carrier`: 2 letter carrier abbreviation.
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

- `tailnum`         : Plane tail number
- `flight`          : Flight number
- `origin`, `dest`  : Airport codes for origin + destination. (Google can help you w/ what code 
      stands for which airport.)

- `air_time`        : Amount of time spent in the air, in minutes.
- `distance`        : Distance flown, in miles.
- `hour`, `minute`  : Time of departure broken in to hour and minutes.

Take a quick peek at the data frame + view its dimensions + data types w/ str (**str**ucture)'

#```{r str}
str(nycflights)
#```

'nycflights is a massive trove of info (32375 obs of 16 vars). Let\'s think about some questions we 
  might want to answer w/ it
    - We might want to find out how delayed flights headed to a particular destination tend to be. 
    - We might want to evaluate how departure delays vary over months. 
    - We might want to determine which of the 3 major NYC airports has a better on-time % for 
      departing flights'

### Seven verbs

'`dplyr` offers 7 verbs (functions) for basic data manipulation:
  - `filter()`
  - `arrange()`
  - `select()` 
  - `distinct()`
  - `mutate()`
  - `summarise()`
  - `sample_n()`'

## Analysis

### Departure delays in flights to Raleigh-Durham (RDU)

'We can examine the distribution of departure delays of all flights W/ a histogram.
  - Plot dep_delay from nycflights on the x-axis and create a histogram w/ "geom"'

#```{r hist-dep-delay}
ggplot(data = nycflights, aes(x = dep_delay)) + geom_histogram()
#```

#Very right-skewed, so a lot of flights have a short delay, with many having negative delays (leaving early)

'Histograms are generally a very good way to see the shape of a single distribution, but that shape 
can change depending on how the data is split between the different bins. 
  -You can easily define the binwidth you want to use w/ the arg "binwidth"'

#```{r hist-dep-delay-bins}
ggplot(data = nycflights, aes(x = dep_delay)) + geom_histogram(binwidth = 15)
ggplot(data = nycflights, aes(x = dep_delay)) + geom_histogram(binwidth = 150)
#

'<div id="exercise">
**Exercise**: How do these 3 histograms w/ the various binwidths compare?
</div>'

'If we want to focus on departure delays of flights headed to RDU *only*, we need to filter the data 
for flights headed to RDU + then make a histogram of only departure delays of only those flights.'

#```{r rdu-flights-hist}
rdu_flights <- nycflights %>% filter(dest == "RDU")
ggplot(data = rdu_flights, aes(x = dep_delay)) + geom_histogram()
#```

'- Line 1 --> Take nycflights + apply filter() to it via the pipe operator (%>%) for flights w/ a destination 
of RDU + save the result in a new data frame = `rdu_flights`.
- Line 2  --> Same histogram ggplot call from earlier except it uses the rdu_flights data frame'

#Still right-skewed --> most flights have short delays, if any, w/ most being on time or early

'<div id="boxedtext">
  **Logical operators: ** Filtering for certain observations (e.g. flights from a particular airport) 
  is often of interest in data frames where we might want to examine observations w/ certain 
  characteristics separately from the rest of the data. 
To do so we use filter() + a series of **logical operators**. The most commonly used logical operators
  for data analysis are as follows:
    - `==`          ==> "equal to"
    - `!=`          ==> "not equal to"
    - `>` or `<`    ==>  "greater than" or "less than"
    - `>=` or `<=`  ==> "greater than or equal to" or "less than or equal to"
</div>'
  
#We can also obtain numerical summaries for these flights:
  
#```{r rdu-flights-summ}
rdu_flights %>% summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), n = n())
#```

'W/ summarise() we created a list of 3 USER-DEFINED elements named `mean_dd`, `sd_dd`, `n`
  -can customize these names as you like (just don\'t use spaces). 
  -Calculating these summary statistics also requires that you know the function calls. 
  - Note: n() reports sample size.
                                             
<div id="boxedtext">
  **Summary statistics: ** Useful function calls for summary statistics for a *single* numerical 
  variable are as follows:
    - `mean`
    - `median`
    - `sd`
    - `var`
    - `IQR`
    - `range`
    - `min`
    - `max`
</div>
                                             
We can also filter based on multiple criteria. Suppose we\'re interested in flights headed to SF (SFO) 
  in February:'
                                             
#```{r}
sfo_feb_flights <- nycflights %>% filter(dest == "SFO", month == 2)
#```
#We filter all flights from nycflights with a destination of SF AND in the month of Feb
                                             
'Note we separates the conditions using commas to get flights that are BOTH headed to SFO **AND** in 
  February. If interested in either flights headed to SFO **OR** in February, use `|` instead'

'1. Create a new data frame for flights headed to SFO in February, `sfo_feb_flights`. How many 
  flights meet these criteria? '
#```{r sfo-feb-flights}
str(sfo_feb_flights)
#```
'<ol>
<li> **68** </li> 
<li> 1345 </li> 
<li> 2286 </li> 
<li> 3563 </li>
<li> 32735 </li>
</ol>'
                                            
'2. Make a histogram + calculate appropriate summary stats for **arrival** delays of sfo_feb_flights. 
  Which of the following is false?'
#```{r sfo-feb-flights-arrival-delays}
ggplot(data = sfo_feb_flights, aes(x = arr_delay)) + geom_histogram()
#```
'<ol>
<li> The distribution is unimodal. </li> 
<li> The distribution is right skewed. </li> 
<li> **No flight is delayed more than 2 hours???????**. </li> 
<li> The distribution has several extreme values on the right side. </li>
<li> More than 50% of flights arrive on time or earlier than scheduled </li>
</ol>'
                                            
'Another useful functionality is being able to quickly calculate summary stats for various groups in 
your data frame. 
For example, we can modify the above command using group_by() to get the same summary stats for each 
ORIGIN airport:'
                                             
#```{r summary-custom-list-origin}
rdu_flights %>% group_by(origin) %>% summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), 
                                               n = n())
#```
                                             
'Here, we 1st grouped the data by `origin` + then calculated the summary stats
                                             
3.  Calculate the median + IQR for `arr_delay`s of flights in `sfo_feb_flights`, grouped by carrier. 
Which carrier has the highest IQR of arrival delays?'
#```{r sfo-feb-flights-arrival-delays-carrier}
sfo_feb_flights %>% group_by(carrier) %>% summarise(median_dd = median(arr_delay), 
                                                iqr_dd = IQR(arr_delay))
#```
'<ol>
<li> American Airlines </li> 
<li> JetBlue Airways </li> 
<li> Virgin America </li> 
<li> **Delta and United Airlines** </li>
<li> Frontier Airlines </li>
</ol>'
                                           
### Departure delays over months
                                             
'Which month would you expect to have the highest average delay departing from an NYC airport?
                                             
Let\'s think about how we would answer this question:
                                               
First, calculate monthly averages for departure delays. W/ the new language we\'re learning, we need 
to group by months, then summarise the mean departure delays.
Then, we need to arrange these average delays in desc ending order'
#```{r mean-dep-delay-months}
nycflights %>% group_by(month) %>% summarise(mean_dd = mean(dep_delay)) %>% arrange(desc(mean_dd))
#```
'4.  Which month has the highest average departure delay from an NYC airport?'
#```{r highest-avg-dep-delay-month}
nycflights %>% group_by(month) %>% summarise(mean_dd = mean(dep_delay)) %>% 
  arrange(desc(mean_dd))
#```
'<ol>
<li> January </li> 
<li> March </li> 
<li> **July** </li> 
<li> October </li>
<li> December </li>
</ol>

5.  Which month has the highest median departure delay from an NYC airport?'
#```{r highest-median-dep-delay-month}
nycflights %>% group_by(month) %>% summarise(median_dd = median(dep_delay)) %>% 
  arrange(desc(median_dd))
#```
'<ol>
<li> January </li> 
<li> March </li> 
<li> July </li> 
<li> October </li>
<li> **December** </li>
</ol>

6.  Is the mean or the median a more reliable measure for deciding which month(s) to avoid flying if 
you really dislike delayed flights, and why? 
<ol>
<li> Mean would be more reliable as it gives us the true average. </li> 
<li> Mean would be more reliable as the distribution of delays is symmetric. </li> 
<li> **Median would be more reliable as the distribution of delays is skewed.** </li> 
<li> Median would be more reliable as the distribution of delays is symmetric. </li>
<li> Both give us useful information. </li>
</ol>'
#```{r mean-or-median-dep-delay-month}
ggplot(data = nycflights, aes(x = dep_delay)) + geom_histogram()
#```
                                               
'We can also visualize the distributions of DEP delays across months using side-by-side box plots:'
#```{r delay-month-box}
ggplot(nycflights, aes(x = factor(month), y = dep_delay)) + geom_boxplot()
#```

'There is some new syntax here: We want departure delays on Y + months on X to produce side-by-side 
box plots. 
Side-by-side box plots require a CATEGORICAL variable on X, but in the data frame `month` is stored as
a numerical variable (1 - 12). 
Therefore we can force R to treat this as categorical (a **factor** variable w/ factor(month))'
                                             
### On time departure rate for NYC airports
                                             
'Suppose you will be flying out of NYC + want to know which of the 3 major NYC airports has the best 
on-time departure rate of departing flights. 
Suppose also that, for you, a flight delayed for < 5 minutes is basically "on time" + any flight 
#delayed > 5 minutes to be "delayed".
                                             
In order to determine which airport has the best on time departure rate,we need to 
  - 1st classify each flight as "on time" or "delayed",
  - then group flights by ORIGIN airport,
  - then calculate \'on time departure rates\' for each origin airport,
  - Finally arrange the airports in descending order for on time departure %
                                             
Classify each flight as on time or delayed by creating a new variable w/ mutate()'
                                             
#```{r dep-type}
nycflights <- nycflights %>% mutate(dep_type = ifelse(dep_delay < 5, "on time", "delayed"))
#```
                                             
'1st agr in mutate() = name of the new variable to create `dep_type`. 
Then if `dep_delay < 5` we classify the flight as `"on time"` and `"delayed"` if its not, 
               
Note we\'re also overwriting the original `nycflights` data frame w/ a new version that includes the
new `dep_type` variable.
                                             
We can handle all the remaining steps in one code chunk:'
#```{r on-time-dep-perc-airport}
nycflights %>% group_by(origin) %>% summarise(ot_dep_rate = sum(dep_type == "on time") / n()) %>% 
  arrange(desc(ot_dep_rate))
#```
                                             
'**The summarise step is telling R to count up how many records of the currently-found group are on 
time + divide that result by the total # of elements in the currently-found group to get a proportion, 
then store the answer in a new variable ot_dep_rate.**
                                             
7.  If selecting an airport simply based on on-time departure %, which NYC airport would you choose?
<ol>
<li> EWR </li> 
<li> JFK </li> 
<li> **LGA** </li> 
</ol>

We can also visualize the distribution of on on time departure rate across the 3 airports using a 
segmented bar plot.'
#```{r}
ggplot(data = nycflights, aes(x = origin, fill = dep_type)) + geom_bar()
#```
                                             
'8.  Mutate the data frame so it includes a new variable for average speed, `avg_speed`, traveled by 
the plane for each flight (in mph). What is the tail # of the plane w/ the fastest `avg_speed`? 
**Hint:** Average speed = distance / (# of hours of travel) 
  - Note that `air_time` is given in minutes. 
If you just want to show the `avg_speed` + `tailnum` + no other variables, use select() at the end of 
your  pipe to select just these 2 variables w/ `select(avg_speed, tailnum)`. 
You can Google this tail number to find out more about the aircraft.'

#```{r fastest-avg-speed-tailnum}
nycflights <- nycflights %>% mutate(avg_speed = (distance / air_time/60))
nycflights %>% arrange(desc(avg_speed)) %>% select(avg_speed,tailnum)
#```
'<ol>
<li> **N666DN** </li> 
<li> N755US </li> 
<li> N779JB </li> 
<li> N947UW </li> 
<li> N959UW </li> 
</ol>
                                             
9.  Make a scatterplot of `avg_speed` vs. `distance`. Which of the following is true about the 
relationship between average speed and distance.'
#```{r avg-speed-dist-scatter}
ggplot(nycflights, aes(x = distance, y = avg_speed)) + geom_point()
#```
'<ol>
<li> As distance increases the average speed of flights decreases. </li> 
<li> The relationship is linear. </li> 
<li> **There is an overall postive association between distance and average speed**.</li> 
<li> There are no outliers. </li> 
<li> The distribution of distances are uniform over 0 to 5000 miles. </li> 
</ol>

10.  Suppose you define a flight to be "on time" if it gets to the destination on time or earlier 
than expected, regardless of any departure delays. 
Mutate the data frame to create a new variable `arr_type` w/ levels `"on time"` + `"delayed"` based 
on this definition. 
Then, determine the on time arrival percentage based on whether the flight departed on time or not. 
What proportion of flights that were `"delayed"` departing arrive `"on time"`? [NUMERIC INPUT]'
                                             
#```{r on-time-arr-perc}
nycflights <- nycflights %>% mutate(arr_type = ifelse(arr_delay <= 0, "on time", "delayed"))
nycflights %>% group_by(dep_type) %>% summarise(ot_arr_rate = sum(arr_type == "on time") / n()) %>% 
  arrange(desc(ot_arr_rate))
#```
#18.34%