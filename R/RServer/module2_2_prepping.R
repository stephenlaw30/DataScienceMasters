'############## Module 2 - Reading + Prepping the data***********************************'
'############## Prepping data***********************************'

library(RevoScaleR)
library(tidyverse)

# read in XDF file
nyc_xdf <- RxXdfData("C:/Users/Nimz/Dropbox/yellow_tripdata_2016.xdf")

# check col types + show top 10 rows
rxGetInfo(nyc_xdf, getVarInfo = T, numRows = 10)

## b/c data is external, I/O is a considerable factor in run time
## need to be picky w/ transforms we actually NEED write out to data + which we can do on the fly

# rxDataStep = general purpose function for data processing

# create new tip_percent variable as percentage of total fare
rxDataStep(inData = nyc_xdf, outFile = nyc_xdf,
           # tranform arg expects a list
            transforms = list(tip_percent = 
                                ifelse(fare_amount > 0 & tip_amount < fare_amount,
                                       round((tip_amount / fare_amount)*100, 0), NA)),
           overwrite = T)

# get summary stats of new col
rxSummary(~tip_percent,nyc_xdf)
# high SD (~12%), max of 99%, min 0%, mean ~14%, see missing observations b/c condition not met in ifelse before

# do the same transform but faster via rxSummary directly = NO WRITING = on the fly
rxSummary(~ tip_percent2, nyc_xdf,
          transforms = list(tip_percent2 = 
                              ifelse(fare_amount > 0 & tip_amount < fare_amount,
                                     round((tip_amount / fare_amount)*100, 0), NA)))
# 1.242 seconds vs. much more

## subjective on when to do computations on fly or writing to disk (the dataset)
## can do same code on the fly in multiple places to potentially decrease run time, but makes code less modular
## prob worth to put in data if transform if complicated w/ heavy computation

# get counts of month-year combos on the fly bc month + year are not cols in our data
rxCrossTabs( ~ month:year, nyc_xdf,
             transforms = list(
               year = factor(as.integer(substr(tpep_pickup_datetime, 1, 4)), levels = 2014:2016),
               month = factor(as.integer(substr(tpep_pickup_datetime, 6, 7)), levels = 1:12)
             ))
#12.64 secs

# get counts of month-year combos on the fly bc month + year are not cols in our data
rxCrossTabs( ~ month:year, nyc_xdf,
             transforms = list(
               year = factor(year(ymd_hms(tpep_pickup_datetime)), levels = 2014:2016),
               month = factor(month(ymd_hms(tpep_pickup_datetime)), levels = 1:12)),
             transformPackages = "lubridate"
             )
#23.861 secs
# 2nd method = being very specific/explicit bc we're interested in potentially taking this code + moving to a cluster/SQL Server
#  in the future (other environments not on our machine)

'*****************************************************'
'COMPLEX TRANSFORMATIONS'
'*****************************************************'
# complex = usually good candidate for code to write out to data, possibly w/ very specific packages

# simple R start example --> wrap it in a function for RevoScaleR to use
library(lubridate)

weekday_labels <- c("Sun","Mon","Tue","Wed","Thu","Fri","Sat")
cut_levels <- c(1,5,9,12,16,18,22)
hour_labels <- c("1-5AM","5-9AM","9-12PM","12-4PM","4-6PAM","6-10PM","10-1AM")

pickup_datetime <- "2012-12-31 16:12:11"
# bin the hour of a datetime --> cut levels tells us what 2 hour cutoff an hour falls w/in
# make it NA if it falls between 10PM to 1AM
pickup_hour <- addNA(cut(hour(pickup_datetime), cut_levels))
pickup_dow <- factor(wday(pickup_datetime), levels = 1:7, labels = weekday_labels)
levels(pickup_hour) <- hour_labels

# more complex user-defined function containing lubridate functions to perform work above without us having
#   to write our own functions
# each time we load in "data" parameter - 1 chunck of data brought in + transformed + written to disk/analyzed on the fly
xforms <- function(data) {
  # transformation function to extract date + time features
  require(lubridate)
  
  weekday_labels <- c("Sun","Mon","Tue","Wed","Thu","Fri","Sat")
  cut_levels <- c(1,5,9,12,16,18,22)
  hour_labels <- c("1-5AM","5-9AM","9-12PM","12-4PM","4-6PAM","6-10PM","10-1AM")
  
  pickup_datetime <- ymd_hms(data$tpep_pickup_datetime, tz = "UTC")
  # bin the hour of a datetime --> cut levels tells us what 2 hour cutoff an hour falls w/in
  # make it NA if it falls between 10PM to 1AM
  pickup_hour <- addNA(cut(hour(pickup_datetime), cut_levels))
  pickup_dow <- factor(wday(pickup_datetime), levels = 1:7, labels = weekday_labels)
  levels(pickup_hour) <- hour_labels
  
  dropoff_datetime <- ymd_hms(data$tpep_dropoff_datetime, tz = "UTC")
  # bin the hour of a datetime --> cut levels tells us what 2 hour cutoff an hour falls w/in
  # make it NA if it falls between 10PM to 1AM
  dropoff_hour <- addNA(cut(hour(dropoff_datetime), cut_levels))
  dropoff_dow <- factor(wday(dropoff_datetime), levels = 1:7, labels = weekday_labels)
  levels(dropoff_hour) <- hour_labels
  
  # replace values in data w/ new values from above
  data$pickup_hour <- pickup_hour
  data$pickup_dow <- pickup_dow
  data$dropoff_hour <- dropoff_hour
  data$dropoff_dow <- dropoff_dow
  
  # create duration
  data$trip_duration <- as.integer(as.duration(dropoff_datetime - pickup_datetime))
  
  #return data
  data
}

# test with sample df before deploying to XDF file
col_classes <- c('VendorID' = "factor",
                 'tpep_pickup_datetime' = "character",
                 'tpep_dropoff_datetime' = "character",
                 'passenger_count' = "integer",
                 'trip_distance' = "numeric",
                 'pickup_longitude' = "numeric",
                 'pickup_latitude' = "numeric",
                 'RateCodeID' = "factor",
                 'store_and_fwd_flag' = "factor",
                 'dropoff_longitude' = "numeric",
                 'dropoff_latitude' = "numeric",
                 'payment_type' = "factor",
                 'fare_amount' = "numeric",
                 'extra' = "numeric",
                 'mta_tax' = "numeric",
                 'tip_amount' = "numeric",
                 'tolls_amount' = "numeric",
                 'improvement_surcharge' = "numeric",
                 'total_amount' = "numeric",
                 'u' = "numeric")

# load in 1st 1000 rows from january as a test data frame before deploying code to big data in RevoScaleR
jan <- read.csv(unz("yellow_tripsample_2016-01.zip", "yellow_tripsample_2016-01.csv"), nrow = 1000,
                colClasses = col_classes)
head(xforms(jan))
'pickup_hour pickup_dow dropoff_hour dropoff_dow trip_duration
10-1AM        Fri       10-1AM         Fri          1605
10-1AM        Fri       10-1AM         Fri          2526
10-1AM        Fri       10-1AM         Fri           566
10-1AM        Fri       10-1AM         Fri           324
10-1AM        Fri       10-1AM         Fri           219
10-1AM        Fri       10-1AM         Fri          1503'

# test again w/ rxDataStep (works w/ data frames, XDF files, or a flat file) + be explicit about function used + packages used
head(rxDataStep(jan, transformFunc = xforms, transformPackages = "lubridate"))

# now actually write to file
nyc_xdf <- RxXdfData("C:/Users/Nimz/Dropbox/yellow_tripdata_2016.xdf")

# check how long it took as well
st <- Sys.time()
rxDataStep(inData = nyc_xdf, outFile = nyc_xdf, overwrite = T, transformFunc = xforms, transformPackages = "lubridate")
Sys.time() - st
'Time difference of 53.13742 secs'

'*****************************************************'
'EXAMINING NEW COLS'
'*****************************************************'
# get summary stats for pickup hour, DOW, and trip duration
rxs1 <- rxSummary(~ pickup_hour + pickup_dow + trip_duration, nyc_xdf)
' Name          Mean     StdDev   Min      Max      ValidObs MissingObs
 trip_duration 956.5004 9256.298 -8018875 10764064 3467953  0         

Category Counts for pickup_hour
Number of categories: 7
Number of valid observations: 3467953
Number of missing observations: 0

pickup_hour Counts
1-5AM       190066
5-9AM       531661
9-12PM      488519
12-4PM      672289
4-6PAM      397188
6-10PM      805985
10-1AM      382245

Category Counts for pickup_dow
Number of categories: 7
Number of valid observations: 3467953
Number of missing observations: 0

pickup_dow Counts
Sun        463950
Mon        446388
Tue        483912
Wed        497739
Thu        520793
Fri        532177
Sat        522994
> '

# see numerical summary for numerical variable trip_duration and counts for categorical variables
# add col for proportions next to counts (apply only to categorical variables in the XDF object)
rxs1$categorical <- lapply(rxs1$categorical, function(x) cbind(x, prop = round(prop.table(x$Counts), 2)))
rxs1
' pickup_hour Counts prop
 1-5AM       190066 0.05
5-9AM       531661 0.15
9-12PM      488519 0.14
12-4PM      672289 0.19
4-6PAM      397188 0.11
6-10PM      805985 0.23
10-1AM      382245 0.11

Category Counts for pickup_dow
Number of categories: 7
Number of valid observations: 3467953
Number of missing observations: 0

pickup_dow Counts prop
Sun        463950 0.13
Mon        446388 0.13
Tue        483912 0.14
Wed        497739 0.14
Thu        520793 0.15
Fri        532177 0.15
Sat        522994 0.15'

# get summary of combo of pickup_dow + pickup_hour
rxs2 <- rxSummary(~ pickup_dow:pickup_hour, nyc_xdf)
rxs2
' pickup_dow pickup_hour Counts
 Sun        1-5AM        52353
Mon        1-5AM        15252
Tue        1-5AM        14022
Wed        1-5AM        15674
Thu        1-5AM        17854
Fri        1-5AM        27306
Sat        1-5AM        47605
Sun        5-9AM        37320
Mon        5-9AM        81152....'

# use tidyr's spread() to reshape the dataframe into a wide format
rxs2 <- tidyr::spread(rxs2$categorical[[1]], key = "pickup_hour", value = "Counts")
rxs2
'  pickup_dow 1-5AM 5-9AM 9-12PM 12-4PM 4-6PAM 6-10PM 10-1AM
1        Sun 52353 37320  70107  99426  51313  84650  68781
2        Mon 15252 81152  63641  91297  56706 105086  33254
3        Tue 14022 91903  69212  94070  57814 119665  37226
4        Wed 15674 92442  70813  93404  57007 125151  43248
5        Thu 17854 94248  71374  96046  58646 131551  51074
6        Fri 27306 88143  70273  96077  58413 125744  66221
7        Sat 47605 46453  73099 101969  57289 114138  82441'

# rename rows
row.names(rxs2) <- rxs2[,1]
rxs2

# make this into a matrix, removing 1st col
rxs2 <- as.matrix(rxs2[,-1])
rxs2
class(rxs2)

# plot this matrix's proportions along the rows (2nd arg of prop.table = 2) as a level plot (heat map almost)
levelplot(prop.table(rxs2, 2), cuts = 4, xlab = "", ylab = "", main == "Distribution of Taxis by Day of Week")
# see spikes around 1-5AM on Sat + Sun = late night crowd coming home from going out on Fri + Sat nights, with another light spike
#   at 10PM-1AM on Saturday, a bit of early-birds who still went out
# darker pink during hours people are likely going to work or church or morning travels