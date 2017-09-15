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

