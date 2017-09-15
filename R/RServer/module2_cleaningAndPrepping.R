'############## Module 2 - Reading + Prepping the data***********************************'
library(RevoScaleR)
library(tidyverse)

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
glimpse(jan)


## read in all 6 csv files + create an XDF file - stored on disk like CSV + is an object uniquely recognized by R 
library(lubridate) #dates and times
most_recent_date <- ymd("2016-07-01") # most recent CSV

time <- Sys.time()
library(utils)
unzip(zipfile = "yellow_tripsample_2016-01.zip")
unlink("yellow_tripsample_2016-01.csv")


# get each month's date + appned to 1st month's data
for(i in 1:6) {
  
  file_date <- most_recent_date - months(i)
  
  # return character vector with a combo of text & variable values + store in variable input_zip
  input_zip <- sprintf("yellow_tripsample_%s.zip", substr(file_date, 1, 7))
  
  #unzip specified zip file
  unzip(zipfile = input_zip)
  
  # get the CSV file name of unzipped file
  input_csv <- sprintf("yellow_tripsample_%s.csv", substr(file_date, 1, 7))
  
  # don't append if january data
  append <- if (i == 1) "none" else "rows"
  
  # import csv data into xdf file (similar to read.csv)
  rxImport(inData = input_csv, outFile = "yellow_tripdata_2016.xdf", colClasses = col_classes, overwrite = T, append = append)
  
  print(input_csv)
  
  # remove CSV file 
  unlink(input_csv)
  
}
# store time it took to import
Sys.time() - time

'Rows Read: 555880, Total Rows Processed: 555880, Total Chunk Time: 8.553 seconds 
[1] "yellow_tripsample_2016-06.csv"
Rows Read: 591985, Total Rows Processed: 591985, Total Chunk Time: 9.181 seconds 
[1] "yellow_tripsample_2016-05.csv"
Rows Read: 596987, Total Rows Processed: 596987, Total Chunk Time: 8.847 seconds 
[1] "yellow_tripsample_2016-04.csv"
Rows Read: 610255, Total Rows Processed: 610255, Total Chunk Time: 9.054 seconds 
[1] "yellow_tripsample_2016-03.csv"
Rows Read: 568348, Total Rows Processed: 568348, Total Chunk Time: 10.089 seconds 
[1] "yellow_tripsample_2016-02.csv"
Rows Read: 544498, Total Rows Processed: 544498, Total Chunk Time: 10.844 seconds 
[1] "yellow_tripsample_2016-01.csv"
> # store time it took to import
  > Sys.time() - time
Time difference of 11.30681 mins'

## XDF is much smaller due to compression --> each CSV is > 100MB, combined CSVs into XDF = 120MB