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
nyc_xdf <- RxXdfData("yellow_tripdata_2016.xdf")

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

'*****************************************************'
'PLOTTING NEIGHBORHOODS'
'*****************************************************'
# R Server +  RevoScaleR has a particular requirement in the way a function has to be set up
#   - takes in data as its input + usually modifies it somehow + returns it back.
#   - once data is brought in as an input to a function, it unpacks as a list.
#   - majority of cases, this is fine for us, but is something to be aware of when performing certain transformss that 
#       require us to take the list + reshape it back into a data frame.
#   - data is coming in chunk by chunk --> trickiness = have to avoid performing computations on the data (such as computing sums or
#       averages + thinking its is happening for whole of data
#   - if computing minimum inside a transformation function, its computing a separate minimum for each chunk of the data 
#       as it's being brought in.
#   - correct way of doing = perform the computation OUTSIDE using one of the RX functions(rxSummary)
#     - Once we have the minimum, can then go + put it inside of the transformation function as the GLOBAL minimum 

## Use GIS packages to extract some info out of the data.
library(rgeos)
library(sp)
library(maptools)
library(stringr) # str_detect

# get shape file of Zillow neighborhoods w/ info about NYC
nyc_shape <- readShapePoly("ZillowNeighborhoods-NY.shp")
# many programming languages have APIs for reading shape files (popular format for strong GIS info)

# subset shape file to only info about Manhattan
mht_shape <- subset(nyc_shape, str_detect(CITY, "New York City-Manhattan"))

# see what sort of information is in there.
mht_shape@data
mht_shape@data$NAME
# shape file = not standard idea of data (tabular)
# - has some tabular info but also non-tabular info = a more complex type of data format than a data frame would be.
# - encodes some info about neighborhoods such as their names, etc. + neighborhood boundaries so we know how to draw them on a map.

# create new ID field by formatting NAME field to character
mht_shape@data$id <- as.character(mht_shape@data$NAME)
mht_shape@data
'   STATE   COUNTY                    CITY                NAME REGIONID                  id
1      NY New York New York City-Manhattan        West Village   270964        West Village
4      NY New York New York City-Manhattan        East Village   270829        East Village
13     NY New York New York City-Manhattan        Battery Park   272869        Battery Park'

# use fortify() to fortify data w/ a model
# w/ gBuffer - expand given geometry to include area w/in specified width
mht_points <- fortify(gBuffer(mht_shape, byid = T, width = 0), region = "NAME")
'         long      lat order  hole piece                  id                 group
1   -74.01243 40.71954     1 FALSE     1        Battery Park        Battery Park.1
2   -74.01310 40.71569     2 FALSE     1        Battery Park        Battery Park.1
3   -74.01429 40.71135     3 FALSE     1        Battery Park        Battery Park.1'

# join this new LAT/LONG data back into shape file
mht_df <- inner_join(mht_points, mht_shape@data, by = "id")
head(mht_df)
'       long      lat order  hole piece           id          group STATE   COUNTY                    CITY         NAME REGIONID
1 -74.01243 40.71954     1 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869
2 -74.01310 40.71569     2 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869
3 -74.01429 40.71135     3 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869
4 -74.01657 40.70561     4 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869
5 -74.01632 40.70498     5 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869
6 -74.01651 40.70432     6 FALSE     1 Battery Park Battery Park.1    NY New York New York City-Manhattan Battery Park   272869'

# get the median latitude and longitude for each neighorhood (id)
library(dplyr)
mht_center <- mht_df %>%
  group_by(id) %>%
  summarize(long = median(long), lat = median(lat))

head(mht_center)
'          <chr>     <dbl>    <dbl>
1  Battery Park -74.01726 40.70794
2 Carnegie Hill -73.95577 40.78554
3  Central Park -73.95835 40.78513
4       Chelsea -74.00917 40.75125
5     Chinatown -73.99823 40.71606
6       Clinton -74.00323 40.76216'

# use these medians to draw a map of Manhattan that shows each neighborhood w/ its name superimposed on the map itself.
library(ggrepel)
ggplot(mht_df, aes(long, lat, fill = id)) + 
  geom_polygon() + 
  geom_path(color = "white") +      # connect observations in order they appear w/ white border
  coord_equal() +                   # use fixed scale coordinate system
  theme(legend.position = "none") + # remove legend
  geom_text_repel(aes(label = id), data = mht_center, size = 2) # place ID label (neighborhood name) over median lat + long coordinates

'*****************************************************'
'ADDING NEIGHBORHOODS'
'*****************************************************'
# complex transform to go to the coordinates pickup + drop-off + find their neighborhoods

### TEST ON SAMPLE DATA FIRST
# extract coordinate columns for all PICKUP LOCATIONS, replace NA w/ 0
# use transmute to edit/add cols, but only keep those mentioned in the function (lat + long)
#   - mutate() keeps those NOT mentioned
nyc_coords <- jan %>%
  transmute(long = ifelse(is.na(pickup_longitude),0,pickup_longitude),
            lat = ifelse(is.na(pickup_latitude),0,pickup_latitude))

# specify cols to coordinates() pointer function to find "lat" + "long" cols in nyc_coords + treat them as coordinates
coordinates(nyc_coords) <- c("long", "lat")

# at the spatial locations each data coordinate pair (x), retrieve the indexes/attributes from the spatial object mht_shape (y)
# this uses lat + long from nyc_coords to find which neighborhood in mht_shape its coordinates fall into
nhoods <- over(nyc_coords,mht_shape)

# rename cols to specify pickup data
names(nhoods) <- paste("pickup", tolower(names(nhoods)), sep = "_")

# combine this new neighborhood info w/ the original data (adds pickup city (+ borough) + pickup_name (neighborhood))
#   - add only cols with the words "name" or "city" in the column name
jan <- cbind(jan, nhoods[, grep("name|city", names(nhoods))])
head(jan)

## this works, so do the same to the XDF file w/in a wrapper function
find_nhoods <- function(data) {
  
  pickup_longitude <- ifelse(is.na(data$pickup_longitude),0,data$pickup_longitude)
  pickup_latitude <- ifelse(is.na(data$pickup_latitude),0,data$pickup_latitude)
  
  # make dataframe to hold lat + long
  data_coords <- data.frame(long = pickup_longitude, lat = pickup_latitude)
  
  # treat coordinate cols in the data frame as actual coordinates
  coordinates(data_coords) <- c("long", "lat")
  
  # use lat + long to find which neighborhood in mht_shape the pair falls into
  nhoods <- over(data_coords,shapefile)
  
  # addo nly drop-off neighborhood + city cols to data
  data$pickup_nhood <- nhoods$NAME  
  data$pickup_borough <- nhoods$CITY
  
  # do same for drop-offs
  dropoff_longitude <- ifelse(is.na(data$dropoff_longitude),0,data$dropoff_longitude)
  dropoff_latitude <- ifelse(is.na(data$dropoff_latitude),0,data$dropoff_latitude)
  
  # make dataframe to hold lat + long
  data_coords <- data.frame(long = dropoff_longitude, lat = dropoff_latitude)
  
  # treat coordinate cols in the data frame as actual coordinates
  coordinates(data_coords) <- c("long", "lat")
  
  # use lat + long to find which neighborhood in mht_shape the pair falls into
  nhoods <- over(data_coords,shapefile)
  
  # addo nly drop-off neighborhood + city cols to data
  data$dropoff_nhood <- nhoods$NAME  
  data$dropoff_borough <- nhoods$CITY
  
  #return data
  data
}

# test function w/ rxDataStep
head(rxDataStep(jan, transformFunc = find_nhoods, transformPackages = c("sp", "maptools"),
                transformObjects = list(shapefile = mht_shape)))

# run data on actual XDF data file
st <- Sys.time()
rxDataStep(nyc_xdf, nyc_xdf, overwrite = T, transformFunc = find_nhoods, transformPackages = c("sp", "maptools","rgeos"),
           transformObjects = list(shapefile = mht_shape))
Sys.time() - st
'Time difference of 1.755261 mins'

# get 1st 5 rows of resulting dataframe
rxGetInfo(nyc_xdf, numRows = 5, getVarInfo = T)

# save new XDF file
rxImport(inData = nyc_xdf, outFile = "yellow_tripdata_2016_prepped.xdf", colClasses = col_classes, overwrite = T)

'Started w/ initial dataset + made it a richer dataset, as far as analyzing is concerned, by adding new features to it.
  In some cases, features added were pretty simple features + in some cases, had to do some more complex transformations to
  get those features.

Going to spend quite a bit of time looking at those features, trying to visualize them, make sense of them. + tie them 
together into a coherent story about what we see in the data.'