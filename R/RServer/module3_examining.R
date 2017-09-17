'############## Module 3 - Examining data***********************************'

'In addition to asking whether data makes logical sense, it`s often a good idea to also check whether data makes *business* or 
*practical* sense. 
Doing so can catch certain errors in data such as data being mislabeled or attributed to the wrong set of features. 
If unaccounted, such soft errors can have a profound impact on the analysis.'

library(RevoScaleR)
library(tidyverse)

# read in prepated XDF file
nyc_xdf <- RxXdfData("C:/Users/Nimz/Dropbox/yellow_tripdata_2016_prepped.xdf")

# get summary of all variables
system.time(
  rxs_all <- rxSummary(~ ., nyc_xdf)
)

# look at the sDataFrame object
head(rxs_all$sDataFrame)
'                   Name       Mean      StdDev       Min     Max ValidObs MissingObs
1              VendorID         NA          NA        NA      NA  3467953          0
2  tpep_pickup_datetime         NA          NA        NA      NA        0          0
3 tpep_dropoff_datetime         NA          NA        NA      NA        0          0
4       passenger_count   1.660282    1.310446    0.0000 9.0e+00  3467953          0
5         trip_distance   6.510352 6445.865846    0.0000 1.2e+07  3467953          0
6      pickup_longitude -72.922786    8.753392 -121.9333 0.0e+00  3467953          0'


# look at interaction between pickup neighborhood + pickup borough
# NOTE - we have much more factor levels than are in actual data (all nhoods is our data = Manhattan)
#     - will therefore only find Manhattan boroughs
nhoods_by_borough <- ?rxCrossTabs(~ pickup_nhood:pickup_borough, nyc_xdf)

# reshape into dataframe in wide format (boroughs are cols)
nhoods_by_borough <- nhoods_by_borough$counts[[1]]  %>%
  as.data.frame

head(nhoods_by_borough)

# pull out nhoods that fall in Manhattan (where borough counts > 0)
# want to later refactor the column + only have nhoods in Manhattan as the relevant factor levels for the column

# get nhood by borough
lnbs <- lapply(names(nhoods_by_borough), function(v) subset(nhoods_by_borough, nhoods_by_borough[, v] > 0, 
                                                            select = v, drop = F))
lapply(lnbs, head)
'[[5]]
              New York City-Manhattan
Battery Park                    32074
Carnegie Hill                   40372
Central Park                    46782
Chelsea                        229433
Chinatown                       10532
Clinton                        102072'

# pull out the names of these boroughs via getting row names whose counts > 0 in the Manhattan column
manhattan_nhoods <- rownames(nhoods_by_borough)[nhoods_by_borough$"New York City-Manhattan" > 0]
manhattan_nhoods

# limit to only Manhattan neighborhoods
refactor_columns <- function(data) { # transformation function to create variables of Manhattan neighborhoods with levels from above
  
  # cut down many levels to only those we're interested in (Manhattan)
  # do it by searching current XDF neighborhood factors and NOT characters bc doing this in chunks with big data
  data$pickup_nbhood <- factor(data$pickup_nhood, levels = nhoods_levels)
  data$dropoff_nbhood <- factor(data$dropoff_nhood, levels = nhoods_levels)
  
  # return the list
  data
}

# edit XDF file with function
rxDataStep(nyc_xdf, nyc_xdf, transformFunc = refactor_columns, 
           transformObjects = list(nhoods_levels = manhattan_nhoods), overwrite = T)

# look at the counts of Manhattan pickup and dropoff neighborhoods
rxs_pickdrop <- rxSummary(~ pickup_nbhood:dropoff_nbhood, nyc_xdf)
head(rxs_pickdrop$categorical[[1]])
'  pickup_nbhood dropoff_nbhood Counts
1  Battery Park   Battery Park   1026
2 Carnegie Hill   Battery Park    126
3  Central Park   Battery Park    164
4       Chelsea   Battery Park   3028
5     Chinatown   Battery Park    182
6       Clinton   Battery Park   1171'

'*****************************************************'
'EXAMINE TRIP DISTANCE'
'*****************************************************'
# eliminated all levels from factor columns belong to neighborhoods outside Manhattan

# plot out % distribution of trip distances from 1-25 miles
rxHistogram(~ trip_distance, nyc_xdf, startVal = 0, endVal = 25, histType = "Percent", numBreaks = 20)
# see some trips are 0 miles or < 0 --> probably erroneous
# bump between 1-2 mi
# rather small bump from 16-20 miles (?)

## not many viz functions in RevoScaleR bc hard to do w/ big data (due to large scale of points, like maybe in scatterplot)
## histograms aren't as sensitive to a bunch of points

# limit to just trips in that second peak
rxs <- rxSummary(~ pickup_nbhood:dropoff_nbhood, nyc_xdf, rowSelection = (trip_distance > 15 & trip_distance < 22))

# look at top 10 most common pickup + dropoff pairs
head(arrange(rxs$categorical[[1]], desc(Counts)), 10)
'       pickup_nbhood    dropoff_nbhood Counts
1            Midtown           Midtown     50
2    Upper East Side   Upper East Side     22
3           Gramercy          Gramercy     19
4    Upper West Side   Upper West Side     14
5            Chelsea           Chelsea     13
6        Murray Hill       Murray Hill     11
7            Clinton           Clinton      9
8    Lower East Side   Lower East Side      8
9       East Village      East Village      7
10 Greenwich Village Greenwich Village      7'
# most popular trips from 15-22 miles are in same neighborhood?
# intuition would be that longer trips are in different neighborhoods, but these are not
# maybe taking same taxi across multiple errands or picking up friends
# need more data to confirm

'*****************************************************'
'EXAMINE OUTLIERS'
'*****************************************************'
# using rowSelection argument rxSummary = subset data,
# now use rowSelection to ID outliers
# come up with some kind of business logic for what we think should be an outlier (somewhat subjective)
# more determined based on what we think makes intuitive sense than anything particularly statistical.

odd_trips <- rxDataStep(nyc_xdf, rowSelection = (
  # believe that this current subset will be small but could still be a large dataframe
  # overwrite u col in data + only grab 5% of returned data after the transformation completes
  u < .05 & (
    # criteria for odd trip
    (trip_distance > 50 | trip_distance <= 0) | 
      (passenger_count > 5 | passenger_count == 0) |
      (fare_amount > 5000 | fare_amount <= 0)
    # generate a # random deviates based on # of rows in current chunk
  )), transforms = list(u = runif(.rxNumRows))) #rxNumRows always = size of current chunk of data

print(dim(odd_trips))
# 6.8k odd trips

# get trips over 50 miles and color-code if a trip took less than 10 minutes (data in seconds so *60)
odd_trips %>% 
  filter(trip_distance > 50) %>%
  ggplot() + geom_histogram(aes(fare_amount, fill = trip_duration <= 10*60), binwidth = 10) + 
  xlim(0,500)
ggsave("10_minute_trips_outliers.png")
# would expect fare_amounts to be high bc trips are long
# some have < $50 --> doesn't make much business sense = probably errors in data
# only see 2 color = all trips > 10 minutes so fare should def be high 

# check > 90 min
odd_trips %>% 
  filter(trip_distance > 50) %>%
  ggplot() + geom_histogram(aes(fare_amount, fill = trip_duration <= 90*60), binwidth = 10) + 
  xlim(0,500)
ggsave("90_minute_trips_outliers.png")
# there ARE cases w/ > 90 min trips (majority of cases)
# so long distance and long duration = possibly legitmate trip (green), so why low fare?
# investigate --> wrongly recorded distance? fare actually that small?


'*****************************************************'
'FILTER BY MANHATTAN'
'*****************************************************'
rxGetInfo(nyc_xdf, numRows = 10)
# notice some NA's in data --> could be trips that do not start or end in Manhattan or are not in Manhattan at all
# our shape file only limited to Manhattan --> 263 factor levels for pickup + dropoff nhoods to 28

# keep only rows + cols relevant to the analysis we want to perform in new XDF file
man_xdf <- RxXdfData('yellow_tripdata_2016_mahattan.xdf')

library(stringr)

rxDataStep(nyc_xdf, man_xdf, rowSelection = (
  passenger_count > 0 &
    trip_distance >= 0 & trip_distance < 30 &
    trip_duration > 0 & trip_duration < 60*60*24 & # 24 hours
    str_detect(pickup_borough, "Manhattan") &
    str_detect(dropoff_borough, "Manhattan") &
    !is.na(pickup_nbhood) &
    !is.na(dropoff_nbhood) &
    fare_amount > 0),
  transformPackages = "stringr",
  varsToDrop = c("extra", "mta_tax", "improvement_surcharge", "total_amount", 
                 "pickup_borough", "dropoff_borough", "pickup_nhood", "dropoff_nhood"),
  overwrite = TRUE)
# check file size = see majority of data carried over (157k KB to 114k KB)
# probably bc dropped cols, not filtered data

# began course by taking a sample of the data + storing it in a data frame that we carried around.
# do that now a second time, but this time for a RANDOM sample Manhattan XDF file (NOT 1st 1K rows)
# get 1% of data
man_sample <- rxDataStep(man_xdf, rowSelection = (u < .01), transforms = list(u = runif(.rxNumRows)))
dim(man_sample)

# ~ 29K rows = data frame we can use to visualize data in particular ways ro run a quick test on, etc.

rxImport(man_sample, outFile = "yellow_tripdata_2016_mahattan_sample.xdf", overwrite = T)


# In a good place = have data in a clean format w/ a bunch of new columns added to make the data richer.
# can get a bit more serious about analysis now + start asking more serious questions about the data, looking at more 
#   visualizations, + see what sorts of stories we can tell about this data.