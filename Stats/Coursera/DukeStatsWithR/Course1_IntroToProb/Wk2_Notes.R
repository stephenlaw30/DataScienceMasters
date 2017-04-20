#COURSERA STATS W/ R SPECIALIZATION
# - COURSE 1 - Introduction to Probability and Data
#   - WEEK 2 - Exploratory Data Analysis and Introduction to Inference

'Data here comes from Gapminder, which pulls info from a variety of data sources + we will be working with 2 numerical variables: Income
per person, in $, and life expectancy, in years, for the year 2012, from different countries 

Scatterplot --> used for 2 quantitative/numerical variables --> ID which variable is suspected to be explanatory and plot on x with 
response on y (suspect income affects life exp.)
  * does not guarentee CAUSAL relationship, even if association is IDed

Important things to note when evaluating relationships between numerical variables
  * direction = positive or negative
  * shape = linear, straight, curved, exponential, logistic, etc.
  * strength = little/lots of scatter
  * outliers

Would expect a histogram of peoples birthdays in a neighborhood to be uniform, as people have equal chances of being born in the 
beginning, middle, and end of the month

**sample statistics** are **point estimates** of **population parameters**

**range** easy to calculate but relies on most extreme values so very sensitive to outliers

more reliable **measures of spread** measure how close/far the bulk of the data lie from the center of the distribution:
  * variance = avg. squared deviation from the mean = s^2 for sample, sigma^2 for population
    * difference between mean and each observation, square each, then sum them, and divide by n-1 for sample
    * units = square units of original data --> not useful to present/interpret
    * square to get Abs Values so pos and neg dont cancel and to make larger deviations be weighed more heavily
  * SD = avg. deviation from mean calculated in same units as the data = s and sigma --> Sqrt(variation)
  * IQR = middle 50% of data (3Q - 1Q --> 75% - 25%) --> more reliable since it does not rely on endpoints so is not sensitive to extremes

**variability** vs **Diversity**
  * diverse = more different/unique values (5 colors vs 2 colors)
  * variability = wider distribution of values (more data at ends of distribution = more variable, like less observations near mean)