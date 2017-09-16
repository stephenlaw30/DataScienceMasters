# load packages
library(RevoScaleR)
library(ggplot2)
library(tidyverse)

# use provided NYC taxi XDF file for lab 1
nyc_xdf <- RxXdfData("nyc_lab1.xdf")

## 1) Based on info in the data dictionary, run a transformation that converts RatecodeID + payment_type into factor columns (if not already) 
##      with the proper labels. 
## 2) Name the new variables Ratecode_type_desc and payment_type_desc.
## 3) For Ratecode_type_desc, use all levels as described in data dictionary + those not in any of the labels = missing values
## 4) For payment_type_desc, lump anything that isn't card or cash into missing values.

rxGetInfo(nyc_xdf, numRows = 5, getVarInfo = T)
# RatecodeID is currently an INT, payment_type is already a factor
# RatecodeID goes from 1-6, w/ 99 = NA

factor_ratecode <- function(data) { # transformation function for converting RatecodeID to a factor variable
  
  # set levels for RatecodeID based on value in data dictionary
  rate_levels <- c("Standard rate", "JFK", "Newark", "Nassau or Westchester", "Negotiated fare", "Group ride")
  payment_levels <- c("Credit card", "Cash")
  
  data$Ratecode_type_desc <- addNA(factor(data$RatecodeID, levels = c(1:6), labels = rate_levels))
  data$payment_type_desc <- addNA(factor(data$payment_type, levels = 1:2, labels = payment_levels)) # already a factor, but need new levels
  
  data
}

# inspect counts of RatecodeID levels
rxSummary(~ as.factor(RatecodeID) + payment_type, nyc_xdf)

# test on sample dataframe
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
jan <- read.csv(unz("C:/Users/Nimz/Dropbox/DataScienceMasters/R/RServer/yellow_tripsample_2016-01.zip", "yellow_tripsample_2016-01.csv"), nrow = 1000,
                colClasses = col_classes)

#table(addNA(factor(jan$RatecodeID, levels = c(1:6,99), labels = rate_levels)))
rxGetInfo(jan, numRows = 5, getVarInfo = T)
jan <- rxDataStep(jan, transformFunc = factor_ratecode)
table(jan$Ratecode_type_desc)
table(jan$payment_type_desc)

# run function on XDF file
rxDataStep(nyc_xdf, nyc_xdf, overwrite = TRUE, transformFunc = factor_ratecode)

# check that variables are indeed factors and the NA's were counted
rxGetInfo(nyc_xdf, numRows = 5, getVarInfo = T)
rxSummary(~ Ratecode_type_desc + payment_type_desc, nyc_xdf)