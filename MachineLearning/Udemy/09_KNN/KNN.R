library(tidyverse)
library(caTools)
library(ggplot2)
library(ElemStatLearn)
library(broom)

## import data
social <- read_csv("Social_Network_Ads.csv")
dim(social)
summary(social)
glimpse(social)

'Social network`s automotive business client has launched its brand new luxury SUV and purchased ads for its marketing campaign. The 
social network collected data on the users and whether or not the bought the SUV after seeing the ad

We will only use age and salary to predict this'
