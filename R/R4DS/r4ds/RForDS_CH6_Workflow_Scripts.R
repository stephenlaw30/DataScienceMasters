## ctrl + enter = run current expression (where cursor is)
## ctrl + shift + s = run whole script
library(tidyverse)
library(nycflights13)

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))