'*****Question 1 - Is the increase in time spent studying from HS to college the same for nursing majors and biology majors?

1. Create a new variable that equals the difference in hours spent studying per week in college versus high school for each student. '

library(SDSFoundations)
post <- PostSurvey

post$hw_diff <- post$hw_hours_college - post$hw_hours_HS

'2. Create two vectors of those differences, one for nursing majors and one for biology majors.'

hw_diff_nursing <- post$hw_diff[post$major == 'Nursing']
hw_diff_bio <- post$hw_diff[post$major == 'Biology']


'1a. Which of the following methods should be used to answer the question above?'

# Two-sample independent t-test

'1b. Create a histogram to confirm the normality assumption for each sample. Has the normality assumption been met?'

library(ggplot2)
ggplot() + geom_histogram(aes(hw_diff_bio), binwidth = 4)
ggplot() + geom_histogram(aes(hw_diff_nursing), binwidth = 4)

# Both are relatively normal

'1c. Run the appropriate t-test for this analysis.'

t.test(hw_diff_bio,hw_diff_nursing)

'	Welch Two Sample t-test

data:  hw_diff_bio and hw_diff_nursing
t = -0.62301, df = 30.886, p-value = 0.5379
alternative hypothesis: true difference in means is not equal to 0
95% CI: (-8.531491,  4.539334)
sample estimates:
mean of x     mean of y 
10.47059      12.46667 

1f. Which of the following is an appropriate conclusion for this analysis (assuming ?? = .05)?'

# We fail to reject the null hypothesis; the increase in study time is the same for biology and nursing majors.