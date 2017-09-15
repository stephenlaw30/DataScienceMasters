'############## Module 2 - Reading + Prepping the data***********************************'

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