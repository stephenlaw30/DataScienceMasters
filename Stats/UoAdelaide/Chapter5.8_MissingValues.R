'#Learning Statistics with R - University of Adelaide

## Part IIIV - Working with Data

### Chapter 5 - Descriptive Stats
#### 5.8 - Missing Values'

partial <- c(10, 20, NA, 30)
mean(partial)

mean(partial, na.rm = T) #mean of 3 non-NA values

# cor() doesn't have na.rm

# use = "complete.obs" --> R will completely ignore all cases (rows/record) that have any missing values at all.
# use = "pairwise.complete.obs". --> R only looks at the variables it's trying to correlate when determining what to drop
#   - Ex: only missing value for observation 1 is for x1, R will only drop observation 1 when x1 is 1 of the variables involved
#   - R keeps observation 1 when trying to correlate x2 and x3

# correlate() function (in  lsr package) automatically uses the "pairwise complete" method

# The 2 approaches have different strengths and weaknesses.
#   - "pairwise complete" approach keeps more observations = making use of more data + improves reliability of the estimated correlation.
#       - also means every correlation in matrix is being computed from a slightly different set of observations
#       - can be awkward when you want to compare the different correlations 

# if you think the missing values were "chosen" completely randomly you'll probably want to use the pairwise method. 
# If you think the missing data are a cue to thinking the whole observation might be rubbish (e.g. someone selecting arbitrary survey responses)
#   but there's no pattern to which observations are "rubbish" it's probably safer to keep only observations that are complete. 
# If you think there's something systematic going on (some observations are more likely to be missing than others), you have a much trickier problem